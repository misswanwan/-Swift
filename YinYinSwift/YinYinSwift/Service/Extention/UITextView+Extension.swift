//
//  UITextView.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit
extension UITextView{
    
    static  func lee_initTextView(frame:CGRect,color:UIColor,font:UIFont)-> UITextView{
        let textView = UITextView()
        textView.frame = frame
        textView.textColor = color
        textView.font = font
        return textView
    }
    
}
