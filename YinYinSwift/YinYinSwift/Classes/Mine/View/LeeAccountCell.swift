//
//  LeeAccountCell.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/6.
//  Copyright © 2019 ww. All rights reserved.
//

import UIKit

class LeeAccountCell: UITableViewCell{

    var iconImageView : UIImageView?
    var iconLabel : UILabel?
    var lineView : UIView?
    var dataDic : NSDictionary?{
        didSet{
            iconImageView?.image = UIImage.init(named: dataDic?["image"] as! String)
            iconLabel?.text = (dataDic?["title"] as! String)
        }
    }
    
    //life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: public
    func showLineView(show:Bool) {
        lineView?.isHidden = show
    }

    //MARK: private
    func initUI(){
        iconImageView = UIImageView.init(frame: CGRect(x: 15, y: 20, width: 23, height: 23))
        iconLabel = UILabel.init(frame: CGRect(x: (iconImageView?.frame.maxX)!+10, y:20 , width: 200, height: 23))
        lineView = UIView.init(frame: CGRect(x: 15, y: 63, width: Screen_Width-30, height: 1))
        lineView?.backgroundColor = UIColor.lee_initSingleColor(color: 238)
        lineView?.isHidden = true
        addSubview(iconImageView!)
        addSubview(iconLabel!)
        addSubview(lineView!)
    }

}
