//
//  LeeHomepageVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeHomepageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        initUI()
        
    }
    
    func initUI(){
        let loginVC = LeeLoginVC.loadStoryboard()
        let navVC = LeeNavigationController.init(rootViewController: loginVC)
        self.present(navVC, animated: true) {
            
        }
      
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
