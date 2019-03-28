//
//  LeeBaseVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/23.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//withRenderingMode(.alwaysOriginal)
        let leftItem = UIBarButtonItem(image: UIImage.init(named: "LeeBackBlack")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    @objc func leftAction(){
        navigationController?.popViewController(animated: true)
    }
}
