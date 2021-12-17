//
//  ContentView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/17.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    var body: some View {
        if isOnboardingViewActive {
            OnboardingView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
