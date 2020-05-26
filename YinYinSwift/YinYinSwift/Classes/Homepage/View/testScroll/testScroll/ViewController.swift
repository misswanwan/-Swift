//
//  ViewController.swift
//  testScroll
//
//  Created by jzl on 2019/4/2.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var childVC : LeeViewController = {
        let childVC = LeeViewController()
        return childVC
    }()
    
    lazy var tableview :UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0.0, y: 64, width: 375, height: 667 - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homepageId")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
    }

    func initUI(){
        addChild(childVC)
        tableview.tableHeaderView = childVC.view
        view.addSubview(tableview)
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print("主界面滚动\(offsetY)")
    }
}

