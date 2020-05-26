//
//  LeeTalkCell.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/21.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeTalkCell: UITableViewCell ,LeeReigisterForNib {

    @IBOutlet weak var profileImageView: UIImageView! //头像
    @IBOutlet weak var nicknameLabel: UILabel!  //昵称
    @IBOutlet weak var sexButton: UIButton! //性别
    @IBOutlet weak var vipImageView: UIImageView!   //vip
    @IBOutlet weak var voiceBgView: UIView! //语音背景视图
    @IBOutlet weak var voiceLabel: UILabel! //语音时长
    @IBOutlet weak var voiceIcon: UIImageView!  //语音icon
    @IBOutlet weak var heightLabel: UILabel!    //身高
    @IBOutlet weak var weightLabel: UILabel!    //体重
    @IBOutlet weak var descptionLabel: UILabel! //描述
    @IBOutlet weak var statusView: UIView!  //状态
    @IBOutlet weak var statusLabel: UILabel!    //状态描述
    @IBOutlet weak var callButton: UIButton!    //拨打按钮
    @IBOutlet weak var priceLabel: UILabel!     //价格
    @IBOutlet weak var nicknameMasW: NSLayoutConstraint!    //昵称约束宽度
    
    
    var talkModel : LeeTalkModel? {
         didSet{
            profileImageView.kf.setImage(with: URL(string: (talkModel?.avatarUrl.addOSSPath())!))
            nicknameLabel.text = talkModel?.nickName
            descptionLabel.text = talkModel?.autograph
            priceLabel.text = "\(talkModel!.gold)币/分钟"
            statusLabel.text = "空闲"
            let arr = talkModel?.height.components(separatedBy: ";")
            if((arr?.count)!>1){
                heightLabel.text = arr![0]
                weightLabel.text = arr![1]
            }
            if(talkModel?.gender == 1){
                sexButton.setBackgroundImage(UIImage.init(named: "LeeMaleBG"), for: .normal)
                sexButton.setImage(UIImage.init(named: "LeeMaleIcon"), for: .normal)
            }else{
                sexButton.setBackgroundImage(UIImage.init(named: "LeeFamaleBG"), for: .normal)
                sexButton.setImage(UIImage.init(named: "LeeFamaleIcon"), for: .normal)
            }
            sexButton.setTitle(String.getAgeWithBirthDay(birthDay: (talkModel?.birthday)!), for: .normal)
            sexButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
            sexButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
            if((talkModel?.vType)!>0){
                vipImageView.image = UIImage.init(named: "LeeVIP")
                vipImageView.isHidden = false
            }else{
                vipImageView.isHidden = true
            }
            
            if(talkModel?.mark == 0){
                statusView.backgroundColor = UIColor.lee_initSingleColor(color: 180)
                statusLabel.textColor = UIColor.lee_initSingleColor(color: 180)
                statusLabel.text = "离线"
            }else{
                if(talkModel?.status == 1){
                    statusView.backgroundColor = UIColor.lee_convenient(r: 85, g: 220, b: 157)
                    statusLabel.textColor = UIColor.lee_convenient(r: 85, g: 220, b: 157)
                    statusLabel.text = "空闲"
                }else if(talkModel?.status == 2){
                    statusView.backgroundColor = UIColor.lee_initSingleColor(color: 180)
                    statusLabel.textColor = UIColor.lee_initSingleColor(color: 180)
                    statusLabel.text = "离线"
                }else if(talkModel?.status == 3){
                    statusView.backgroundColor = UIColor.lee_convenient(r: 255, g: 102, b: 0)
                    statusLabel.textColor = UIColor.lee_convenient(r: 255, g: 102, b: 0)
                    statusLabel.text = "离线"
                }else{
                    statusView.backgroundColor = UIColor.lee_initSingleColor(color: 180)
                    statusLabel.textColor = UIColor.lee_initSingleColor(color: 180)
                    statusLabel.text = "离线"
                }
            }
            
            voiceLabel.text = "\(talkModel!.duration)\""
            updateSubViewContraint()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }
    
    func initUI(){
        nicknameLabel.textColor = UIColor.lee_initSingleColor(color: 51)
        statusView.backgroundColor = UIColor.lee_convenient(r: 85, g: 220, b: 157)
        statusLabel.textColor = UIColor.lee_convenient(r: 85, g: 220, b: 157)
        voiceBgView.backgroundColor = UIColor.lee_convenient(r: 255, g: 193, b: 239)
        UIView.lee_radius(view: voiceBgView, r: 9)
        UIView.lee_radius(view: statusView, r: 2.5)
        voiceLabel.textColor = UIColor.lee_convenient(r: 243, g: 121, b: 216)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateSubViewContraint(){
        let nickNameSize = nicknameLabel.sizeThatFits(CGSize(width: Screen_Width, height: 21))
        if(nickNameSize.width>=120){
            nicknameMasW.constant = 120
        }else{
            nicknameMasW.constant = nickNameSize.width
        }
    }
 

}
