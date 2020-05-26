//
//  UIButton+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    static func lee_initTextButton(frame:CGRect,text:String,textColor:UIColor,font:UIFont,bgColor:UIColor) -> UIButton {
        let textButton = UIButton()
        textButton.frame = frame
        textButton.setTitle(text, for: .normal)
         textButton.setTitleColor(textColor, for: .normal)
        textButton.titleLabel?.font = font
        textButton.backgroundColor = bgColor
        return textButton
    }
    
    static func lee_initImageButton(frame:CGRect,image:UIImage) -> UIButton {
        let imageButton = UIButton()
        imageButton.frame = frame
        imageButton.setImage(image, for: .normal)
       
        return imageButton
    }
}

var Lee_RepeatKey: String = "Lee_RepeatKey"

extension UIButton{
    
    struct RuntimeKey {
        static let zm_eventUnavailable = UnsafeRawPointer.init(bitPattern: "zm_eventUnavailable".hashValue)!
        static let eventInterval = 1.5 // 按钮重复点击间隔
    }
    //动态的添加一个 是否能重复的属性
    var leeCanRepeat: Bool {
        set {
            objc_setAssociatedObject(self, &Lee_RepeatKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            if let result = objc_getAssociatedObject(self, &Lee_RepeatKey) as? Bool {
                return result
            }
            return false
        }
    }
    
}


protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}
extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}

extension UIButton: SelfAware {
    static func awake() {
        UIButton.classInit()
    }
    
    static func classInit() {
        swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        let normalSelector = #selector(UIButton.sendAction(_:to:for:))
        let swizzledSelector = #selector(swizzled_senderAction(_:to:event:))
        let originalMethod = class_getInstanceMethod(UIButton.self, normalSelector)
        let swizzledMethod = class_getInstanceMethod(UIButton.self, swizzledSelector)
        
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        
        let isAdd = class_addMethod(UIButton.self, normalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if isAdd {
            class_replaceMethod(UIButton.self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
    }()
    
    @objc private func swizzled_senderAction(_ action: Selector, to: Any?, event: UIEvent?) {
        //        print("警告      我是按钮被点击了")
        if eventUnavailable == nil {
            eventUnavailable = false
        }
        if !eventUnavailable! {
            if(!(self.leeCanRepeat)){
                self.eventUnavailable = true
                swizzled_senderAction(action, to: to, event: event)
                DispatchQueue.main.asyncAfter(deadline: .now() + RuntimeKey.eventInterval, execute: {
                    self.eventUnavailable = false
                })
            }else{
                self.eventUnavailable = false
                swizzled_senderAction(action, to: to, event: event)
            }
        }
    }
    
    private var eventUnavailable: Bool? {
        set{
            objc_setAssociatedObject(self, RuntimeKey.zm_eventUnavailable, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return objc_getAssociatedObject(self, RuntimeKey.zm_eventUnavailable) as? Bool
        }
    }
    
}
