//
//  ResultView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import MapKit
import RealmSwift

struct ResultView: View {
    
    let realm = try! Realm()
    
    let walk: Walk
    
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
                    
                    // Title
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
                    
                    // Text & Image
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
                    let _ = print(Realm.Configuration.defaultConfiguration.fileURL!)
                    
                    // Map
                    MapView(viewModel: MapViewModel(with: walk.points.map { $0.coordinate }))
                        .frame(height: 350)
                    
                    // Rounded Text Editor
                    RoundedTextEditor(memo: $memo)
                    
                    // Button                    
                    HStack {
                        Button("삭제하기") {
                            // Go to main screen
                            self.pushed = false
                        }
                        .buttonStyle(CustomButton(colorName: "ColorDarkRed"))
                        
                        Button("저장하기") {
                            // Data save
                            let diary = Diary()
                            diary.walk = self.walk
                            diary.memo = self.memo
                            diary.publishDate = Date()
                            
                            try! realm.write{
                                realm.add(diary)
                            }
                            
                            // Go to main screen
                            self.pushed = false
                        }
                        .buttonStyle(CustomButton(colorName: "ColorRed"))
                    }
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
        ResultView(walk: Walk(), pushed: .constant(true))
    }
}
