//
//  LeePostCell.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/1.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import Kingfisher

class LeePostCell: UITableViewCell{
    
    private let commonMargin = CGFloat(15)
    private let postImageMax = CGFloat(200)
    
    var profileImageView : UIImageView?
    var hostImageVIew : UIImageView?
    var nickNameLabel : UILabel?
    var timeLabel : UILabel?
    var sexButton : UIButton?
    var vipImageView : UIImageView?
    var contentLabel : UILabel?
    var recordView : LeeRecordView?
    var picImageView1 : UIImageView?
    var picImageView2 : UIImageView?
    var picImageView3 : UIImageView?
    var bottomView : UIView?
    var shareButton : UIButton?
    var likeButton :UIButton?
    var likeLabel : UILabel?
    var replyButton : UIButton?
    var replyLabel : UILabel?
    var lineView : UIView?
    var joinOtherCourse : ((_ userId:String) -> Void)?
    var shareCourse : ((_ model : LeePostModel) -> Void)?
    var likeCourse : ((_ dynamicId:String,_ index:Int) -> Void)?
    
    var postModel: LeePostModel? {
        didSet{
            profileImageView!.kf.setImage(with: URL(string: (postModel?.avatarUrl.addOSSPath())!))
            contentLabel!.text = postModel?.content
            nickNameLabel!.text = postModel?.nickName
            if(postModel?.gender == 1){
                sexButton!.setBackgroundImage(UIImage.init(named: "LeeMaleBG"), for: .normal)
                sexButton!.setImage(UIImage.init(named: "LeeMaleIcon"), for: .normal)
            }else{
                sexButton!.setBackgroundImage(UIImage.init(named: "LeeFamaleBG"), for: .normal)
                sexButton!.setImage(UIImage.init(named: "LeeFamaleIcon"), for: .normal)
            }
            sexButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 1)
            sexButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
            sexButton?.setTitle(String.getAgeWithBirthDay(birthDay: (postModel!.birthday)), for: .normal)
            if(postModel?.vType == 1){
                vipImageView?.image = UIImage.init(named: "LeeVIP")
                nickNameLabel?.textColor = UIColor.lee_convenient(r: 255, g: 54, b: 86)
            }else if(postModel?.vType == 2){
                vipImageView?.image = UIImage.init(named: "LeeBlueVip")
                nickNameLabel?.textColor = UIColor.lee_convenient(r: 255, g: 54, b: 86)
            }else{
                vipImageView?.isHidden = true;
                nickNameLabel?.textColor = UIColor.lee_initSingleColor(color: 45)
            }
            if(postModel?.uType == 2){
                hostImageVIew?.isHidden = true
                hostImageVIew!.kf.setImage(with: URL(string: (postModel?.exclusiveUrl.addOSSPath())!))
            }else{
                hostImageVIew?.isHidden = false
            }
            replyLabel!.text = "\(postModel!.discussCount)"
            likeLabel!.text = "\(postModel!.fabulousCount)"
            timeLabel!.text = Lee_Utils.leedateFormotStringWithInterval(timeStr: (postModel?.createDate)!)
            likeButton?.isSelected = (postModel?.isFabulous)!
            if(postModel?.type == 0){
                picImageView1?.isHidden = true
                picImageView2?.isHidden = true
                picImageView3?.isHidden = true
            }else if(postModel?.type == 1){
                recordView?.isHidden = true
                if(String.vaildStr(validStr: postModel?.url)){
                    let picUrlArr = postModel?.url.components(separatedBy: ",")
                    if((picUrlArr?.count)! >= 3){
                        picImageView1?.isHidden = false
                        picImageView2?.isHidden = false
                        picImageView3?.isHidden = false
                        picImageView1?.kf.setImage(with: URL(string: (picUrlArr![0].addOSSPath())))
                        picImageView2?.kf.setImage(with: URL(string: (picUrlArr![1].addOSSPath())))
                        picImageView3?.kf.setImage(with: URL(string: (picUrlArr![2].addOSSPath())))
                    }else if((picUrlArr?.count)! == 2){
                        picImageView1?.isHidden = false
                        picImageView2?.isHidden = false
                        picImageView3?.isHidden = true
                        picImageView1?.kf.setImage(with: URL(string: (picUrlArr![0].addOSSPath())))
                        picImageView2?.kf.setImage(with: URL(string: (picUrlArr![1].addOSSPath())))
                    }else{
                        picImageView1?.isHidden = false
                        picImageView2?.isHidden = true
                        picImageView3?.isHidden = true
                        picImageView1?.kf.setImage(with: URL(string: ((postModel?.url.addOSSPath())!)))
                    }
                   
//                    else if((picUrlArr?.count)! == 1){
//                        picImageView1?.isHidden = false
//                        picImageView2?.isHidden = true
//                        picImageView3?.isHidden = true
//                        picImageView1?.kf.setImage(with: URL(string: (picUrlArr![0].addOSSPath())))
//                    }else{
//                        picImageView1?.isHidden = true
//                        picImageView2?.isHidden = true
//                        picImageView3?.isHidden = true
//                    }
                }
            }else{
                picImageView1?.isHidden = true
                picImageView2?.isHidden = true
                picImageView3?.isHidden = true
                recordView?.isHidden = false
                recordView?.recordLength = postModel?.duration
            }
            if(postModel?.uType == 2){
                hostImageVIew?.isHidden = false
            }else{
                hostImageVIew?.isHidden = true
            }
            updateSubViewFrame()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI(){
        profileImageView = UIImageView.init(frame: CGRect(x: commonMargin, y: commonMargin, width: 38, height: 38))
        UIView.lee_radius(view: profileImageView!, r: 19)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tapGes:)))
        profileImageView?.addGestureRecognizer(tap)
        profileImageView?.isUserInteractionEnabled = true
        hostImageVIew = UIImageView.init(frame: CGRect(x: 41, y: 41, width: 15, height: 15))
        hostImageVIew?.image = UIImage.init(named: "LeeHostFlag")
        nickNameLabel = UILabel.lee_initLabel(frame: CGRect(x: profileImageView!.frame.maxX+10, y: 18, width: 100, height: 19), text: "", textColor: UIColor.lee_initSingleColor(color: 45), textA: .left, font: UIFont.systemFont(ofSize: 13))
        timeLabel = UILabel.lee_initLabel(frame: CGRect(x: profileImageView!.frame.maxX+10, y: nickNameLabel!.frame.maxY+1, width: 130, height: 15), text: "", textColor: UIColor.lee_initSingleColor(color: 171), textA: .left, font: UIFont.systemFont(ofSize: 11))
        sexButton = UIButton.lee_initTextButton(frame: CGRect(x: nickNameLabel!.frame.maxX+10, y: 21, width: 26, height: 14), text: "", textColor: UIColor.lee_initSingleColor(color: 255), font: UIFont.systemFont(ofSize: 10), bgColor: UIColor.lee_initSingleColor(color: 255))
         vipImageView = UIImageView.init(frame: CGRect(x: sexButton!.frame.maxX+10, y: 21, width: 14, height: 14))
        contentLabel = UILabel.lee_initLabel(frame: CGRect(x: commonMargin, y: 65, width: Screen_Width-30, height: 17), text: "", textColor: UIColor.lee_initSingleColor(color: 45), textA: .left, font: UIFont.systemFont(ofSize: 14))
        contentLabel?.numberOfLines = 0
        recordView = LeeRecordView()
//        recordView?.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        picImageView1 = UIImageView()
        picImageView2 = UIImageView()
        picImageView3 = UIImageView()
        picImageView1?.contentMode = .scaleAspectFill
        picImageView2?.contentMode = .scaleAspectFill
        picImageView3?.contentMode = .scaleAspectFill
        picImageView1?.clipsToBounds = true
        picImageView2?.clipsToBounds = true
        picImageView3?.clipsToBounds = true
        UIView.lee_radius(view: picImageView1!, r: 5)
        UIView.lee_radius(view: picImageView2!, r: 5)
        UIView.lee_radius(view: picImageView3!, r: 5)
        bottomView = UIView.init(frame: CGRect(x: 0, y: 65, width: Screen_Width, height: 50))
        lineView = UIView.init(frame: CGRect(x: 0, y: bottomView!.frame.maxY, width: Screen_Width, height: 7))
        lineView?.backgroundColor = UIColor.lee_initSingleColor(color: 245)
        addSubview(profileImageView!)
        addSubview(hostImageVIew!)
        addSubview(nickNameLabel!)
        addSubview(timeLabel!)
        addSubview(sexButton!)
        addSubview(vipImageView!)
        addSubview(contentLabel!)
        addSubview(recordView!)
        addSubview(picImageView1!)
        addSubview(picImageView2!)
        addSubview(picImageView3!)
        addSubview(bottomView!)
        addSubview(lineView!)
        setBottomUI()
        
        sexButton!.isUserInteractionEnabled = false;
        replyButton!.isUserInteractionEnabled = false;
    }
    
    func setBottomUI(){
        let bottomH = CGFloat(50)
        let imgWidth = CGFloat(20)
        let margin = CGFloat(2)
        let textH = CGFloat(14)
        let textW = CGFloat(30)
        let unitW = Screen_Width/3
        shareButton = UIButton.lee_initImageButton(frame: CGRect(x: (unitW-imgWidth-margin-textW)/2, y: (bottomH - imgWidth)/2, width: imgWidth, height: imgWidth), image: UIImage.init(named: "LeePostShare")!)
        shareButton?.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        replyButton = UIButton.lee_initImageButton(frame: CGRect(x: unitW+(unitW-imgWidth)/2, y: (bottomH - imgWidth)/2, width: imgWidth, height: imgWidth), image: UIImage.init(named: "LeeComment")!)
         
        replyLabel = UILabel.lee_initLabel(frame: CGRect(x: replyButton!.frame.maxX+margin, y: (bottomH-textH)/2, width: textW, height: textH), text: "0", textColor: UIColor.lee_initSingleColor(color: 119), textA: .center, font: UIFont.systemFont(ofSize: 12))
        likeButton = UIButton.lee_initImageButton(frame: CGRect(x: 2*unitW+(unitW-imgWidth-margin-textW)/2, y: (bottomH - imgWidth)/2, width: imgWidth, height: imgWidth), image: UIImage.init(named: "LeeLike")!)
        likeButton?.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        likeButton?.setImage(UIImage.init(named: "LeeLikeSeleted"), for: .selected)
        likeLabel = UILabel.lee_initLabel(frame: CGRect(x: likeButton!.frame.maxX+margin, y: (bottomH-textH)/2, width: textW, height: textH), text: "0", textColor: UIColor.lee_initSingleColor(color: 119), textA: .center, font: UIFont.systemFont(ofSize: 12))
        bottomView?.addSubview(shareButton!)
        bottomView?.addSubview(replyButton!)
        bottomView?.addSubview(replyLabel!)
        bottomView?.addSubview(likeButton!)
        bottomView?.addSubview(likeLabel!)
    }
    
    func updateSubViewFrame(){
        let maxW = Screen_Width - 30
        let nickNameSize = nickNameLabel?.sizeThatFits(CGSize(width: maxW, height: CGFloat(MAXFLOAT)))
        nickNameLabel?.frame = CGRect(x: (profileImageView?.frame.maxX)!+10, y: 18, width: (nickNameSize?.width)!, height: 19)
        sexButton?.frame = CGRect(x: (nickNameLabel?.frame.maxX)!+10
            , y: 21, width: 26, height: 14)
        if(postModel?.vType == 2){
            vipImageView?.frame = CGRect(x: (sexButton?.frame.maxX)!+10, y: 21, width: 28, height: 14)
        }else{
            vipImageView?.frame = CGRect(x: (sexButton?.frame.maxX)!+10, y: 21, width: 14, height: 14)
        }
 
        var changeH = CGFloat(0)
        let contetntSize = contentLabel?.sizeThatFits(CGSize(width: maxW, height: CGFloat(MAXFLOAT)))
        let contentH = (contetntSize?.height)!>CGFloat(40) ? CGFloat(40):contetntSize!.height
        contentLabel?.frame = CGRect(x: commonMargin, y: (profileImageView?.frame.maxY)!+12, width: Screen_Width-2 * commonMargin, height: contentH)
        if(postModel?.type == 0){
            changeH = 11 + contentH
        }else if(postModel?.type == 1){
            if(String.vaildStr(validStr: postModel?.url)){
                let picUrlArr = postModel?.url.components(separatedBy: ",")
                let margin = CGFloat(8)
                let yMargin = CGFloat(10)
                let imageW = (Screen_Width - 2*margin - 2*commonMargin)/3
                if((picUrlArr?.count)! > 1){
                    picImageView1?.frame = CGRect(x: commonMargin, y: (contentLabel?.frame.maxY)!+yMargin, width: imageW, height: imageW)
                    picImageView2?.frame = CGRect(x: commonMargin+(picImageView1?.frame.maxX)!+margin, y: (contentLabel?.frame.maxY)!+yMargin, width: imageW, height: imageW)
                    picImageView3?.frame = CGRect(x: commonMargin+(picImageView2?.frame.maxX)!+margin, y: (contentLabel?.frame.maxY)!+yMargin, width: imageW, height: imageW)
                    changeH = 11 + contentH + yMargin + imageW
                }else if(picUrlArr?.count == 1){
                    if((postModel?.imageWidth)! > CGFloat(0) && (postModel?.imageHeight)! > CGFloat(0)){
                        var imageWidth = postModel?.imageWidth
                        var imageHeight = postModel?.imageHeight
                        if(Float(imageHeight!) >= Float(imageWidth!)){
                            if(Float(imageHeight!)>Float(postImageMax)){
                                imageWidth = postImageMax*imageWidth!/imageHeight!
                                imageHeight = postImageMax
                            }
                        }else{
                            if(Float(imageWidth!)>Float(postImageMax)){
                                imageHeight = postImageMax*imageHeight!/imageWidth!
                                imageWidth = postImageMax
                            }
                        }
                        picImageView1?.frame = CGRect(x: commonMargin, y: (contentLabel?.frame.maxY)!+yMargin, width: imageWidth!, height: imageHeight!)
                        changeH = 11 + contentH + yMargin + imageHeight!
                    }else{
                        picImageView1?.frame = CGRect(x: commonMargin, y: (contentLabel?.frame.maxY)!+yMargin, width: imageW, height: imageW)
                        changeH = 11 + contentH + yMargin + imageW
                    }
                }else{
                    changeH = 9 + contentH
                }
            }else{
                changeH = 11 + contentH
            }
        }else{
            changeH  = 9 + contentH + 10 + 37
            recordView?.frame = CGRect(x: 0, y: (contentLabel?.frame.maxY)!+10, width: Screen_Width, height: 37)
        }
        bottomView?.frame  = CGRect(x: 0, y: (profileImageView?.frame.maxY)!+changeH, width: Screen_Width, height: 50)
        lineView?.frame = CGRect(x: 0, y: (profileImageView?.frame.maxY)!+changeH+50, width: Screen_Width, height: 7)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension LeePostCell{
    //点击头像
    @objc func tapAction(tapGes:UITapGestureRecognizer){
        self.joinOtherCourse!((postModel?.userId)!)
    }
    //分享
    @objc func shareAction(){
        self.shareCourse!(postModel!)
    }
    
    //点赞
    @objc func likeAction(){
        self.likeCourse!((postModel?.id)!,tag)
    }
}

