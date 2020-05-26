//
//  LeePhoneCodeVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit
import SVProgressHUD
class LeePhoneCodeVC: LeeBaseVC ,LeeStoryboardLoad{

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var sendCodeLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.isTranslucent = true;
        initUI()
        responderInit()
    }
    
    
    func initUI(){
        UIView.lee_radius(view: confirmButton, r: 24)
        UIView.lee_getGradient(view: confirmButton, startColor: UIColor.lee_convenient(r: 255, g: 178, b: 50), endColor: UIColor.lee_convenient(r: 255, g: 204, b: 33), startPoint: CGPoint(x: 0, y: 0  ), endPoint: CGPoint(x: 1, y: 1))
        
        let phoneNumber =  UserDefaults.standard.value(forKey: String.lee_phoneNumberKey())as! String
        sendCodeLabel.text = "已发送验证码至"+phoneNumber
        confirmButton.isEnabled = false
        countDownButton.setTitle("重新发送验证码", for: .selected)
        countDownButton.setTitleColor(UIColor.lee_convenient(r: 255, g: 195, b: 1), for: .selected)
        countDownButton.backgroundColor = .white
        UIView.lee_radius(view: textField1, r: 6)
        UIView.lee_radius(view: textField2, r: 6)
        UIView.lee_radius(view: textField3, r: 6)
        UIView.lee_radius(view: textField4, r: 6)
        sendCodeAction(countDownButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func commitAction(_ sender: Any) {
        let phoneNumber =  UserDefaults.standard.value(forKey: String.lee_phoneNumberKey())as! String
        var codeStr : String = ""
        if(String.vaildStr(validStr: textField1.text)&&String.vaildStr(validStr: textField2.text)&&String.vaildStr(validStr: textField3.text)&&String.vaildStr(validStr: textField4.text)){
            codeStr = textField1.text!+textField2.text!+textField3.text!+textField4.text!
        }
        NetworkTool.loginWithCode(mobile: phoneNumber, code: codeStr, completionHandler: {[weak self] (dataDic) in
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
                SVProgressHUD.showError(withStatus: "验证码错误")
            }
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
    
    @IBAction func sendCodeAction(_ sender: Any) {
        let phoneNumber =  UserDefaults.standard.value(forKey: String.lee_phoneNumberKey())as! String
        NetworkTool.sendCodeRequest(mobile: phoneNumber, completionHandler: { [weak self] (dataDic) in
            self!.sendCode()
            SVProgressHUD.showSuccess(withStatus: "手机验证码发送成功")
        }) {(error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
}

extension LeePhoneCodeVC : UITextFieldDelegate{
    func responderInit(){
        textField1.becomeFirstResponder()
        textField1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField:UITextField){
        if(textField.text?.count == 1){
            if(textField == textField1){
                textField2.becomeFirstResponder()
            }else if(textField == textField2){
                textField3.becomeFirstResponder()
            }else if(textField == textField3){
                textField4.becomeFirstResponder()
            }else if(textField == textField4){
                view.endEditing(true)
            }
        }
        validateCodeTextField()
    }
    
    func validateCodeTextField(){
        if(String.vaildStr(validStr: textField1.text)&&String.vaildStr(validStr: textField2.text)&&String.vaildStr(validStr: textField3.text)&&String.vaildStr(validStr: textField4.text)){
            confirmButton.isEnabled = true
        }else{
            confirmButton.isEnabled = false
        }
    }
    
    func sendCodeButtonActivity(){
        countDownButton.isEnabled = false
        countDownButton.isSelected = false
    }
    
    func sendCodeButtonUnActivity(second:Int){
        countDownButton.isEnabled = false
        countDownButton.isSelected = true
        let countDownStr = "(\(second))秒后重新获取验证码"
        countDownButton.setTitle(countDownStr, for: .normal)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(String.vaildStr(validStr: string)){
            if String.vaildStr(validStr: textField.text){
                return false
            }
        }else{
            textField1.text = ""
            textField2.text = ""
            textField3.text = ""
            textField4.text = ""
            textField1.becomeFirstResponder()
        }
         return true
    }
    
    func sendCode(){
        self.countDownButton.isSelected = false
        var time = 10
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
        codeTimer.setEventHandler {
            time = time - 1
            DispatchQueue.main.async {
                self.countDownButton.isEnabled = false
            }
            if time < 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.countDownButton.isEnabled = true
                    self.countDownButton.isSelected = true
                }
                return
            }
            DispatchQueue.main.async {
                self.sendCodeButtonUnActivity(second: time)
            }
        }
        codeTimer.activate()
    }
    
}
