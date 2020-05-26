//
//  LeeTalkRecommendCell.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/5.
//  Copyright © 2019 ww. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class LeeTalkRecommendCell: UICollectionViewCell,LeeReigisterForNib {
    
    var bgView : UIView?
    var profileImageView : UIImageView?
    var nickNameLabel : UILabel?
    var voiceBgView : UIView?
    var voiceButton : UIButton?
    var voicLabel : UILabel?
    var descriptionLabel : UILabel?
    var callButton : UIButton?
    var priceLabel : UILabel?
    
    var recommendModel : LeeTalkModel?{
        didSet{
            profileImageView!.kf.setImage(with: URL(string: (recommendModel?.avatarUrl.addOSSPath())!))
            nickNameLabel?.text = recommendModel?.nickName
            descriptionLabel?.text = recommendModel?.autograph
            voicLabel?.text = "\(recommendModel?.duration ?? 0)\""
            priceLabel?.text = "\(recommendModel?.gold ?? "0")币/分钟"
            let nickNameSize = nickNameLabel?.sizeThatFits(CGSize(width: Screen_Width-100, height: 23))
            nickNameLabel?.snp.remakeConstraints({ (make) in
                make.left.equalTo((profileImageView?.snp.right)!).offset(16)
                make.top.equalToSuperview().offset(21)
                make.size.equalTo(CGSize(width: nickNameSize!.width, height: 23))
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        bgView = UIView.init()
        bgView?.backgroundColor = UIColor.lee_convenient(r: 255, g: 228, b: 232, a: 0.35)
        UIView.lee_radius(view: bgView!, r: 4)
        profileImageView = UIImageView.init()
        UIView.lee_radius(view: profileImageView!, r: 4)
        nickNameLabel = UILabel.lee_initLabel(frame: CGRect.zero, text: "", textColor: UIColor.lee_initSingleColor(color: 51), textA: .left, font: UIFont.systemFont(ofSize: 16))
        voiceBgView = UIView.init()
        voiceBgView?.backgroundColor = UIColor.lee_convenient(r: 255, g: 215, b: 221)
        UIView.lee_radius(view: voiceBgView!, r: 9)
        voiceButton = UIButton.lee_initImageButton(frame: CGRect.zero, image: UIImage.init(named: "LeeRedCall")!)
        voicLabel = UILabel.lee_initLabel(frame: CGRect.zero, text: "", textColor: UIColor.lee_convenient(r: 255, g: 59, b: 94), textA: .center, font: UIFont.systemFont(ofSize: 12))
        descriptionLabel = UILabel.lee_initLabel(frame: CGRect.zero, text: "", textColor: UIColor.lee_initSingleColor(color: 153), textA: .left, font: UIFont.systemFont(ofSize: 13))
        descriptionLabel?.numberOfLines = 0
        callButton = UIButton.lee_initImageButton(frame: CGRect.zero, image: UIImage.init(named: "LeeTalkRedCall")!)
        priceLabel = UILabel.lee_initLabel(frame: CGRect.zero, text: "", textColor: UIColor.lee_initSingleColor(color: 18), textA: .center, font: UIFont.systemFont(ofSize: 10))
        voiceBgView!.addSubview(voiceButton!)
        voiceBgView!.addSubview(voicLabel!)
        bgView!.addSubview(profileImageView!)
        bgView!.addSubview(nickNameLabel!)
        bgView!.addSubview(voiceBgView!)
        bgView!.addSubview(descriptionLabel!)
        bgView!.addSubview(callButton!)
        bgView!.addSubview(priceLabel!)
        self.addSubview(bgView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview()
        })
        profileImageView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 70, height: 70))
            make.centerY.equalToSuperview()
        })
        nickNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((profileImageView?.snp.right)!).offset(16)
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 50, height: 23))
        })
        voiceBgView?.snp.makeConstraints({ (make) in
            make.left.equalTo((nickNameLabel?.snp.right)!).offset(10)
            make.top.equalToSuperview().offset(24)
            make.size.equalTo(CGSize(width: 48, height: 18))
        })
        voiceButton?.snp.makeConstraints({ (make) in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 18, height: 18))
        })
        voicLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((voiceButton?.snp.right)!)
            make.top.right.bottom.equalToSuperview()
        })
        descriptionLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((profileImageView?.snp.right)!).offset(16)
            make.right.equalToSuperview().offset(-60)
            make.top.equalTo((nickNameLabel?.snp.bottom)!).offset(9)
            make.height.equalTo(20)
        })
        callButton?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(31)
            make.size.equalTo(CGSize(width: 32, height: 32))
        })
        priceLabel?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 72, height: 14))
            make.top.equalTo((callButton?.snp.bottom)!).offset(5)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
