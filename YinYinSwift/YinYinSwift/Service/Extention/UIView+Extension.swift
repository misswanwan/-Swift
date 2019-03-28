//
//  UIView+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit

///Mark: - view frame的延展
extension UIView{
    var lee_x :CGFloat{
        get{ return frame.origin.x }
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var lee_y :CGFloat{
        get { return frame.origin.y}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    var lee_w :CGFloat{
        get { return frame.size.width}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    var lee_h :CGFloat{
        get { return frame.size.height}
        set(newValue){
            var tempFrame:CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    /// size
    var lee_size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var lee_centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var lee_centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
}

extension UIView{
    
    static func lee_radius(view:UIView,r:Float){
        view.layer.cornerRadius = CGFloat(r)
        view.layer.masksToBounds = true
    }
    
    //添加渐变色
    static func lee_getGradient(view:UIView,startColor:UIColor,endColor:UIColor,startPoint:CGPoint,endPoint:CGPoint){
        let layer = CAGradientLayer.init()
        let rect = view.bounds
        layer.frame = rect
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.colors = [startColor.cgColor,endColor.cgColor];
        view.layer.insertSublayer(layer, at: 0);
    }
}
