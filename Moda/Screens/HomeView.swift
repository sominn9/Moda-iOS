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
        VStack {
            // MARK: - HEADER
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("Moda")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.accentColor)
                    Text("walk diary")
                        .font(.system(.title3))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            
            // MARK: - CENTER
            Spacer()
            Spacer()
            Rectangle()
                .fill(Color.accentColor)
                .cornerRadius(20)
                .frame(height: 370, alignment: .center)
                .padding(.horizontal, 20)
                .overlay(alignment: .center) {
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .offset(y: isAnimating ? -70 : -50)
                        .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
                    
                    Text("Click to record")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .offset(y: 150)
                }
                .scaleEffect(isAnimating ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.5), value: isAnimating)
            Spacer()
            
            // MARK: - FOOTER
            HStack {
                // 1. List Button
                Button {
                    
                } label: {
                    VStack {
                        Image("list")
                            .font(.system(size: 50, weight: .ultraLight))
                            .foregroundColor(.primary)
                        Text("List")
                            .font(.system(size: 17))
                            .fontWeight(.light)
                            .foregroundColor(.primary)
                    }
                }
                .padding()

                // 2. Chart Button
                Button {
                    
                } label: {
                    VStack {
                        Image("chart")
                            .font(.system(size: 50, weight: .ultraLight))
                            .foregroundColor(.primary)
                        Text("Chart")
                            .font(.system(size: 17))
                            .fontWeight(.light)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                
            } //: FOOTER
            Spacer()
        } //: VSTACK
        .onAppear {
            isAnimating = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
