//
//  LeePostModel.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/5.
//  Copyright © 2019年 ww. All rights reserved.
//

import HandyJSON

struct LeePostModel : HandyJSON{
    
    private let postMargin = CGFloat(15)
    private let postImageMax = CGFloat(200)
    
    var id : String = ""            //帖子id
    var updateDate : String = ""    //更新时间
    var userId : String = ""        //userid
    var title : String = ""         //标题
    var content : String = ""       //内容
    var url : String = ""           //图片url
    var warrant : String = ""       //1默认 2不允许评论
    var avatarUrl : String = ""     //头像地址
    var nickName : String = ""      //昵称
    var hotId : String = ""         //hotId
    var createDate : String = ""    //创建时间
    var birthday : String = ""      //生日
    var voiceUrl : String = ""      //语音地址
    var exclusiveUrl : String = ""  //主播标志
    var fabulousCount : Int = 0      //点赞数量
    var discussCount : Int = 0       //评论数量
    var gender : Int = 1             //1.男 2.女
    var vType : Int = 0              //vip类型   1月 2年 0非会员
    var uType : Int = 0              //用户类型    1.普通用户   2.主播
    var duration : Int = 0           //语音时长
    var type : Int = 0               //类型  0.存文 1.图文  2.语音
    var status : Int = 0             //状态 0审核中 1审核通过 2驳回
    var isFabulous :Bool = false    //是否点赞
    var isFollow :Bool = false      //是否关注
    //行高
    var rowHeight : CGFloat {
        get{
            var postH :CGFloat = CGFloat(0)
            let tempLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), text: content, textColor: UIColor.lee_convenient(r: 55, g: 55, b: 55), textA: .left, font: UIFont.systemFont(ofSize: 14))
            let maxW = Screen_Width - 30
            let labelSize : CGSize = tempLabel.sizeThatFits(CGSize(width: maxW, height: CGFloat(MAXFLOAT)))
            let contentH = labelSize.height>40 ? 40:labelSize.height
            if(type == 0){
                postH = 11 + contentH
            }else if(type == 1){
                if(String.vaildStr(validStr: url)){
                    let arr : [String] = url.components(separatedBy: ",")
                    let margin :CGFloat = CGFloat(8)
                    let yMargin : CGFloat = CGFloat(10)
                    let imageW = (Screen_Width - CGFloat(2*postMargin) - CGFloat(2*margin))/3
                    if(arr.count>1){
                        postH = 11 + contentH + yMargin + imageW
                    }else{
                        if(imageHeight>0&&imageWidth>0){
                            var imageH = imageHeight
                            var imageW = imageWidth
                            if(imageH>=imageW){
                                if(imageH>postImageMax){
                                    imageW = postImageMax*imageW/imageH
                                    imageH = postImageMax
                                }else{
                                    if(imageW>postImageMax){
                                        imageH = postImageMax*imageH/imageW
                                        imageW = postImageMax
                                    }
                                }
                            }
                            postH = CGFloat(11) + CGFloat(contentH) + yMargin + CGFloat(imageH);
                        }else{
                            postH = CGFloat(11) + CGFloat(contentH) + yMargin + CGFloat(imageW);
                        }
                    }
//                    else if(arr.count == 1){
//                        if(imageHeight>0&&imageWidth>0){
//                            var imageH = imageHeight
//                            var imageW = imageWidth
//                            if(imageH>=imageW){
//                                if(imageH>postImageMax){
//                                    imageW = postImageMax*imageW/imageH
//                                    imageH = postImageMax
//                                }else{
//                                    if(imageW>postImageMax){
//                                        imageH = postImageMax*imageH/imageW
//                                        imageW = postImageMax
//                                    }
//                                }
//                            }
//                             postH = CGFloat(11) + CGFloat(contentH) + yMargin + CGFloat(imageH);
//                        }else{
//                            postH = CGFloat(11) + CGFloat(contentH) + yMargin + CGFloat(imageW);
//                        }
//                    }else{
//                        postH = CGFloat(9) + CGFloat(contentH)
//                    }
                }else{
                    postH = CGFloat(11) + CGFloat(contentH)
                }
            }else{
                postH = CGFloat(9) + CGFloat(contentH) + CGFloat(10+37);
            }
            return postH + CGFloat(56+57);
        }
    }
    //图片高度
    var imageHeight : CGFloat = 0
    //图片宽度
    var imageWidth : CGFloat = 0
}


