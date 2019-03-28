//
//  Lee_Utils.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation

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
            if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: phoneStr){
                return true
            }
            return false
        }else{
            return false
        }
    }
    
    static func validPassword(password:String?)->Bool{
        let result = false
//        if(password!.<=16&&password.length>=6){
//            let regex = @"^(?![0-9]+$)(![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
//            let  pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//            result = [pred evaluateWithObject:string];
//        }
        return result;
    }
}
