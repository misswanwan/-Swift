//
//  LeeTalkModel.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/21.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import HandyJSON

struct LeeTalkModel: HandyJSON {

    var ascription : String = ""            //地址
    var autograph : String = ""             //签名
    var avatarUrl : String = ""             //头像地址
    var birthday : String = ""              //生日
    var height : String = ""                //身高体重 60;180
    var hotId : String = ""                 //主播id
    var userId : String = ""                //主播id
    var nickName : String = ""              //昵称
    var voiceInfo : String = ""             //语音地址
    var gold : String = ""                  //金币价格
    var exclusiveUrl : String = ""          //主播图片
    var gender : Int = 0    //性别 1男 2女
    var vType : Int = 0     //会员类型
    var status : Int = 0    //状态 1在线 2隐身 3忙碌
    var mark : Int = 0      // 0.下线  1.上线
    var duration : Int = 0  //语音时长
}
