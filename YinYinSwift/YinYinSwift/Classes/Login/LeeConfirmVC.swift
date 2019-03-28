//
//  LeeConfirmVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeConfirmVC: LeeBaseVC ,LeeStoryboardLoad {
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var codeLoginButotn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.isTranslucent = true;
        initUI()
    }
    
    func initUI(){
        UIView.lee_radius(view: confirmButton, r: 24)
        UIView.lee_getGradient(view: confirmButton, startColor: UIColor.lee_convenient(r: 255, g: 178, b: 50), endColor: UIColor.lee_convenient(r: 255, g: 204, b: 33), startPoint: CGPoint(x: 0, y: 0  ), endPoint: CGPoint(x: 1, y: 1))
        eyeButton.setImage(UIImage.init(named: "Lee_closeEye"), for: .normal)
        eyeButton.setImage(UIImage.init(named: "Lee_openEye"), for: .selected)
        eyeButton.leeCanRepeat = true;
        passwordTextField.addTarget(self, action: #selector(textValueDidChange), for: .editingChanged)
    }
    
    @IBAction func clickEyeAction(_ sender: Any) {
        eyeButton.isSelected = !eyeButton.isSelected
        passwordTextField.isSecureTextEntry = !eyeButton.isSelected
    }
    @IBAction func codeLoginAction(_ sender: Any) {
        let confirmVC = LeeConfirmVC.loadStoryboard()
       navigationController?.pushViewController(confirmVC, animated: true)
    }
    @IBAction func confirmAction(_ sender: Any) {
        validPassword(password:passwordTextField.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LeeConfirmVC{
    @objc func textValueDidChange(){
        if let text = passwordTextField.text{
            passwordTextField.text = String(text.prefix(16))
        }
    }
    
    func validPassword(password:String?){
        guard let _ = password else {
            alertAction(alertTitle: "提示", alertMsg: "请输入密码")
            return
        }
        
        if(password!.count<7){
            alertAction(alertTitle: "提示", alertMsg: "密码不能少于七位")
        }else{
             
        }
    }
}
