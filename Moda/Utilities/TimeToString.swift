//
//  TimeToString.swift
//  Moda
//
//  Created by 신소민 on 2021/12/28.
//

import Foundation

/// 초를 문자열로 바꿔준다.
///
/// [format - 1] 초를 '00:00:00' 포맷의 문자열로 바꿔준다.
///
/// [format - 2] 초를 '0시간 0분 0초' 포맷의 문자열로 바꿔준다.
///
func timeToString(_ time: Int, format: Int) -> String {
    var time: Int = time
    var second: Int = 0
    var minute: Int = 0
    var hour: Int = 0

    // seconds
    second = time % 60
    time /= 60

    // minutes, hours
    minute = time % 60
    hour = time / 60
    
    switch format {
    case 1:
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    case 2:
        var result: String = ""
        let hourString = (hour != 0) ? "\(hour)시간" : ""
        let minuteString = (minute != 0) ? "\(minute)분" : ""
        let secondString = (second != 0) ? "\(second)초" : ""
        
        result += hourString
        result += (minuteString != "" ? " " + minuteString : "")
        result += (secondString != "" ? " " + secondString : "")
        return result
    default:
        fatalError()
    }
}
