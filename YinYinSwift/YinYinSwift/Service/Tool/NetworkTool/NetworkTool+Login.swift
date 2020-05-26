//
//  NetworkTool+Login.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/6.
//  Copyright © 2019 ww. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    
    // MARK: - 登录
    //验证手机号码
    static func checkPhoneRequest(mobile:String, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
    //手机号+密码登录
    static func loginRequest(mobile:String, md5Password:String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ())
    //发送验证码
    static func sendCodeRequest(mobile:String ,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
    //验证码登录
    static func loginWithCode(mobile:String ,code:String ,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
    //免登陆
    static func noLandingRequest(mobile:String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ())
    
}

extension NetworkToolProtocol{
    
    //验证手机号码
    static func checkPhoneRequest(mobile: String, completionHandler: @escaping (_ result: NSDictionary) -> (),failHandler:@escaping (_ error:Error?) -> ()) {
        
        let url = lee_baseUrl + lee_validPhone_url
        let params :NSMutableDictionary = ["mobile": mobile]
        
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //手机号+密码登录
    static func loginRequest(mobile:String, md5Password:String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + lee_loginWithPassword_url
        let params :NSMutableDictionary = ["mobile": mobile,"pwd":md5Password,"sysVersion":lee_version]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //发送验证码
    static func sendCodeRequest(mobile:String ,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + lee_sendCode_url
        let params :NSMutableDictionary = ["mobile": mobile,"type":"6"]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //验证码登录
    static func loginWithCode(mobile:String ,code:String ,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        let url = lee_baseUrl + lee_loginWithCode_url
        let params :NSMutableDictionary = ["mobile": mobile,"code":code]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //免登陆
    static func noLandingRequest(mobile:String,completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> ()){
        let url = lee_baseUrl + lee_noLanding_url
        let params :NSMutableDictionary = ["mobile": mobile]
        params.addEntries(from:NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
}
