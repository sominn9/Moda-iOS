//
//  ResultView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import MapKit

struct ResultView: View {
    
    @Binding var pushed: Bool

    @State private var time: Int = 0
    @State private var steps: Int = 0
    @State private var memo: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - UPPER SECTION
                ZStack(alignment: .center) {
                    Color("ColorRed")
                    
                    HStack {
                        Text("Record")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .offset(y: -70)
                    
                    HStack {
                        // HStack Component1 (Text Section)
                        VStack(spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(time)분 \(time)초")
                                        .font(.system(.title2))
                                    Text("시간")
                                }
                                Spacer()
                            }
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(steps)")
                                        .font(.system(.title2))
                                    Text("걸음수")
                                }
                                Spacer()
                            }
                        } //: VSTACK
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .offset(y: 50)
                        
                        // HStack Component2 (Image Section)
                        Image("bao-black-kitten-2")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .offset(x: 20, y: 100)
                        
                    } //: HSTACK
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                    .padding([.top, .horizontal], 20)
                    .clipShape(Rectangle())
                }
                
                // MARK: - BOTTOM SECTION
                VStack(spacing: 15) {
                    // Map
                    MapView()
                        .frame(height: 350)
                    
                    // Rounded Text Editor
                    RoundedTextEditor(text: memo)
                    
                    // Button
                    Button("저장하기") {
                        self.pushed = false
                    }
                    .buttonStyle(CustomButton())
                }
                .padding([.vertical, .horizontal], 10)
                .padding(.bottom, 30)
            }
        } //: VSTACK
        .ignoresSafeArea()
        .onTapGesture {
            self.endTextEditing()
        }
    } //: SCROLL
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(pushed: .constant(true))
    }
}
