//
//  LeeAccountHeaderView.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/6.
//  Copyright © 2019 ww. All rights reserved.
//

import UIKit

class LeeAccountHeaderView: UIView {
    
    private var headerBgView : UIView!
    var profileImageView : UIImageView!
    private var nickNameLabel : UILabel!
    private var idLabel : UILabel!
    private var charmLabel : UILabel!
    private var sideImageView : UIImageView!
    private var rechargeBgView : UIView!
    private var attentionLabel : UILabel!
    private var fansLabel : UILabel!
    private var friendLabel : UILabel!
    private var attentionTipLabel : UILabel!
    private var fansTipLabel : UILabel!
    private var friendTipLabel : UILabel!
    private var rechargeButton : UIButton!
    private var sexButton : UIButton!
    private var vipImageView : UIImageView!
    private var hostImageView : UIImageView!
    private var coverView : UIView!
    var profileImageClouse:(() -> Void)?
    var clickClouse:((Int) -> Void)?
    var rechargeClouse:(() -> Void)?
    var userModel : LeeMineUserModel?{
        didSet{
            nickNameLabel.text = userModel!.nickName
            idLabel.text = "ID:\(userModel!.number)"
            profileImageView.kf.setImage(with: URL.init(string: (userModel?.avatarUrl.addOSSPath())!), placeholder: UIImage.init(named: "Lee_firstMet"), options: nil, progressBlock: nil, completionHandler: { (result) in
            })
            
            if(userModel?.gender == 1){
                sexButton.setBackgroundImage(UIImage.init(named: "LeeMaleBG"), for: .normal)
                sexButton.setImage(UIImage.init(named: "LeeMaleIcon"), for: .normal)
            }else if(userModel?.gender == 2){
                sexButton.setBackgroundImage(UIImage.init(named: "LeeFamaleBG"), for: .normal)
                sexButton.setImage(UIImage.init(named: "LeeFamaleIcon"), for: .normal)
            }
            sexButton.setTitle(Lee_Utils.getAgeWithBirthday(birthday: userModel!.birthday), for: .normal)
            sexButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
            sexButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
            if(userModel?.vType == 1){
                vipImageView.image = UIImage.init(named: "LeeVIP")
                vipImageView.isHidden = false
            }else if(userModel?.vType == 2){
                vipImageView.image = UIImage.init(named: "LeeBlueVip")
                vipImageView.isHidden = false
            }else{
                vipImageView.isHidden = true
            }
            if(userModel?.type == 2){
                hostImageView.isHidden = false
                hostImageView.kf.setImage(with: URL.init(string: (userModel?.exclusiveUrl.addOSSPath())!), placeholder: UIImage.init(named: "Lee_firstMet"), options: nil, progressBlock: nil, completionHandler: { (result) in
                })
            }else{
                hostImageView.isHidden = true
            }
            updateFrame()
        }
    }
    var userSubModel : LeeMineUserSubModel?{
        didSet{
            fansLabel.text = userSubModel?.fans
            attentionLabel.text = userSubModel?.follow
            charmLabel.text = "魅力值:\(userSubModel!.totalIncome/10) 土豪值:\(userSubModel!.wealth)"
            friendLabel.text = "\(userSubModel!.friendCount)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:initUI
    private func initUI(){
        headerBgView = UIView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 251))
        headerBgView.contentMode = .scaleAspectFill
        let bgImage = UIImage.lee_scaleToSize(image: UIImage.init(named: "LeeAccountBgView")!, size: headerBgView.frame.size)
        headerBgView.backgroundColor = UIColor.init(patternImage: bgImage!)
        profileImageView = UIImageView.init(frame: CGRect(x: 16, y: 81, width: 80, height: 80))
        profileImageView.isUserInteractionEnabled = true
        let profileGes = UITapGestureRecognizer.init(target: self, action: #selector(profileAction))
        profileImageView.addGestureRecognizer(profileGes)
        UIView.lee_radius(view: profileImageView, r: 40)
        coverView = UIView.init(frame: CGRect(x: 0, y: 40, width: Screen_Width, height: 149))
        coverView.isHidden = true
        nickNameLabel = UILabel.lee_initLabel(frame: CGRect(x: profileImageView.frame.maxX+15, y: 81, width: 100, height: 31), text: "", textColor: UIColor.white, textA: .left, font: UIFont.boldSystemFont(ofSize: 22))
        sexButton = UIButton.lee_initTextButton(frame: CGRect(x: nickNameLabel.frame.maxX+5, y: 96, width: 28, height: 14), text: "", textColor: .white, font: UIFont.systemFont(ofSize: 10), bgColor: .clear)
        vipImageView = UIImageView.init(frame: CGRect(x: sexButton.frame.maxX+5, y: 96, width: 14, height: 14))
        hostImageView = UIImageView.init(frame: CGRect(x: profileImageView.frame.maxX-25, y: profileImageView.frame.maxY-25, width: 20, height: 20))
        hostImageView.image = UIImage.init(named: "LeeHostFlag")
        idLabel = UILabel.lee_initLabel(frame: CGRect(x: profileImageView.frame.maxX+15, y: nickNameLabel.frame.maxY+2, width: 200, height: 14), text: "", textColor: .white, textA: .left, font: UIFont.systemFont(ofSize: 12))
        sideImageView = UIImageView.init(frame: CGRect(x: Screen_Width-22, y: 115, width: 7, height: 12))
        sideImageView.image = UIImage.init(named: "LeeAccountSide")
        charmLabel = UILabel.lee_initLabel(frame: CGRect(x: profileImageView.frame.maxX+15, y: idLabel.frame.maxY+11, width: 200, height: 17), text: "", textColor: .white, textA: .left, font: UIFont.systemFont(ofSize: 12))
        rechargeBgView = UIView.init(frame: CGRect(x: 15, y: 189, width: Screen_Width-30, height: 81))
        rechargeBgView.layer.backgroundColor = UIColor.white.cgColor
        rechargeBgView.layer.masksToBounds = false
        rechargeBgView.layer.cornerRadius = 4
        rechargeBgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        rechargeBgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        rechargeBgView.layer.shadowOpacity = 1
        rechargeBgView.layer.shadowRadius = 6
        headerBgView.addSubview(profileImageView)
        headerBgView.addSubview(nickNameLabel)
        headerBgView.addSubview(hostImageView)
        headerBgView.addSubview(sexButton)
        headerBgView.addSubview(vipImageView)
        headerBgView.addSubview(idLabel)
        headerBgView.addSubview(sideImageView)
        headerBgView.addSubview(charmLabel)
        headerBgView.addSubview(rechargeBgView)
        headerBgView.addSubview(coverView)
        self.addSubview(headerBgView)
        setRechageUI()
    }
    
    private func setRechageUI(){
        let unitH = 81
        let attentionView = UIView.init(frame: CGRect(x: 0, y: 0, width: unitH, height: unitH))
        attentionView.backgroundColor = .white
        attentionView.isUserInteractionEnabled = true
        attentionLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: 17, width: 80, height: 28), text: "", textColor: UIColor.lee_initSingleColor(color: 45), textA: .center, font:UIFont(name: "AvenirNextCondensed-DemiBold", size: 22)!)
        attentionTipLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: attentionLabel.frame.maxY+4, width: 80, height: 17), text: "关注", textColor: UIColor.lee_initSingleColor(color: 153), textA: .center, font: UIFont.systemFont(ofSize: 12))
        attentionView.addSubview(attentionLabel)
        attentionView.addSubview(attentionTipLabel)
        attentionView.tag = 100
        UIView.lee_radius(view: attentionView, r: 4)
        let fansView = UIView.init(frame: CGRect(x: Int(attentionView.frame.maxX), y: 0, width: unitH, height: unitH))
        fansView.backgroundColor = .white
        fansView.isUserInteractionEnabled = true
        fansLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: 17, width: 80, height: 28), text: "", textColor: UIColor.lee_initSingleColor(color: 45), textA: .center, font:UIFont(name: "AvenirNextCondensed-DemiBold", size: 22)!)
        fansTipLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: attentionLabel.frame.maxY+4, width: 80, height: 17), text: "粉丝", textColor: UIColor.lee_initSingleColor(color: 153), textA: .center, font: UIFont.systemFont(ofSize: 12))
        fansView.addSubview(fansLabel)
        fansView.addSubview(fansTipLabel)
        fansView.tag = 101
        let friendView = UIView.init(frame: CGRect(x: Int(fansView.frame.maxX), y: 0, width: unitH, height: unitH))
        friendView.backgroundColor = .white
        friendView.isUserInteractionEnabled = true
        friendLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: 17, width: 80, height: 28), text: "", textColor: UIColor.lee_initSingleColor(color: 45), textA: .center, font:UIFont(name: "AvenirNextCondensed-DemiBold", size: 22)!)
        friendTipLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: attentionLabel.frame.maxY+4, width: 80, height: 17), text: "隐友", textColor: UIColor.lee_initSingleColor(color: 153), textA: .center, font: UIFont.systemFont(ofSize: 12))
        friendView.addSubview(friendLabel)
        friendView.addSubview(friendTipLabel)
        friendView.tag = 102
        let attentionGes = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(recognizer:)))
        let fansGes = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(recognizer:)))
        let friendGes = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(recognizer:)))
        attentionView.addGestureRecognizer(attentionGes)
        fansView.addGestureRecognizer(fansGes)
        friendView.addGestureRecognizer(friendGes)
        
        rechargeButton = UIButton.lee_initTextButton(frame: CGRect(x: rechargeBgView.lee_w-100, y: 21, width: 82, height: 40), text: "充值", textColor: .white, font: UIFont.systemFont(ofSize: 15), bgColor: UIColor.lee_globalColor())
        rechargeButton.addTarget(self, action: #selector(rechargeAction), for: .touchUpInside)
        UIView.lee_radius(view: rechargeButton, r: 20)
        rechargeBgView.addSubview(attentionView)
        rechargeBgView.addSubview(fansView)
        rechargeBgView.addSubview(friendView)
        rechargeBgView.addSubview(rechargeButton)
        
    }

    //MARK:private method
    private func updateFrame(){
        let nickNameSize = nickNameLabel.sizeThatFits(CGSize(width: Screen_Width, height: CGFloat(MAXFLOAT)))
        nickNameLabel.frame = CGRect(x: profileImageView.frame.maxX+15, y: 81, width: nickNameSize.width, height: nickNameSize.height)
        sexButton.frame = CGRect(x: nickNameLabel.frame.maxX+5, y: 96, width: 28, height: 14)
        if(userModel?.vType == 2){
            vipImageView.frame = CGRect(x: sexButton.frame.maxX, y: 96, width: 28, height: 14)
        }else{
            vipImageView.frame = CGRect(x: sexButton.frame.maxX, y: 96, width: 14, height: 14)
        }
    }
    
    @objc private func profileAction(){
        self.profileImageClouse!()
    }
    
    @objc private func clickAction(recognizer : UITapGestureRecognizer){
        let responseView = recognizer.view
        self.clickClouse!(responseView!.tag)
    }
    
    @objc private func rechargeAction(){
        self.rechargeClouse!()
    }
}
