//
//  DiaryListView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/29.
//

import SwiftUI

struct DiaryListView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject private var dbViewModel: DBViewModel
    
    @State var isDetailView: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            List {
                
                ForEach(dbViewModel.diaries, id:\.self) { (diary: Diary) in
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text(diary.memo == "" ? "메모 없음" : diary.memo)
                            .foregroundColor(Color(uiColor: .label))
                        
                        Text(dateToString(date: diary.publishDate))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        MapView(viewModel: MapViewModel(with: diary.walk!.points.map { $0.coordinate }),
                                startLocationService: false,
                                userInteractionEnabled: false)
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                        
                    }) //: VSTACK
                    .frame(maxWidth:. infinity, alignment: .leading)
                    .padding(15)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        dbViewModel.updateObject = diary
                        isDetailView = true
                    }
                    .contextMenu(menuItems: {
                        
                        Button(action: {
                            dbViewModel.updateObject = diary
                            isDetailView = true
                        }, label: {
                            Label("일기 수정", systemImage: "pencil")
                        })
                        
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                dbViewModel.deleteData(object: diary)
                            }
                        }, label: {
                            Label("일기 삭제", systemImage: "trash")
                        })
                        
                    })
                    .background(
                        NavigationLink(
                            destination: DetailView()
                                .environmentObject(dbViewModel),
                            isActive: $isDetailView) {
                                EmptyView()
                            }
                            .hidden()
                    )
                    
                } //: FOREACH
                .onDelete { indexSet in
                    dbViewModel.deleteData(with: indexSet)
                }
                
            } //: LIST
            .listStyle(.grouped)
            .listRowBackground(Color.clear)
                
        } //: VSTACK
        .toolbar {
            HStack {
                Spacer()
                Button(action: {

                }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width > 0 {
                        // Go to the main
                        presentation.wrappedValue.dismiss()
                    }
                })
        )
        .onAppear {
            
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().separatorColor = .clear
            
            // Fetch diaries
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
