
//
//  JSDateTool.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/20.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

//时间转字符串
func getTimeStringWithDate(date : Date) -> String {
    let dateFormat : DateFormatter = DateFormatter.init()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateStr : String = dateFormat.string(from: date as Date)
    return dateStr
}


//时间戳转字符串
func getTimeStringWithTimeStamp(timeStamp : String) -> String {
    let date : Date = Date.init(timeIntervalSince1970: TimeInterval(timeStamp.doubleValue() / 1000))
    let dateFormat : DateFormatter = DateFormatter.init()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateStr : String = dateFormat.string(from: date as Date)
    return dateStr
}


//时间转时间戳
func getTimeStampWithDate(date : Date) -> String {
   let time = String(format: "%ld",date.timeIntervalSince1970 * 1000)
   return time
}


//字符串转时间
func getDateWithDateStr(dateStr : String) -> Date {
    let dateFormat : DateFormatter = DateFormatter.init()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date : Date = dateFormat.date(from: dateStr)!
    return date
}

//时间字符串转时间戳
func getTimeStampWithDateStr(dateStr : String) -> String {
    let dateFormat : DateFormatter = DateFormatter.init()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date : Date = dateFormat.date(from: dateStr)!
    let time = String(format: "%ld",date.timeIntervalSince1970 * 1000)
    return time
}

//获取一个日期之前或者之后多长时间的日期
func getLaterDateFromDate(date : Date,year : NSInteger,month : NSInteger,day : NSInteger,hour : NSInteger,minutes : NSInteger,second : NSInteger) -> Date {
    let calendar : Calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
    var adcomps : DateComponents = DateComponents.init()
    adcomps.year = year
    adcomps.month = month
    adcomps.day = day
    adcomps.hour = hour
    adcomps.minute = minutes
    adcomps.second = second
    let newDate : Date = calendar.date(byAdding: adcomps, to: date)!
    return newDate
}
