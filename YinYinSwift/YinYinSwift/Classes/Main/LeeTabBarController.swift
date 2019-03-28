//
//  LeeTabBarController.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setChildrenVC()
        // Do any additional setup after loading the view.
    }
    

    func setChildrenVC(){
        addChildrenVC(childVC: LeeHomepageVC(), title: "社区", imageName: "LeeCommunityBar", selectedImage: "LeeCommunityPressBar")
        addChildrenVC(childVC: LeeDateVC(), title: "隐约", imageName: "LeeDateBar", selectedImage: "LeeDatePressBar")
        addChildrenVC(childVC: LeeTalkVC(), title: "语聊", imageName: "LeeTalkBar", selectedImage: "LeeTalkPressBar")
        addChildrenVC(childVC: LeeMineVC(), title: "我的", imageName: "LeeAccountBar", selectedImage: "LeeAccountPressBar")
    }
    
    func addChildrenVC(childVC:UIViewController,title:String,imageName:String,selectedImage:String){
        childVC.tabBarItem.image = UIImage(named: imageName)
        let selectImage = UIImage(named: selectedImage)
        childVC.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
        childVC.title = title
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.orange], for:.selected)
    
        
        //          [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//        titleHighlightedColor, NSForegroundColorAttributeName,
//        nil] forState:UIControlStateSelected];
        let nav = LeeNavigationController.init(rootViewController: childVC)
        self.addChild(nav)
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
