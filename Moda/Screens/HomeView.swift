//
//  HomeView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/17.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - HEADER
                HStack {
                    VStack(alignment: .leading) {
                        Text("Moda")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.accentColor)
                        Text("walk diary")
                            .font(.system(.title3))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .offset(y: -5)
                    }
                    Spacer()
                }
                
                // MARK: - CENTER
                Spacer()
                NavigationLink(destination: WalkingView()
                                .navigationTitle("")
                                .navigationBarHidden(true)) {
                    
                    // Click Button
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.accentColor)
                        .frame(height: 250, alignment: .center)
                        .overlay(alignment: .center) {
                            Image("pattern1")
                                .resizable()
                                .scaleEffect(CGSize(width: 1.0, height: -1.0))
                                .offset(x: -150, y: -120)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .opacity(0.3)
                            
                            Image("pattern2")
                                .resizable()
                                .offset(x: 120, y: -100)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .opacity(0.3)
                            
                            Image("bao-black-kitten-4")
                                .resizable()
                                .scaledToFit()
                                .offset(y: isAnimating ? -100 : -80)
                                .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
                            
                            Text("클릭해서 산책시작")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                                .offset(y: 85)
                                .opacity(0.9)
                        } //: OVERLAY
                        .scaleEffect(isAnimating ? 1 : 0.5)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                }
                Spacer()
                
                // MARK: - FOOTER
                HStack(alignment: .center, spacing: 70) {
                    // 1. List Button
                    MenuButton(menuIcon: "list", menuTitle: "List")
                    
                    // 2. Chart Button
                    MenuButton(menuIcon: "chart", menuTitle: "Chart")
                    
                    // 3. Later...
                    MenuButton(menuIcon: "setting", menuTitle: "Setting")
                    
                } //: FOOTER
                .padding(.bottom, 30)
                
            } //: VSTACK
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .onAppear {
                isAnimating = true
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
