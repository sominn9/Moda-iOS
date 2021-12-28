//
//  Diary.swift
//  Moda
//
//  Created by 신소민 on 2021/12/27.
//

import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var walk: Walk?            // 산책 데이터
    @objc dynamic var memo: String = ""      // 메모
    @objc dynamic var publishDate = Date()   // 작성날짜
}
