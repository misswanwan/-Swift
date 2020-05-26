//
//  LeeMineVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import SVProgressHUD

class LeeMineVC: LeeBaseVC {
    private let mineIdentifier = "mineIdentifier"
    
    private var userInfoModel : LeeMineUserModel?
    private var userSubInfoModel : LeeMineUserSubModel?
    private var headerView : LeeAccountHeaderView?
     var settingButton: UIButton!
    private lazy var dataList : [[NSDictionary]] = {
        let dataList = NSArray(contentsOfFile: Bundle.main.path(forResource: "AccountCellList", ofType: "plist")!)
        return dataList! as! [NSArray] as! [[NSDictionary]]
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0.0, y: lee_navTopH, width: Screen_Width, height: Screen_Height - lee_totalH), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        tableView.register(LeeAccountCell.self, forCellReuseIdentifier: mineIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
        requestGroup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false;
    }
 
    //MARK: private
    private func initUI(){
        settingButton = UIButton.lee_initImageButton(frame: CGRect(x: Screen_Width-49, y: lee_statusBarH, width: 44, height: 44), image: UIImage.init(named: "LeeMineSetting")!)
        setHeaderView()
        view.addSubview(settingButton)
        view.addSubview(tableView)
    }
    
    private func setHeaderView(){
        headerView = LeeAccountHeaderView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 285))
        headerView?.profileImageClouse = { [weak self] in
            self?.profileImageAction()
        }
        headerView?.clickClouse = { [weak self] (index : Int) in
           self?.clickAction(index: index)
        }
        headerView?.rechargeClouse = { [weak self] in
            self?.rechangeAction()
        }
        tableView.tableHeaderView = headerView;
    }
    
    //MARK:private
    private func profileImageAction(){
        lee_selectdImageWithpickType(pickType: .leeCameraType, maxCount: 1, allowEdit: true)
    }
    
    private func clickAction(index : NSInteger){
        alertAction(alertTitle: "", alertMsg: "点击下标\(index)")
    }
    
    private func rechangeAction(){
        alertAction(alertTitle: "", alertMsg: "点击充值")
    }
    
    
    //获取可编辑的一张
    override func lee_pickEditImageAction(image:UIImage){
//        headerView?.profileImageView.image = image
        var photoStr = LeeUserManager.shared.userModel.mobile
        
        if(photoStr.count>4){
            photoStr = String(photoStr.suffix(4))
        }
        let imageName = "\(photoStr)\(Lee_Utils.getTimeStamp())"
        
        LeeOSSFileManager.shared()?.requestUploadProfilePhoto(image, imageName, callBack: { (responseBody) in
            let dict = responseBody as! NSDictionary
            if let code = dict["code"] as? NSNumber{
                if(code == leeNetworkReturnSuccess){
                    DispatchQueue.main.async {
                        if let profileUrl:String = dict["imageUrl"] as? String{
                            self.requestSaveProfileImage(profileUrl: profileUrl)
                        }
                    }
                }else{
                    if let msg = dict["msg"] as? String{
                        SVProgressHUD.showError(withStatus: msg)
                    }
                }
            }
        })
    }
}
//MARK: network method
extension LeeMineVC{
    
    private func requestGroup() {
        let group:DispatchGroup = DispatchGroup.init()
//        SVProgressHUD.show()
        requestGetUsetInfo(phone: "13754326412", group: group)
        requestGetUserSubInfo(userId: "f359a4d0921046e0b1abbd3b42e3b40d", group: group)
        group.notify(queue: DispatchQueue.main) {[weak self] in
            self?.headerView?.userModel = self?.userInfoModel
            self?.headerView?.userSubModel = self?.userSubInfoModel
//            SVProgressHUD.dismiss()
        }
    }
    
    private func requestGetUsetInfo(phone:String,group:DispatchGroup) {

        group.enter()
        NetworkTool.mineUserInfoRequest(phone: phone, completionHandler: { (dataDic) in
            let code = dataDic["code"]as!NSNumber
            if(code == leeNetworkReturnSuccess){
                let dict = dataDic["object"] as! NSDictionary
                self.userInfoModel = LeeMineUserModel.deserialize(from: (dict as!Dictionary))
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
            group.leave()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            group.leave()
        }
    }
    
    private func requestGetUserSubInfo(userId:String,group:DispatchGroup){
            group.enter()
        NetworkTool.mineUserSubInfoRequest(anchorId: userId, completionHandler: {[weak self] (dataDic) in
            let code = dataDic["code"]as!NSNumber
            if(code == leeNetworkReturnSuccess){
                let dict = dataDic["object"] as! NSDictionary
                self?.userSubInfoModel = LeeMineUserSubModel.deserialize(from: (dict as!Dictionary))
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
            group.leave()
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            group.leave()
        }
    }
    
    private func requestSaveProfileImage(profileUrl:String){
        NetworkTool.saveUserProfileImageRequest(profileImageUrl: profileUrl, completionHandler: { [weak self] (dataDic) in
            let code = dataDic["code"]as!NSNumber
            if(code == leeNetworkReturnSuccess){
                self?.headerView?.profileImageView.kf.setImage(with: URL(string: profileUrl.addOSSPath()))
                SVProgressHUD.setMinimumDismissTimeInterval(1)
                SVProgressHUD.showSuccess(withStatus: "修改个人头像资料成功")
            }else{
                SVProgressHUD.showError(withStatus: "数据请求出错")
            }
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
}
//MARK: tableview delegate && datasource
extension LeeMineVC : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineIdentifier, for: indexPath) as! LeeAccountCell
        cell.dataDic = dataList[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //去掉section底部间距 要配合下面的方法
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    //隐藏UITableViewStyleGrouped下边多余的间隔 (要配合上面的方法)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    //返回sectionheaderview
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 8))
        return view
    }
    //设置sectionview的高度 (不然上面的方法没有效果)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 8
    }
}

