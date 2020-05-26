//
//  Lee_Utils.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/16.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class Lee_Utils: NSObject {
    /**
     *  传入时间字符,返回一个 时间 几秒前 几分钟前 几小时前 昨天 前几天  日期
     */
    static func leedateFormotStringWithInterval(timeStr:String)->String{
        let dateTime = self.getDateWithString(timeString: timeStr)
        // 转为时间对象
        let interval = dateTime.timeIntervalSince1970
        // 现在时间秒数
        let now = Date().timeIntervalSince1970
        // 时间差
        let time = Int(now - interval)
        if(time<60){
            return "\(time)秒前"
        }
        let sec = Int(time)
        if(sec<60){
            return "\(sec)分钟前"
        }
        let hours = time/3600
        if(hours<24){
            return "\(hours)小时前"
        }
        let days = time/3600/24
        if(days<2){
            return "昨天"
        }
        if(days<5){
            return "\(days)天前"
        }else if(days<365){
            let df = DateFormatter()
            df.dateFormat = "MM-dd"
            return df.string(from: dateTime)
        }else{
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            return df.string(from: dateTime)
        }
    }
    
    static func getAgeWithBirthday(birthday:String) -> String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormatter.date(from: birthday)
        let currentDate = NSDate.init()
        let time = currentDate.timeIntervalSince(birthdayDate ?? currentDate as Date)
        let age =  Int(time)/(3600*24*365)
        return "\(age)"
    }
    
    static func getDateWithString(timeString:String)->Date{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = df.date(from: timeString)
        return date ?? Date();
    }
    
    static func getTimeStamp()->String{
        let date = NSDate.init()
        return"\(date.timeIntervalSince1970)"
    }
    
}


extension String{
    
    
    
    static func lee_phoneNumberKey() -> String{
        return "Lee_phoneNumberKey"
    }
    
    static func lee_userToken() -> String{
        return "Lee_userTokenKey"
    }
    
    static func lee_useridKey() -> String{
        return "Lee_useridKey"
    }
}

extension NSDictionary{
    static func lee_requestParam() -> NSDictionary{
        let params : NSMutableDictionary = NSMutableDictionary()
        params.setValue(lee_deviceId, forKey: "equipmentId")
        params.setValue(lee_version, forKey: "sysVersion")
        if UserDefaults.standard.value(forKey: String.lee_userToken()) != nil {
            params.setValue(UserDefaults.standard.value(forKey: String.lee_userToken()), forKey: "token")
        }
        if UserDefaults.standard.value(forKey: String.lee_useridKey()) != nil {
            params.setValue(UserDefaults.standard.value(forKey: String.lee_useridKey()), forKey: "userId")
        }
        return params
    }
}

