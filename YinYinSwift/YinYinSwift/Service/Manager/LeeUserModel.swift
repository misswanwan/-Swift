//
//  LeeUserModel.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/28.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import HandyJSON

struct LeeUserModel: HandyJSON {
    
    var ascription : String = ""         //所在地(市)
    var province : String = ""           //省
    var autograph : String = ""          //签名
    var avatarUrl : String = ""          //头像
    var birthday : String = ""           //生日
    var constellation : String = ""      //星座
    var height : String = ""             //身高  体重
    var id : String = ""                 //用户id
    var gender: Int = 0                   //性别  1男 2女
    var gold: Int = 0                     //收费设置金币数量
    var isAttestation: Int = 0            //实名认证任务 0 未认证 1 认证 2 审核中 3驳回
    var mark: Int = 0                     //在线状态 0下线   1在线
    var remind: Int = 0                   //取消关注提醒 0开启 1关闭
    var status: Int = 0                   // 用户状态 1空闲 2隐身 3忙碌
    var type: Int = 0                     // 类型 1普通用户 2主播
    var vType: Int = 0                    // 会员等级 0非会员 1月会员 2年会员
    var vagrancy: Int = 0                 // 无痕浏览 0开启 1关闭
    var duration: Int = 0                 //语音时长
    var voiceSign: Int = 0                //语音标记 0开 1关
    var mobile : String = ""             //手机号码
    var nickName : String = ""           //昵称
    var number : String = ""             //隐隐id
    var voiceInfo : String = ""          //语音地址
    var exclusiveUrl : String = ""       //主播标志
}
