//
//  LeeTalkSubVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/21.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class LeeTalkSubVC: LeeBaseVC {

    private let leeTalkIdentifier = "leeTalkIdentifier"
    
    enum LeeTalkStatus : Int {
        case popTalkType = 0
        case latestTalkType
    }
    
    var talkType : LeeTalkStatus?
    private var headerView : LeeTalkHeaderView?
    private var pageSize:NSInteger = 5
    private var pageNo:Int = 0
    private var pageCount:NSInteger = 0
    private var dataArr = [LeeTalkModel]()
    private var recommendArr = [LeeTalkModel]()
    var loadFlag = false //是否加载过
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0.0, y: 0, width: Screen_Width, height: Screen_Height - lee_totalH))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 131
        tableView.lee_registerCell(cell: LeeTalkCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
    }
    
    func initUI(){
        view.addSubview(tableView)
        if(talkType == .popTalkType){
            setHeaderView()
        }
        
        let header = MJRefreshNormalHeader { [weak self] in
            self!.pageNo = 1
            if(self?.talkType == .popTalkType){
                self!.requestRecommend()
                self?.requestPopTalkList(isLoadMore: false)
            }else{
                self?.requestLatestTalkList(isLoadMore: false)
            }
        }
        header?.isAutomaticallyChangeAlpha = true
        tableView.mj_header = header
        let footer = MJRefreshBackNormalFooter  {[weak self] in
            self!.pageNo += 1
            if(self?.talkType == .popTalkType){
                self?.requestPopTalkList(isLoadMore: true)
            }else{
                self?.requestLatestTalkList(isLoadMore: true)
            }
        }
        tableView.mj_footer = footer
    }
    
    func loadAction(){
        if(!self.loadFlag){
            tableView.mj_header.beginRefreshing()
        }else{
            self.loadFlag = true
        }
    }
    
    func setHeaderView(){
        headerView = LeeTalkHeaderView()
        headerView?.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 192)
        tableView.tableHeaderView = headerView
    }
    
    func setRecommendData(recommendData : [LeeTalkModel]){
       headerView?.recommendData = recommendData
    }

}
//MARK: network method
extension LeeTalkSubVC{
    
    func requestRecommend(){
        NetworkTool.talkRecommendListRequest(completionHandler: {[weak self] (dataDic) in
            let code = dataDic["code"]as?NSNumber
            if let c = code{
                if(c == 200){
                    let dataArr: NSArray = dataDic["list"] as!NSArray
                    for dic in dataArr{
                        if let recommendModel = LeeTalkModel.deserialize(from: (dic as! Dictionary)){
                            self?.recommendArr.append(recommendModel)
                        }
                    }
                    self?.setRecommendData(recommendData: self!.recommendArr);
                }
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
    
    func requestPopTalkList(isLoadMore:Bool){
        NetworkTool.talkPopListRequest( pageNo: self.pageNo, pageSize: self.pageSize, completionHandler: { [weak self]  (dataDic) in
            self?.tableView.mj_header.endRefreshing()
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
                    let talkModel = LeeTalkModel.deserialize(from: (dic as!Dictionary))
                    self?.dataArr.append(talkModel!)
                    self?.tableView.reloadData()
                }
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
            
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func requestLatestTalkList(isLoadMore:Bool){
        NetworkTool.talkLatestListRequest( pageNo: self.pageNo, pageSize: self.pageSize, completionHandler: { [weak self]  (dataDic) in
            self?.tableView.mj_header.endRefreshing()
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
                    let talkModel = LeeTalkModel.deserialize(from: (dic as!Dictionary))
                    self?.dataArr.append(talkModel!)
                    self?.tableView.reloadData()
                }
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
            
        }) {[weak self] (error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}
//MARK: tableviewdelegate && datasource
extension LeeTalkSubVC: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.lee_dequeueReusableCell(indexPath: indexPath) as LeeTalkCell
        cell.talkModel = self.dataArr[indexPath.row]
        return cell
    }
}
