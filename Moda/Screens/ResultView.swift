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
    
    @EnvironmentObject private var dbViewModel: DBViewModel
    
    @Binding var pushed: Bool
    
    @State private var memo: String = ""
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 0) {
                // MARK: - UPPER SECTION
                upperSection
                
                // MARK: - BOTTOM SECTION
                bottomSection
                
            } //: VSTACK
            
        }  //: SCROLL
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        .onTapGesture {
            self.endTextEditing()
        }
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("알림"),
                message: Text("삭제하시겠습니까?"),
                primaryButton: .destructive(
                    Text("삭제"),
                    action: {
                        // Go to main screen
                        self.pushed.toggle()
                    }
                ),
                secondaryButton: .default(
                    Text("취소")
                )
            )
        }
        
    }
    
}

private extension ResultView {
    
    var upperSection: some View {
        ZStack(alignment: .center) {

            Color.clear
            
            // Title
            HStack {
                Text("Record")
                    .font(.system(size: 60, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading, 20)

        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: UIScreen.main.bounds.height/2, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color(.black).opacity(0.8))
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
        }
        .overlay(alignment: .bottom) {

            HStack {
                
                Spacer()
                VStack(alignment: .center, spacing: 5) {
                    Text(timeToString(dbViewModel.walk.time, format: 2) == "" ? "0" : timeToString(dbViewModel.walk.time, format: 2))
                        .font(.system(size: 20, weight: .bold))
                    Text("시간")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .center, spacing: 5) {
                    Text("\(dbViewModel.walk.steps)")
                        .font(.system(size: 20, weight: .bold))
                    Text("걸음 수")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                
            } //: HSTACK
            .frame(width: UIScreen.main.bounds.width - 40, height: 100)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
            .shadow(radius: 10)
            .offset(y: 50)
            .padding()
            
        } //: ZSTACK OVERLAY
        .padding(.bottom, 40)
    }
    
    var bottomSection: some View {
        VStack(spacing: 15) {
            let _ = print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            // Rounded Text Editor
            RoundedTextEditor(memo: $memo)
                .background(Color(uiColor: .systemBackground))
            
            // Map
            MapView(viewModel: MapViewModel(with: dbViewModel.walk.points.map { $0.coordinate }),
                    startLocationService: false)
                .frame(height: UIScreen.main.bounds.height * 0.45)
            
            // Delete Button & Save Button
            HStack {
                
                Button(action: {
                    // Show thw alert
                    isShowAlert.toggle()
                }, label: {
                    Circle()
                        .fill(Color("ColorRed"))
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                })
                
                Button("저장하기") {
                    dbViewModel.memo = self.memo
                    dbViewModel.addData()
            
                    // Go to main screen
                    self.pushed.toggle()
                }
                .buttonStyle(CustomButton(colorName: "ColorBlack", colorOpacity: 0.8))
                
            }
            .frame(height: 50)
            
        } //: BOTTOM SECTION
        .padding([.vertical, .horizontal], 10)
        .padding(.bottom, 30)
    }
    
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(pushed: .constant(true))
            .environmentObject(DBViewModel())
    }
}
