//
//  WalkingView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import CoreMotion

struct WalkingView: View {

    private let pedometer = CMPedometer()
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
            CMPedometer.isDistanceAvailable() &&
            CMPedometer.isStepCountingAvailable()
    }
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
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
                        UserDefaults.standard.set(Date(), forKey: "startTime")
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        let now = Date()
                        let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date
                        let interval = now.timeIntervalSince(startTime ?? now)
                        currentTime += Int(interval)
                        currentTimeString = timeToString(currentTime)
                    }
                
                // MARK: - CENTER
                Spacer()
                VStack {
                    ZStack {
                        Circle()
                            .fill(.black)
                            .opacity(0.2)
                        
                        Image("bao-black-kitten-5")
                            .resizable()
                            .scaledToFit()
                            .padding(50)
                            .scaleEffect(isAnimating ? 1.0 : 0.5)
                            .animation(.spring(), value: isAnimating)
                    }
                    
                    Text("걸음수: \(steps)")
                        .font(.system(size: 17, weight: .regular))
                    
                } //: CENTER
                Spacer()
                
                // MARK: - FOOTER
                NavigationLink(destination: ResultView()
                                .navigationTitle("")
                                .navigationBarHidden(true)) {
                    
                    // Stop Button
                    Button("종료하기") {
                        self.pushed = false
                        self.timer.upstream.connect().cancel()
                    }
                    .buttonStyle(CustomButton())

                } //: FOOTER
                
            } //: VSTACK
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
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
