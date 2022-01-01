//
//  DetailView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import MapKit
import RealmSwift

struct DetailView: View {
    
    @EnvironmentObject private var dbViewModel: DBViewModel
    
    @Binding var isShowDetailView: Bool
    
    @State private var memo: String = ""
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - UPPER SECTION
                ZStack(alignment: .top) {
 
                    Color.clear
                    
                    // Back Button
                    HStack {
                        Button(action: {
                            // Go to diary list screen
                            self.isShowDetailView.toggle()
                            
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                        })
                        Spacer()
                    }
                    .offset(y: 70)
                    
                    // Title & Publish Date
                    VStack {
                        HStack {
                            Text("Record")
                                .font(.system(size: 60, weight: .bold))
                            Spacer()
                        }
                        HStack {
                            Text(dateToString(date: dbViewModel.publishDate ?? Date()))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .offset(y: UIScreen.main.bounds.height/6.5)

                } //: ZSTACK
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: UIScreen.main.bounds.height/2, maxHeight: .infinity)
                .background {
                    Rectangle()
                        .fill(Color(.black).opacity(0.8))
                }
                .overlay(alignment: .bottomLeading) {
                    
                    Image("bao-black-kitten-2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height/3)
                        .offset(x: UIScreen.main.bounds.width/2, y: 100)

                    VStack {
                        
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
                    .frame(width: UIScreen.main.bounds.width/2, height: 200)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
                    .shadow(radius: 10)
                    .offset(y: 70)
                    .padding()
                    
                } //: ZSTACK OVERLAY
                .padding(.bottom, 40)
                
                // MARK: - BOTTOM SECTION
                VStack(spacing: 15) {
                    let _ = print(Realm.Configuration.defaultConfiguration.fileURL!)
                    
                    // Rounded Text Editor
                    RoundedTextEditor(memo: $memo)
                        .background(Color(uiColor: .systemBackground))
                    
                    // Map
                    MapView(viewModel: MapViewModel(with: dbViewModel.walk.points.map { $0.coordinate }),
                            startLocationService: false)
                        .frame(height: 350)
                    
                    // Button
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
                    
                            // Go to diary list screen
                            self.isShowDetailView.toggle()
                        }
                        .buttonStyle(CustomButton(colorName: "ColorBlack", colorOpacity: 0.85))
                        
                    }
                    .frame(height: 50)
                    
                } //: BOTTOM SECTION
                .padding([.vertical, .horizontal], 10)
                .padding(.bottom, 30)
                
            } //: VSTACK
            
        }  //: SCROLL
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        .onTapGesture {
            self.endTextEditing()
        }
        .onAppear {
            dbViewModel.setUpInitialData()
            memo = dbViewModel.memo
        }
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("알림"),
                message: Text("삭제하시겠습니까?"),
                primaryButton: .destructive(
                    Text("삭제"),
                    action: {
                        
                        // Delete data
                        dbViewModel.deInitData()
                        dbViewModel.deleteData(object: dbViewModel.updateObject!)
                        
                        // Go to diary list screen
                        self.isShowDetailView.toggle()
                        
                    }
                ),
                secondaryButton: .default(
                    Text("취소")
                )
            )
        }
        .onDisappear {
            dbViewModel.updateObject = nil
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(isShowDetailView: .constant(true))
            .environmentObject(DBViewModel())
    }
}
