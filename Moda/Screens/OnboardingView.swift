//
//  OnboardingView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/17.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    @State private var isAnimating: Bool = false
    @State private var page: Int = 1
    
    @State private var text: [[String]] = [
        ["Walk.", "Record your walk.", "NEXT"],
        ["Diary.", "You can record the walking route.", "START"]
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            // MARK: - HEADER
            Spacer()
            HStack {
                Text(text[page - 1][0])
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.accentColor)
                    .transition(.opacity)
                    .id(text[page - 1][0])
                    .padding(.horizontal, 30)
                Spacer()
            }
            Spacer()
            
            // MARK: - CENTER
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 340, height: 340, alignment: .center)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .animation(.easeOut(duration: 1), value: isAnimating)
                
                Image("onboarding" + String(page))
                    .resizable()
                    .scaledToFit()
                    .padding(30)
            }
            
            Text(text[page - 1][1])
                .font(.system(.title3))
                .fontWeight(.light)
                .foregroundColor(.gray)
                .transition(.opacity)
                .id(text[page - 1][1])
            
            // MARK: - FOOTER
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        if page <= 1 {
                            page += 1
                        } else {
                            isOnboardingViewActive = false
                        }
                    }
                } label: {
                    Text(text[page - 1][2])
                        .font(.system(.title3))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .transition(.opacity)
                        .id(text[page - 1][2])
                }
            }
            
        } //: VStack
        .onAppear {
            isAnimating = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
