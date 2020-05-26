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

//MARK:network status

let leeNetworkReturnSuccess:NSNumber = 200  //请求成功
let leeNetworkCommonError:NSNumber  = 300      //常规错误
let leeNetWorkTokenExpireError:NSNumber = 403 //token过期
let leeNetworkOvertimeError:NSNumber = 1001 //验证码超时
let leeNetworkMobileUsed:NSNumber = 1001 //手机号码已经被使用
let leeNetworkNilMobileError:NSNumber = 1002 //手机号码不存在
let leeNetworkNilUserError:NSNumber = 1004 //登录用户不存在
let leeNetworkNilThirdError:NSNumber = 1005 //第三方账号不存
let leeNetworkNoResigterSendCodeSuccess:NSNumber = 1006 //用户未被注册且验证码发送成功
let leeNetworkNotFillInfo:NSNumber = 1010 //用户尚未完善信息
let leeNetworkNotGold:NSNumber = 1011 //用户金币不足
let leeNetworkReview:NSNumber = 1020 //审核版本
let leeNetworkRealNameFail:NSNumber = 1030 //实名认证失败
let leeNetworkRealNameing:NSNumber = 1040 //实名认证中
let leeNetworkMustUpdate:NSNumber = 1021 //强制更新
let leeNetworkNeedUpdate:NSNumber = 1022 //非强制更新
let leeOffineNetwork:NSNumber = 2011 //自己掉线


//MARK:登录
let lee_validPhone_url = "/faint-app/app/user/mdUser/submitMobile"              //验证手机号码
let lee_loginWithPassword_url = "/faint-app/app/user/mdUser/login"              //密码登录
let lee_sendCode_url = "/faint-app/app/user/mdUser/getCode"                     //发送验证码
let lee_loginWithCode_url = "/faint-app/app/user/mdUser/loginCheckCode"         //验证码登录
let lee_noLanding_url = "/faint-app/app/user/mdUser/selectMdUser"               //免登陆
//MARK:首页
let lee_homepagePost_url = "/faint-app/app/dynamic/v1_1mdDynamic/list"          //首页热门帖子
//MARK:语聊
let lee_talkPop_url = "/faint-app/app/query/mdPopularity/pageList"              //语聊人气
let lee_talkLasted_url = "/faint-app/app/query/mdSee/findNewList"               //语聊最新
let lee_talkRecommend_url = "/faint-app/app/hot/mdRecommend/selectRecommend"    //热门推荐
//MARK:我的
let lee_mineUserInfo_url = "/faint-app/app/user/mdUser/selectMdUser"            //个人信息获取
let Lee_mineUserSubInfo_url = "/faint-app/app/fans/mdFollow/selectCount"        //粉丝关注点赞访客
let Lee_saveProfile_url = "/faint-app/app/user/mdUser/addInfo"                  //保存用户头像


struct NetworkTool: NetworkToolProtocol,NetworkToolProtocolHomapage,NetworkToolProtocolTalk,NetworkToolProtocalMine{
    
    static func lee_request(url:String, params:AnyObject,type:HTTPMethod , completionHandler: @escaping (_ result: NSDictionary) -> () ,failHandler:@escaping (_ error:Error?) -> () ){
        
        Alamofire.request(url,method: type, parameters: params.copy() as? Parameters).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { failHandler(response.error);  return}
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json.dictionaryObject {
                    completionHandler(data as NSDictionary)
                }else { failHandler(response.error);  return}
            }else { failHandler(response.error);  return}
        }
    }

}
