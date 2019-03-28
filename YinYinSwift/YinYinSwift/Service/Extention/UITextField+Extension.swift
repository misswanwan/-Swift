//
//  UITextField+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    static func lee_initTextfield(frame:CGRect,placeholder:String,color:UIColor,font:UIFont,keyboardType:UIKeyboardType)-> UITextField{
        let textField = UITextField()
        textField.frame = frame
        textField.placeholder = placeholder
        textField.textColor = color
        textField.font = font
        textField.keyboardType = keyboardType
        return textField
    }
}

