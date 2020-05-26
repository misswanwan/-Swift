//
//  Const.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/19.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit

/// 屏幕的宽度
let Screen_Width = UIScreen.main.bounds.width
/// 屏幕的高度
let Screen_Height = UIScreen.main.bounds.height

let lee_statusBarH:CGFloat = UIApplication.shared.statusBarFrame.size.height
//状态栏高度为20的时候不是iphonex
let lee_isIphoneX = (lee_statusBarH==20) ? false : true
let lee_navH:CGFloat = 44.0
let lee_navTopH:CGFloat = lee_statusBarH+lee_navH
let lee_safeH:CGFloat = lee_isIphoneX ? 34 : 0
let lee_tabBottomH:CGFloat = lee_safeH + 49
let lee_totalH:CGFloat = lee_tabBottomH+lee_navTopH
let lee_scale = Screen_Width/375.0

let lee_baseUrl = "https://yinyinyuliao.com"

let lee_deviceId:String = (UIDevice.current.identifierForVendor?.uuidString)!
let lee_version:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

//log全局话
func JZLLog<T>(message: T,
                 logError: Bool = false,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}

typealias lee_Closure = (() -> Void)
typealias lee_optionClosure = (() -> (Void)?)
