//
//  LeeTabBarController.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import SVProgressHUD
class LeeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setChildrenVC()
// MARK : - 免登陆
        noLandingAction()
        // Do any additional setup after loading the view.
    }
    

    func setChildrenVC(){
        addChildrenVC(childVC: LeeHomepageVC(), title: "社区", imageName: "LeeCommunityBar", selectedImage: "LeeCommunityPressBar")
        addChildrenVC(childVC: LeeTalkVC(), title: "语聊", imageName: "LeeTalkBar", selectedImage: "LeeTalkPressBar")
        addChildrenVC(childVC: LeeDateVC(), title: "初见", imageName: "LeeDateBar", selectedImage: "LeeDatePressBar")
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
    
    func noLandingAction(){
        var phone = ""
        if UserDefaults.standard.value(forKey: String.lee_phoneNumberKey()) != nil {
            phone = UserDefaults.standard.value(forKey: String.lee_phoneNumberKey()) as!String
        }else{
            phone = ""
        }
        
        NetworkTool.noLandingRequest(mobile: String.replaceNilAction(replaceStr: phone), completionHandler: { [weak self]  (dataDic) in
            let code = dataDic["code"]as!NSNumber
            if code == leeNetworkReturnSuccess{
                let dic : Dictionary = dataDic["object"] as! [String: Any]
                //设置token 和 userid 到本地
                if  let token = dic["token"]{
                    UserDefaults.standard.set(token, forKey: String.lee_userToken())
                }
                if let userId  = dic["id"]{
                    UserDefaults.standard.set(userId, forKey: String.lee_useridKey())
                }
                LeeUserManager.shared.userModel = LeeUserModel.deserialize(from: dic)!
                self?.dismiss(animated: true, completion: nil)
            }else{
                let loginVC = LeeLoginVC.loadStoryboard()
                let navVC = LeeNavigationController.init(rootViewController: loginVC)
                self?.present(navVC, animated: true) {
                }
            }
            
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//    }
    
 

}
