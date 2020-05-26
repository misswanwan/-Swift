//
//  LeeHotPostVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/1.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class LeeHotPostVC: LeeBaseVC,ScrollTabProtocal {

    private let hotPostIdentifier = "hotPostIdentifier"
    
    var refreshCourse : lee_Closure?
    var vcCanScroll = false
    var pageSize:NSInteger = 5
    var pageNo:Int = 0
    var pageCount:NSInteger = 0
    var dataArr = [LeePostModel]()
    var loadFlag = false //是否加载过
    
     lazy var tableView: LeeTouchTableView = {
        let tableView = LeeTouchTableView.init(frame: CGRect(x: 0.0, y: 0, width: Screen_Width, height: Screen_Height - lee_totalH - 40))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeePostCell.self, forCellReuseIdentifier: hotPostIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        pageNo = 1
        view.addSubview(tableView)
        let footer = MJRefreshBackNormalFooter  {[weak self] in
            self!.pageNo += 1
            self!.requestHotPostList(isLoadMore: true)
        }
        tableView.mj_footer = footer
    }
    
    func joinOtherPageAction(userId:String){
        
    }
    
    func likeAction(dynamicId:String,index:Int){
        
    }
    
    func shareActionAction(postModel:LeePostModel){
        
    }
   
}

extension LeeHotPostVC{
    func requestHotPostList(isLoadMore:Bool){
        NetworkTool.homepagePostListRequest(type: 2, pageNo: self.pageNo, pageSize: self.pageSize, completionHandler: { [weak self]  (dataDic) in
            self!.refreshCourse?()
            self?.tableView.mj_footer.endRefreshing()
            self?.loadFlag = true
            let code = dataDic["code"]as!NSNumber
            if(code == leeNetworkReturnSuccess){
                let dict = dataDic["page"] as! NSDictionary
                let dataArr : NSArray = dict["list"] as!NSArray
                if(!isLoadMore){
                    self?.dataArr.removeAll()
                }
                for dic in dataArr{
                    let postModel = LeePostModel.deserialize(from: (dic as!Dictionary))
                    self?.dataArr.append(postModel!)
                    JZLLog(message: postModel?.content)
                    self?.tableView.reloadData()
                }
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
            
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            self.refreshCourse?()
            self.tableView.mj_footer.endRefreshing()
        }
    }
}

extension LeeHotPostVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let postModel = dataArr[indexPath.row]
        return postModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: hotPostIdentifier, for: indexPath) as! LeePostCell
        cell.postModel = dataArr[indexPath.row]
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        cell.joinOtherCourse = { [weak self] (userId :String) in
            self?.joinOtherPageAction(userId: userId)
        }
        cell.likeCourse = { [weak self] (dynamicId :String,index : Int) in
            self?.likeAction(dynamicId: dynamicId, index: index)
        }
        cell.shareCourse = { [weak self] (postModel : LeePostModel) in
            self?.shareActionAction(postModel: postModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postModel = dataArr[indexPath.row]
        let _ = postModel.id
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 
        if self.vcCanScroll == false  {
            scrollView.contentOffset = CGPoint.zero
        }
        
        if scrollView.contentOffset.y <= 0 {
            self.vcCanScroll = false
            scrollView.contentOffset = CGPoint.zero
            //往下滑动 bannerView即将出现时发送通知
            NotificationCenter.default.post(name: NSNotification.Name.init("leaveTop"), object: nil)
        }
    }
 
}
