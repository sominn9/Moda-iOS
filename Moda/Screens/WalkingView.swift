//
//  WalkingView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import CoreMotion
import MapKit

struct WalkingView: View {

    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
      
    // Binding to home view's property
    @Binding var pushed: Bool
    
    // Properties for view model
    @EnvironmentObject private var dbViewModel: DBViewModel
    @StateObject private var mapViewModel = MapViewModel()
    
    // Properties to store temporary value
    @State private var isResultView = false
    @State private var currentTime: Int = 0
    @State private var currentTimeString: String = "00:00:00"
    @State private var steps: Int = 0
    private let startDate: Date = Date()
    
    var body: some View {
        
        ZStack {
            
            MapView(viewModel: self.mapViewModel,
                    startLocationService: true)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 10) {
                // MARK: - HEADER
                timeField
                Spacer()
                
                // MARK: - FOOTER
                stopButton
                
            } //: VSTACK
            .padding(.horizontal, 10)
        
        }
        .onAppear {
            HealthKitManager.shared.requestAuthorization()
        }
        
    }
    
}

private extension WalkingView {
    
    var timeField: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("ColorBlack"))
            .overlay(alignment: .center) {
                
                Text(currentTimeString)
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 45, weight: .bold))
                    .onReceive(timer) { _ in
                        currentTime += 1
                        currentTimeString = timeToString(currentTime, format: 1)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        // 앱이 백그라운드로 간 시각을 저장한다
                        UserDefaults.standard.set(Date(), forKey: "startTime")
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        // 백그라운드에서 머문 시간을 계산해서 타이머에 더해준다
                        let now = Date()
                        let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date
                        let interval = now.timeIntervalSince(startTime ?? now)
                        currentTime += Int(interval)
                        currentTimeString = timeToString(currentTime, format: 1)
                    }
                
            }
            .frame(height: 100)
            .shadow(radius: 10)
    }
    
    var stopButton: some View {
        NavigationLink(
            destination: ResultView(pushed: $pushed)
                .environmentObject(dbViewModel),
            isActive: $isResultView,
            label: {
                Text("종료하기")
            })
            .simultaneousGesture(TapGesture().onEnded { _ in
                // Stop the timer
                timer.upstream.connect().cancel()
                
                // Stop updating location
                mapViewModel.locationManager?.stopUpdatingLocation()
                
                // Save the walking data
                let walk = Walk()
                walk.time = self.currentTime
                walk.points.append(objectsIn: mapViewModel.points.map { point in
                    let location = Location()
                    location.latitue = point.latitude
                    location.longitude = point.longitude
                    return location
                })
                
                // Query step data from HealthKit
                HealthKitManager.shared.readStepCount(start: startDate, completion: { steps in
                    walk.steps = steps
                })
                
                dbViewModel.walk = walk
                  
                // Go to result view
                self.isResultView.toggle()
            })
            .buttonStyle(CustomButton(colorName: "ColorBlack", colorOpacity: 1.0))
            .shadow(radius: 10)
    }
    
}

struct WalkingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingView(pushed: .constant(true))
            .environmentObject(DBViewModel())
    }
}
