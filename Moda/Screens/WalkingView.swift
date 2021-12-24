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
    private let pedometer = CMPedometer()
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() &&
            CMPedometer.isStepCountingAvailable()
    }
    
    @Binding var pushed: Bool
    
    @State private var isAnimating: Bool = false
    @State private var currentTime: Int = 0
    @State private var currentTimeString: String = "00:00:00"
    @State private var steps: Int = 0
        
    private func initializePedometer() {
        if isPedometerAvailable {
            pedometer.startUpdates(from: .now) { data, error in
                guard let data = data, error == nil else { return }
                steps = data.numberOfSteps.intValue
            }
        }
    }
    
    private func timeToString(_ time: Int) -> String {
        var time: Int = time
        var second: Int = 0
        var minute: Int = 0
        var hour: Int = 0

        // seconds
        second = time % 60
        time /= 60

        // minutes, hours
        minute = time % 60
        hour = time / 60
        
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                // MARK: - HEADER
                Text(currentTimeString)
                    .font(.system(size: 55, weight: .bold))
                    .onReceive(timer) { _ in
                        currentTime += 1
                        currentTimeString = timeToString(currentTime)
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
                        currentTimeString = timeToString(currentTime)
                    }
                
                // MARK: - CENTER
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("ColorDarkRed"))
                    .background(content: {
                        Image("bao-black-kitten-2")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .offset(y: isAnimating ? -130 : -50)
                            .animation(.easeOut(duration: 2), value: isAnimating)
                    })
                    .overlay(alignment: .center) {
                        VStack(spacing: 0) {
                            Text("걸음수: \(steps)")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                            
                            MapView()
                        }
                    }
                    .frame(height: 430, alignment: .center)
                    .padding(.top, 75)
                Spacer()
                
                // MARK: - FOOTER
                NavigationLink(destination: ResultView(pushed: $pushed)
                                .navigationTitle("")
                                .navigationBarHidden(true)) {
                    Text("종료하기")
                    
                } //: FOOTER
                .onTapGesture {
                    self.timer.upstream.connect().cancel()
                }
                .buttonStyle(CustomButton())
                
            } //: VSTACK
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
        } //: ZSTACK
        .onAppear {
            isAnimating = true
            initializePedometer()
        }
    }
}

struct WalkingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingView(pushed: .constant(true))
    }
}
