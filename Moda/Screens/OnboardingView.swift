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
        ["Walk.", "매일 매일의 산책을 기록하세요.", "NEXT"],
        ["Record.", "산책 경로를 저장했다가 나중에 다시 볼 수 있습니다.", "START"]
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            // MARK: - HEADER
            HStack {
                Text(text[page - 1][0])
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color("ColorRed"))
                    .transition(.opacity)
                    .id(text[page - 1][0])
                Spacer()
            }
            Spacer()
            
            // MARK: - CENTER
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 340, height: 340, alignment: .center)
                        .opacity(isAnimating ? 0.2 : 0)
                        .scaleEffect(isAnimating ? 1 : 0.5)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                    
                    Image("onboarding")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .offset(y: -20)
                .overlay(alignment: .bottom) {
                    Text(text[page - 1][1])
                        .font(.system(.body))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .lineSpacing(7)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .padding(20)
                        .offset(y: 50)
                        .id(text[page - 1][1])
                }
            }
            
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
                        .transition(.opacity)
                        .id(text[page - 1][2])
                }
                .padding(10)
            }
            
        } //: VStack
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
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
