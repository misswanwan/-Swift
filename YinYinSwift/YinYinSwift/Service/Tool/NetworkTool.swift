//
//  NetworkTool.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/19.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



private let requestParam = ["equipmentId":lee_deviceId,"sysVersion":lee_version]

protocol NetworkToolProtocol {
    // MARK: - 登录
    //验证手机号码
    static func checkPhoneRequest(mobile:String, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping () -> () )
}

extension NetworkToolProtocol{
    static func checkPhoneRequest(mobile: String, completionHandler: @escaping (_ result: NSDictionary) -> (),failHandler:@escaping () -> ()) {
        
        let url = lee_baseUrl + "/faint-app/app/user/mdUser/submitMobile"
        let params = ["mobile": mobile,"equipmentId":lee_deviceId,"sysVersion":lee_version]
//        let tempParams:NSMutableDictionary = NSMutableDictionary.init(dictionary: params)
//        tempParams.addEntries(from: requestParam as [String : Any])
        
        Alamofire.request(url,method: .post, parameters: params as Parameters).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { failHandler();  return}
            if let value = response.result.value {
                let json = JSON(value)
//                guard json["message"] == "success" else { return }
                if let data = json.dictionaryObject {
                    completionHandler(data as NSDictionary)
                }else { failHandler();  return}
            }else { failHandler();  return}
        }
    }
}

struct NetworkTool: NetworkToolProtocol {}
