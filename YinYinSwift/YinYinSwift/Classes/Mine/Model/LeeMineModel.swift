//
//  LeeMineModel.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/6.
//  Copyright © 2019 ww. All rights reserved.
//

import Foundation
import HandyJSON

struct LeeMineUserModel: HandyJSON {
    
    var ascription : String = ""            //地址
    var province : String = ""              //省
    var autograph : String = ""             //签名
    var avatarUrl : String = ""             //头像地址
    var birthday : String = ""              //生日
    var constellation : String = ""         //星座
    var height : String = ""                //身高体重
    var id : String = ""                    //身高体重
    var mobile : String = ""                //手机号码
    var nickName : String = ""              //昵称
    var number : String = ""                //隐隐id
    var voiceInfo : String = ""             //语音地址
    var exclusiveUrl : String = ""          //主播标志
    var gender : Int = 0                    //性别 1男 2女
    var gold : Int = 0                      //金币
    var isAttestation : Int = 0             //实名认证任务 0 未认证 1 认证 2 审核中
    var mark : Int = 0                      //0下线   1在线
    var remind : Int = 0                    //取消关注提醒 0开启 1关闭
    var status : Int = 0                    //用户状态 1空闲 2隐身 3忙碌
    var type : Int = 0                      //类型 1普通用户 2主播
    var vType : Int = 0                     //会员等级 0非会员 1月会员 2年会员
    var vagrancy : Int = 0                  //无痕浏览 0开启 1关闭
    var duration : Int = 0                  //语音时长
    var voiceSign : Int = 0                 //语音标记 0开 1关
}

struct LeeMineUserSubModel: HandyJSON {
    
    var access : String = ""            //访客数量
    var fabulous : String = ""          //点赞数量
    var fans : String = ""              //粉丝数量
    var follow : String = ""            //关注数量
    var friendCount : Int = 0           //好友数量
    var mdGold : Int = 0                //可用金币
    var state : Int = 0                 //关注状态  1关注 2已关注 3互相关注
    var totalGold : Int = 0             // 总金币
    var totalIncome : Int = 0           //魅力值
    var wealth : Int = 0                //土豪值
}

