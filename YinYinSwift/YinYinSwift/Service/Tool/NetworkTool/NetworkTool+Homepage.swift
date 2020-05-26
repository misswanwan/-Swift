//
//  NetworkTool+homepage.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocolHomapage {
    //首页热门帖子 searchType 1最新 2热门
    static func homepagePostListRequest(type:NSInteger, pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () )
}
//首页热门帖子 searchType 1最新 2热门
extension NetworkToolProtocolHomapage{
    static func homepagePostListRequest(type:NSInteger, pageNo:NSInteger ,pageSize:NSInteger, completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        let url = lee_baseUrl + lee_homepagePost_url
        let params :NSMutableDictionary = ["searchType": type,"pageNo":pageNo,"pageSize":pageSize]
        params.addEntries(from: NSDictionary.lee_requestParam() as! [AnyHashable : Any])
        NetworkTool.lee_request(url: url, params: params, type: HTTPMethod.post,completionHandler: { (data) in
            completionHandler(data as NSDictionary)
        }) { (error) in
            failHandler(error)
        }
    }
}
