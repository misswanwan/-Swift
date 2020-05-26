//
//  LeeViewController.swift
//  testScroll
//
//  Created by jzl on 2019/4/2.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeViewController: UIViewController {

    lazy var tableview :UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0.0, y: 64, width: 375, height: 400))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homepageId")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI(){
        view.addSubview(tableview)
    }
    

}

extension LeeViewController:UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print("ziziiziz滚动\(offsetY)")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      
        return true
    }
}
