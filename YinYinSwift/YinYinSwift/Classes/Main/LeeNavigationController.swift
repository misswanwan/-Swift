//
//  LeeNavigationController.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏标题
        let navBar = UINavigationBar.appearance()
       
//        //取消导航栏下的黑线
        navBar.shadowImage=UIImage()
        navBar.isTranslucent = false
 
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.lee_initSingleColor(color: 51),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        //标题颜色
        navBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
//        navBar.titleTextAttributes = [.foregroundColor: UIColor.lee_initSingleColor(color: 51)]
    }
   
    
}

extension LeeNavigationController
{
    
   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
