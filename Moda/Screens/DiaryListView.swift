//
//  DiaryListView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/29.
//

import SwiftUI

struct DiaryListView: View {
    
    @EnvironmentObject private var dbViewModel: DBViewModel
    
    @State var isShowDetailView: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                
                ForEach(dbViewModel.diaries, id:\.self) { (diary: Diary) in
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text(diary.memo == "" ? "메모 없음" : diary.memo)
                            .foregroundColor(Color(uiColor: .label))
                        
                        Text(dateToString(date: diary.publishDate))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        MapView(viewModel: MapViewModel(with: diary.walk!.points.map { $0.coordinate }),
                                startLocationService: false)
                            .frame(height: 200)
                        
                    }) //: VSTACK
                    .frame(maxWidth:. infinity, alignment: .leading)
                    .padding(15)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        dbViewModel.updateObject = diary
                        isShowDetailView = true
                    }
                    .contextMenu(menuItems: {
                        
                        Button(action: {
                            dbViewModel.updateObject = diary
                            isShowDetailView = true
                        }, label: {
                            Text("일기 수정")
                        })
                        
                        Button(action: {
                            dbViewModel.deleteData(object: diary)
                        }, label: {
                            Text("일기 삭제")
                        })
                        
                    })
                    .background(
                        NavigationLink(
                            destination: DetailView(isShowDetailView: self.$isShowDetailView)
                                .environmentObject(dbViewModel),
                            isActive: $isShowDetailView) {
                               EmptyView()
                        }
                    )
                } //: FOREACH
                .listStyle(.grouped)
                
            } //: VSTACK
            .padding()
            
        } //: SCROLL
        .toolbar {
            HStack {
                Spacer()
                Button(action: {

                }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .onAppear {
            dbViewModel.fetchData()
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
            .environmentObject(DBViewModel())
    }
}
