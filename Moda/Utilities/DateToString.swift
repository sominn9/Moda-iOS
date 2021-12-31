//
//  DateToString.swift
//  Moda
//
//  Created by 신소민 on 2021/12/29.
//

import Foundation

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: date)
}
