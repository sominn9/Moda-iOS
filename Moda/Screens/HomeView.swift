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
                    header
                    
                    // MARK: - CENTER
                    Spacer()
                    recordButton
                    Spacer()
                    
                    // MARK: - FOOTER
                    historyButton
                    
                } //: VSTACK
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .navigationTitle("Moda")
                .navigationBarHidden(true)
                .onAppear {
                    isAnimating = true
                }
                
            } //: SCROLL VIEW
            
        } //: NAVIGATION VIEW
        .navigationViewStyle(.stack)
        
    }
    
}

private extension HomeView {
    
    var header: some View {
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
    }
    
    var recordButton: some View {
        VStack {
            Spacer()
            
            NavigationLink(
                destination: WalkingView(pushed: self.$pushed)
                    .environmentObject(dbViewModel)
                    .navigationTitle("")
                    .navigationBarHidden(true),
                isActive: self.$pushed,
                label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("ColorRed"))
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                            .overlay(alignment: .center) {
                                
                                Text("산책 시작")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                                    .offset(y: UIScreen.main.bounds.height * 0.3 * 0.25)
                                    .opacity(0.9)
                                
                                Image("pattern1")
                                    .resizable()
                                    .scaleEffect(CGSize(width: 1.0, height: -1.0))
                                    .offset(x: -(UIScreen.main.bounds.width * 0.35), y: -100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .opacity(0.3)
                                
                                Image("pattern2")
                                    .resizable()
                                    .offset(x: UIScreen.main.bounds.width * 0.35, y: -100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .opacity(0.3)
                            
                            } //: OVERLAY
                        
                        Image("bao-black-kitten-4")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/4)
                            .offset(y: isAnimating ?  -UIScreen.main.bounds.height/8 : -(UIScreen.main.bounds.height/8 + 10))
                            .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
                    }
                })
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
    
    var historyButton: some View {
        NavigationLink(
            destination: DiaryListView()
                .environmentObject(dbViewModel)
                .navigationTitle("Diary")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden(false),
            label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.85))
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .overlay {
                        Text("산책 기록보기")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                            .offset(y: UIScreen.main.bounds.height * 0.3 * 0.25)
                            .opacity(0.9)
                        
                        Image("book")
                            .resizable()
                            .scaledToFit()
                            .grayscale(1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .opacity(0.1)
                            .padding(50)
                            .offset(x: -(UIScreen.main.bounds.width * 0.35), y: -70)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
            }
        ) //: NAVIGATION LINK
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
