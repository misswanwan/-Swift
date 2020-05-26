//
//  LeeLoginVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import SVProgressHUD

class LeeLoginVC: LeeBaseVC,LeeStoryboardLoad {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置navigationbar为空
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.view.backgroundColor = UIColor.white
        initUI()
    }
    
    func initUI(){
        UIView.lee_radius(view: loginButton, r: 23)
        UIView.lee_getGradient(view: loginButton, startColor: UIColor.lee_convenient(r: 255, g: 178, b: 50), endColor: UIColor.lee_convenient(r: 255, g: 204, b: 33), startPoint: CGPoint(x: 0, y: 0  ), endPoint: CGPoint(x: 1, y: 1))
        phoneTextField.keyboardType = .numberPad
        phoneTextField.addTarget(self, action: #selector(textValueDidChange), for: .editingChanged)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false;
    }
}

// MARK: - 事件处理
extension LeeLoginVC{
    
    @objc func textValueDidChange(){
        if let text = phoneTextField.text{
           phoneTextField.text = String(text.prefix(11))
        }
    }
    
    @IBAction func commitAction(_ sender: Any) {
        if String.validPhoneNumber(phoneStr: phoneTextField.text){
            loginButton.isUserInteractionEnabled = false;
            NetworkTool.checkPhoneRequest(mobile: phoneTextField.text ?? "", completionHandler: {[weak self]  (dataDic) in
                self?.loginButton.isUserInteractionEnabled = true;
                let code = dataDic["code"]as!NSNumber
                if code == leeNetworkOvertimeError{
                    UserDefaults.standard.set(self?.phoneTextField!.text, forKey: String.lee_phoneNumberKey())
                    let confirmVC = LeeConfirmVC.loadStoryboard()
                    self!.navigationController?.pushViewController(confirmVC, animated: true)
                }else{
                    SVProgressHUD.showError(withStatus: "手机号码不存在")
                }
            }) {[weak self] (error) in
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                self?.loginButton.isUserInteractionEnabled = true;
            }
        }else{
           SVProgressHUD.showError(withStatus: "手机号码格式不正确")
        }
    }
}



