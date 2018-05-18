//
//  ExtensionDate.swift
//  unique
//
//  Created by 李占理 on 17/9/16.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension Date{
    /**
     *  获取当前Year
     */
    func getYear() ->Int?{
        let calendar = Calendar.current
        var com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        return com.year
    }
    /**
     获取指定时间上一个月的时间
     */
    func getLastDate() ->Date?{
        let calendar = Calendar.current
        var com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        com.month = com.month! - 1
        com.day = self.getDay()
        //        if com.month == self.getMonth() {
        //            com.day = self.getDay()
        //        }
        return calendar.date(from: com)
    }
    /**
     获取指定时间下一个月的时间
     */
    func getNextDate() ->Date?{
        let calendar = Calendar.current
        var com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        com.month = com.month! + 1
        com.day = self.getDay()
        //        if com.month == self.getMonth() {
        //            com.day = self.getDay()
        //        }
        return calendar.date(from: com)
    }
    /**
     *  获取当前Month
     */
    
    func getMonth() ->Int?{
        let calendar = Calendar.current
        let com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        return com.month
    }
    /**
     *  获取当前Day
     */
    func getDay() ->Int?{
        let calendar = Calendar.current
        let com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        return com.day
        
    }
    /**
     获取这个月有多少天
     */
    func getMonthHowManyDay() ->Int?{
        return Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)?.count
    }
    /**
     获取日期是星期几
     */
    func getDateWeekDay() ->Int?{
        let dateFmt         = DateFormatter()
        dateFmt.dateFormat  = "yyyy-MM-dd HH:mm:ss"
        let interval        = Int(self.timeIntervalSince1970)
        let days            = Int(interval/86400)
        let weekday         = ((days + 4) % 7 + 7) % 7
        return weekday
    }
    /**
     *  获取这个月第一天是星期几
     */
    func getMontFirstWeekDay() ->Int?{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar.current
        var com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        //设置成第一天
        com.day = 1
        let date = calendar.date(from: com)
        let firstWeekDay = calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: date!)
        return firstWeekDay! - 1
    }
    /**
     是否是今天
     */
    func isToday()->Bool {
        let calendar = Calendar.current
        /// 获取self的时间
        let comSelf = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        /// 获取当前的时间
        let comNow = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: Date())
        return comSelf.year == comNow.year && comSelf.month == comNow.month && comSelf.day == comNow.day
    }
    /**
     分别获取准确的年月日
     */
    func getDateY_M_D(day :Int)->(year:Int,month:Int,day:Int) {
        let calendar = Calendar.current
        var comSelf = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        comSelf.day = day
        return (comSelf.year!,comSelf.month!,comSelf.day!)
    }
    /**
     获取指定date
     */
    func getDate(day :Int) ->Date? {
        let calendar = Calendar.current
        var comSelf = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        comSelf.day = day
        return calendar.date(from: comSelf)
    }
    /**
     获取指定时间上一个月的时间
     */
    func getLastDate(count:Int = 0) ->Date?{
        let calendar = Calendar.current
        var com = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: self)
        com.month = com.month! - count
        com.day = self.getDay()
        //        if com.month == self.getMonth() {
        //            com.day = self.getDay()
        //        }
        return calendar.date(from: com)
    }
    /**
     日期比较
     */
    func getDateCompare(date1:Date,date2:Date){
        let calendar = Calendar.current
        let com = calendar.compare(date1, to: date2, toGranularity: Calendar.Component.calendar)
        if com == ComparisonResult.orderedAscending {
            print("升序")
        }else if com == ComparisonResult.orderedDescending{
            print("降序排列")
        }else{
            print("相等")
        }
    }
    
}
