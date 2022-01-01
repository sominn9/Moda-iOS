//
//  HomeView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/17.
//

import SwiftUI

struct HomeView: View {
    
    let dbViewModel = DBViewModel()
    
    @State private var isAnimating: Bool = false
    @State private var pushed: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 3) {
                    // MARK: - HEADER
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Moda")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(Color("ColorRed"))
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
                    NavigationLink(
                        destination: WalkingView(pushed: self.$pushed)
                            .environmentObject(dbViewModel)
                            .navigationTitle("")
                            .navigationBarHidden(true),
                        isActive: self.$pushed,
                        label: {
                            // Click Button
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("ColorRed"))
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
                                    
                                    Text("산책 시작")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.white)
                                        .offset(y: 80)
                                        .opacity(0.9)
                                    
                                } //: OVERLAY
                                .frame(minHeight: 350)
                                .offset(y: 50)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        }
                    ) //: CENTER
                    Spacer()
                    
                    // MARK: - FOOTER
                    NavigationLink(
                        destination: {
                            DiaryListView()
                                .environmentObject(dbViewModel)
                                .navigationTitle("Diary")
                                .navigationBarTitleDisplayMode(.large)
                                .navigationBarBackButtonHidden(false)
                        },
                        label: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.85))
                                .frame(height: 200)
                                .overlay {
                                    Text("산책 기록보기")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.white)
                                        .offset(y: 55)
                                        .opacity(0.9)
                                    
                                    Image("book")
                                        .resizable()
                                        .scaledToFit()
                                        .grayscale(1)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .opacity(0.3)
                                        .padding(30)
                                        .offset(x: -140, y: -50)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                        }
                    ) //: FOOTER
                    
                } //: VSTACK
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .onAppear {
                    isAnimating = true
                }
                .navigationTitle("Moda")
                .navigationBarHidden(true)
            } // SCROLL
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
