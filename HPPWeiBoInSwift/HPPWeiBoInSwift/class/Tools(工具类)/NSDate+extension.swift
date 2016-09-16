//
//  NSDate+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/16.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation

//NSDateFormatter 和 NSCalendar 这两个类比较消耗性能,所以尽量不要频繁创建和释放, 在oc中可以创建一个单例, 在swift中,创建一个常量

let HPPdateFormatter = NSDateFormatter()
let HPPcalendar = NSCalendar.currentCalendar()

extension NSDate {
    ///  把新浪的时间字符串转成日期
    ///
    ///  - parameter sinaTimeStr: 新浪时间字符串 "Wed Sep 14 09:09:13 +0800 2016"
    ///
    ///  - returns: 返回NSDate
    class func sinaTimeStrToDate (sinaTimeStr:String) -> NSDate {
        
        let formatStr = "EEE MMM dd HH:mm:ss zzz yyyy"
        HPPdateFormatter.dateFormat = formatStr
        //下面的这个属性必须传,不然在真机上时间可能不准确
        HPPdateFormatter.locale = NSLocale(localeIdentifier: "en")
        
        return HPPdateFormatter.dateFromString(sinaTimeStr)!
    }
    
    func dateToWillShowTimeString () -> String {
        //是否是今天
        if HPPcalendar.isDateInToday(self) {
            let seconds = Int(NSDate().timeIntervalSinceDate(self))
            
            //一分钟内
            if seconds < 60 {
                return "刚刚"
            } else if seconds < 60 * 60 {
                return "\(seconds/60)分钟前"
            } else {
                return "\(seconds/60/60)小时前"
            }
        } else {
            
            if HPPcalendar.isDateInYesterday(self){
                HPPdateFormatter.dateFormat = "昨天 HH:mm"
            } else {
                //是否是今年, 用calendar获取当前的年份的元素
                //获取新浪的日期是哪一年
                let year = HPPcalendar.component(.Year, fromDate: self)
                
                //获取当前日期是哪一年
                let thisYear = HPPcalendar.component(.Year, fromDate: NSDate())
                
                if year == thisYear {
                    //今年
                    HPPdateFormatter.dateFormat = "MM-dd HH:mm"
                } else {
                    //往年
                    HPPdateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                }
                
            }
            
            return HPPdateFormatter.stringFromDate(self)
            
        }
    }
}





























