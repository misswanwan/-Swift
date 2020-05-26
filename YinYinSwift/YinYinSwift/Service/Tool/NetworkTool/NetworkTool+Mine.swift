//
//  NetworkTool+Mine.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/6.
//  Copyright © 2019 ww. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocalMine {
    //个人信息获取
    static func mineUserInfoRequest(phone : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ())
    //粉丝关注点赞访客
    static func mineUserSubInfoRequest(anchorId : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ())
    //保存头像
    static func saveUserProfileImageRequest(profileImageUrl : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ())
}

extension NetworkToolProtocalMine{
    //个人信息获取
    static func mineUserInfoRequest(phone : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + lee_mineUserInfo_url
        let params :NSMutableDictionary = ["mobile":phone]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    
    //粉丝关注点赞访客
    static func mineUserSubInfoRequest(anchorId : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + Lee_mineUserSubInfo_url
        let params :NSMutableDictionary = ["anchorId":anchorId]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    
    //保存头像
    static func saveUserProfileImageRequest(profileImageUrl : String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + Lee_saveProfile_url
        let params :NSMutableDictionary = ["avatarUrl":profileImageUrl]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
}
