//
//  Swift+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/28.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import CommonCrypto

extension String{
    
    
    //验证字符串
    static func vaildStr(validStr:String?)->Bool{
        if validStr != nil {
            if (validStr!.isEmpty){
                return false
            }
            else{
                return true
            }
        }
        else{
            return false
        }
    }
    
    static func validPhoneNumber(phoneStr:String?)->Bool{
        if(vaildStr(validStr: phoneStr)){
            let pattern = "^1[0-9]{10}$"
            return  NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: phoneStr)
        }else{ return false }
    }
    
    static func validPassword(password:String?)->Bool{
        if(vaildStr(validStr: password)){
            let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password!)
        }else{ return false }
    }
    
    static func MD5Encode(md5str:String)->String{
        if(vaildStr(validStr: md5str)){
            let str = md5str.cString(using: String.Encoding.utf8)
            let strLen = CUnsignedInt(md5str.lengthOfBytes(using: String.Encoding.utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
            CC_MD5(str!, strLen, result)
            let hash = NSMutableString()
            for i in 0 ..< digestLen {
                hash.appendFormat("%02X", result[i])
            }
            free(result)
            return String(format: hash as String)
        }else{ return "" }
    }
    
    static func replaceNilAction(replaceStr:String?)->String!{
        if let result = replaceStr{
            return result
        }else{
            return ""
        }
    }
    
    func addOSSPath()->String{
        return "https://faint-app.oss-cn-hangzhou.aliyuncs.com/\(self)"
    }
    
    static func getAgeWithBirthDay(birthDay:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDate = dateFormatter.date(from: birthDay)
        let nowDate = NSDate()
        let time = nowDate.timeIntervalSince(birthDate ?? nowDate as Date)
        let age = Int(time)/(3600*24*365)
        return "\(age)";
    }
}
