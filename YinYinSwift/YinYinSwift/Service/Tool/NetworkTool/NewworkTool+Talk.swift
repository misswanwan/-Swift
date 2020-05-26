//
//  NewworkTool+talk.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocolTalk {
    //语聊人气
    static func talkPopListRequest(pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
    //语聊最新
    static func talkLatestListRequest(pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
    //时段推荐
    static func talkRecommendListRequest(completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
}

extension NetworkToolProtocolTalk{
    //语聊人气
    static func talkPopListRequest(pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        let url = lee_baseUrl + lee_talkPop_url
        let params :NSMutableDictionary = ["pageNo":pageNo,"pageSize":pageSize]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //语聊最新
    static func talkLatestListRequest(pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        let url = lee_baseUrl + lee_talkLasted_url
        let params :NSMutableDictionary = ["pageNo":pageNo,"pageSize":pageSize]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
    //热门推荐
    static func talkRecommendListRequest(completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        let url = lee_baseUrl + lee_talkRecommend_url
        let params :NSMutableDictionary = [:]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
}
