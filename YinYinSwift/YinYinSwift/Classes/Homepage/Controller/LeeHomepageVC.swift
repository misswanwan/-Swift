//
//  LeeHomepageVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import MJRefresh

private let homepageIdentifier = "homepageIdentifier"

class LeeHomepageVC: LeeBaseVC {
    
    private lazy var tableView: LeeTouchTableView = {
        let tableView = LeeTouchTableView.init(frame: CGRect(x: 0.0, y: lee_navTopH, width: Screen_Width, height: Screen_Height - lee_totalH))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeeScrollCell.self, forCellReuseIdentifier: homepageIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var canScroll:Bool = true
    var homepageLabel: UILabel!
    var searchButton: UIButton!
    var homepageHeaderView: LeeHomepageHeaderView!
    var hotVC: LeeHotPostVC = LeeHotPostVC()
    var newVC: LeeNewPostVC = LeeNewPostVC()
    var scrollCell: LeeScrollCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initUI()
    }
    
    func initUI(){
            
            hotVC.refreshCourse = { [weak self] in
                self?.tableView.mj_header.endRefreshing()
            }
            newVC.refreshCourse = {[weak self] in
                self?.tableView.mj_header.endRefreshing()
            }
            homepageLabel =  UILabel.lee_initLabel(frame: CGRect(x: 16, y: lee_statusBarH, width: 80, height: lee_navH), text:  "首页", textColor: UIColor.lee_initSingleColor(color: 51), textA: .left, font:  UIFont.boldSystemFont(ofSize: 21))
            searchButton = UIButton.lee_initImageButton(frame: CGRect(x: Screen_Width-49, y: lee_statusBarH, width: 44, height: 44), image: UIImage.init(named: "LeeNavSearch")!)
            searchButton.addTarget(self, action: #selector(searchRightAction(_:)), for: .touchUpInside)
            homepageHeaderView = LeeHomepageHeaderView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 140))
            homepageHeaderView.linkClouse = {[weak self](index :Int) in
                JZLLog(message: self?.canScroll)
            }
            homepageHeaderView.segClouse = {[weak self](index :Int) in
                self!.scrollCell.scrollToIndex(index: index)
                self?.loadAction(index: index)
            }
            view.addSubview(homepageLabel)
            view.addSubview(searchButton)
            view.addSubview(tableView)
        
//        // 刷新头部
        let header = MJRefreshNormalHeader { [weak self] in
            if(self?.scrollCell.currentIndex == 0){
                self?.hotVC.pageNo = 1
                self?.hotVC.requestHotPostList(isLoadMore: false)
            }else{
                self?.hotVC.pageNo = 1
                self?.newVC.requestHotPostList(isLoadMore: false);
            }
        }
        header?.isAutomaticallyChangeAlpha = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
       
        tableView.tableHeaderView = homepageHeaderView
        
    }
    
    @objc func searchRightAction(_ sender: UISlider){
        JZLLog(message: "点击了右侧按钮")
    }
    
    @objc func changeScrollStatus(){
        self.canScroll = true
        self.scrollCell.setCanScroll(flag: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.navigationBar.isHidden = true;
        NotificationCenter.default.addObserver(self , selector: #selector(changeScrollStatus), name: NSNotification.Name.init("leaveTop"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false;
        NotificationCenter.default.removeObserver(self)
    }
}

extension LeeHomepageVC: UITableViewDelegate ,UITableViewDataSource ,UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        scrollCell = (tableView.dequeueReusableCell(withIdentifier: homepageIdentifier, for: indexPath) as! LeeScrollCell)
        scrollCell.setChildVCs(childVCs: [hotVC,newVC], parentVC: self)
        scrollCell.scrollClouse = {[weak self] (index :Int) in
             self?.homepageHeaderView.changeIndex(index: index)
            self?.loadAction(index: index)
        }
        return scrollCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        JZLLog(message: Screen_Height - lee_totalH - CGFloat(40))
        return Screen_Height - lee_totalH - CGFloat(40);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(140)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetmax_y = self.tableView.rect(forSection: 0).origin.y-40
        let offset_y = scrollView.contentOffset.y
        if offset_y >= offsetmax_y {
            //滑到顶了
            //固定
            scrollView.contentOffset = CGPoint.init(x: 0, y: offsetmax_y)
            if self.canScroll == true {
                self.canScroll = false
                scrollCell.setCanScroll(flag: true)
            }
        }else{
            //未到顶
            if self.canScroll == false {
                scrollView.contentOffset = CGPoint.init(x: 0, y: offsetmax_y)
            }
        }
        self.tableView.showsVerticalScrollIndicator = self.canScroll ? true:false
    }
    
    func loadAction(index:Int){
        if(index == 0){
            if(!hotVC.loadFlag){
                tableView.mj_header.beginRefreshing()
            }
        }else if(index == 1){
            if(!newVC.loadFlag){
                tableView.mj_header.beginRefreshing()
            }
        }
    }
 
}
