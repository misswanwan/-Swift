//
//  UIColor+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    static func lee_initSingleColor(color:Int) -> UIColor{
        return UIColor.init(red: CGFloat(color)/CGFloat(255), green: CGFloat(color)/CGFloat(255), blue: CGFloat(color)/CGFloat(255), alpha: 1)
    }
    
    static func lee_convenient(r:Int,g:Int,b:Int)->UIColor{
        return UIColor.init(red: CGFloat(r)/CGFloat(255), green: CGFloat(g)/CGFloat(255), blue: CGFloat(b)/CGFloat(255), alpha: 1)
    }
    
}

