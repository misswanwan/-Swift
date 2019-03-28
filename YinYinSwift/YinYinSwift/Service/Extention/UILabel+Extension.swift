//
//  UILabel+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit
///Mark: -便利构造器可以解决
extension UILabel{
    static func lee_initLabel(frame:CGRect,text:String,textColor:UIColor,textA:NSTextAlignment,font:UIFont) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.text = text
        label.textColor = textColor
        label.textAlignment = textA
        label.font = font
        return label
    }
}
