//
//  DBViewModel.swift
//  Moda
//
//  Created by 신소민 on 2021/12/29.
//

import Foundation
import RealmSwift
import SwiftUI
import Combine

class DBViewModel: ObservableObject {
    
    // Data
    @Published var walk = Walk()
    @Published var memo = ""
    @Published var publishDate: Date?
    
    // Fetched Data
    @Published var diaries: [Diary] = []
    
    // Data Updation
    @Published var updateObject: Diary?
    
    // Fetching Data
    func fetchData() {
        guard let realm = try? Realm() else { return }
        
        let results: Results<Diary> = realm.objects(Diary.self)
        
        diaries = results.compactMap({ diary in
            return diary
        })
        
        // The most recently published diary comes to the top
        diaries = diaries.sorted(by: {$0.publishDate > $1.publishDate})
    }
    
    func addData() {
        guard let realm = try? Realm() else { return }
        
        let diary = Diary()
        diary.walk = walk
        diary.publishDate = Date()
        diary.memo = memo
        
        // Writing Data
        try? realm.write {
            
            // Writing 'New' Data
            guard let updateObject = updateObject else {
                
                realm.add(diary)
                return
            }
            
            // Updating Data
            updateObject.memo = memo
        }
        
        // Updating UI
        fetchData()
    }
    
    func deleteData(object diary: Diary) {
        guard let realm = try? Realm() else { return }
        
        // Deleting Data
        try? realm.write {
            
            if !diary.isInvalidated {
                realm.delete(diary.walk!.points)
                realm.delete(diary.walk!)
                realm.delete(diary)
            }
            
            // Updating UI
            fetchData()
        }
    }
    
    func deleteData(with indexSet: IndexSet) {
        guard let realm = try? Realm() else { return }
        
        indexSet.forEach { index in
            
            try? realm.write {
                
                realm.delete(diaries[index])
                
                // Updating UI
                fetchData()
            }
        }
    }
    
    // MARK: - Init & Deinit
    
    func setUpInitialData() {
        guard let updateObject = updateObject else { return }
        
        // Assigning update object values to properties
        walk = updateObject.walk!
        memo = updateObject.memo
        publishDate = updateObject.publishDate
    }
    
    func deInitData() {
        walk = Walk()
        memo = ""
        publishDate = nil
    }
    
}
