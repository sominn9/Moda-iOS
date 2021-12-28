//
//  Walk.swift
//  Moda
//
//  Created by 신소민 on 2021/12/28.
//

import Foundation
import RealmSwift
import MapKit

class Walk: Object {
    @objc dynamic var time: Int = 0     // 운동시간 (sec)
    @objc dynamic var steps: Int = 0    // 걸음수
    var points = List<Location>()       // 위치
}
