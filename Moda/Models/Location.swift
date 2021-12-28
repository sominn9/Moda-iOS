//
//  Location.swift
//  Moda
//
//  Created by 신소민 on 2021/12/27.
//

import Foundation
import RealmSwift
import CoreLocation

class Location: Object {
    @objc dynamic var latitue = 0.0
    @objc dynamic var longitude = 0.0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitue, longitude: longitude)
    }
}
