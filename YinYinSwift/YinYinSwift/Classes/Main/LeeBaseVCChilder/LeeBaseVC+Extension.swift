//
//  LeeBaseVC+Extension.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/21.
//  Copyright © 2019 ww. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

//MARK:tool
extension LeeBaseVC{
    
    func alertAction(alertTitle:String,alertMsg:String){
        self.alertAction(alertTitle: alertTitle, alertMsg: alertMsg, sureTitle: "确定", sureClosure: {})
    }
    
    func alertAction(alertTitle:String,alertMsg:String, sureTitle:String,sureClosure:@escaping(lee_Closure)){
        let alertController = UIAlertController(title: alertTitle, message:alertMsg, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: sureTitle, style: .default) { (_) in
            sureClosure()
        }
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: {})
    }
    
    func alertAction(alertTitle:String,alertMsg:String, sureTitle:String,sureClosure:@escaping(lee_Closure),cancleTitle:String,cancleClosure:@escaping lee_Closure){
        
        let alertController = UIAlertController(title: alertTitle, message:alertMsg, preferredStyle: .alert)
        //
        let sureAction = UIAlertAction(title: sureTitle, style: .default) { (_) in
            sureClosure()
        }
        let cancleAction = UIAlertAction(title: cancleTitle, style: .default) { (_) in
            cancleClosure()
        }
        alertController.addAction(cancleAction)
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: {})
    }
    
    func alertPhotoSheetAction(cameraClosure:@escaping(lee_Closure),photoClosure:@escaping(lee_Closure),cancleClosure:@escaping lee_Closure){
        
        let alertController = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "拍照", style: .default, handler:{ (_) in
            cameraClosure()
        })
        let photoAction = UIAlertAction(title: "从相册中选择", style: .default) { (_) in
            photoClosure()
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            cancleClosure()
        }
        alertController.addAction(cameraAction)
        alertController.addAction(photoAction)
        alertController.addAction(cancleAction)
        self.present(alertController, animated: true, completion: {})
    }
}

//MARK:pickImage
extension LeeBaseVC :LeePickImageProtocal , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func lee_selectdImageWithpickType(pickType:LeePickImageType, maxCount:Int ,allowEdit:Bool){
        switch pickType {
        case .leeCameraType:
            alertPhotoSheetAction(cameraClosure: {[weak self] in
                self?.lee_showCameraAction(allowEdit: allowEdit)
            }, photoClosure: {[weak self] in
                self?.lee_showPhotoAction(allowEdit: allowEdit)
            }) {[weak self] in
                self?.lee_cancleSeletedAction()
            }
            break
        case .leePhotosType:
            lee_showPhotosAction(allowEdit: allowEdit)
            break
        default:
            break
        }
    }
    
    //打开相机
    func lee_showCameraAction(allowEdit:Bool){
        let pickerController = UIImagePickerController.init()
        pickerController.sourceType = .camera
        pickerController.allowsEditing = allowEdit
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthStatus {
        case .authorized:
            pickerController.delegate = self
            self.present(pickerController, animated: true, completion: nil)
            break
        case .restricted:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] (granted) in
                if(granted){
                    pickerController.delegate = self
                    self?.present(pickerController, animated: true, completion: nil)
                }
            }
            break
        case .denied:
            alertAction(alertTitle: "提示", alertMsg: "请在iPhone的\"设置-隐私-相机\"中允许\"YinYinSwift\"访问您的相机", sureTitle: "确定", sureClosure: {
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else {return}
                guard UIApplication.shared.canOpenURL(url) else {return}
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:]) { (res) in
                    }
                } else {
                    UIApplication.shared.openURL(url)
                }
            }, cancleTitle: "取消") {
            }
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] (granted) in
                if(granted){
                    pickerController.delegate = self
                    self?.present(pickerController, animated: true, completion: nil)
                }
            }
            break
        default:
            break
        }
    }
    //选相册单张
    func lee_showPhotoAction(allowEdit:Bool){
        let pickerController = UIImagePickerController.init()
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = allowEdit
        let photoAuthStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthStatus {
        case .authorized:
            pickerController.delegate = self
            self.present(pickerController, animated: true, completion: nil)
            break
        case .restricted:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] (granted) in
                if(granted){
                    pickerController.delegate = self
                    self?.present(pickerController, animated: true, completion: nil)
                }
            }
            break
        case .denied:
            alertAction(alertTitle: "提示", alertMsg: "请在iPhone的\"设置-隐私-相机\"中允许\"YinYinSwift\"访问您的照片", sureTitle: "确定", sureClosure: {
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else {return}
                guard UIApplication.shared.canOpenURL(url) else {return}
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:]) { (res) in
                    }
                } else {
                    UIApplication.shared.openURL(url)
                }
            }, cancleTitle: "取消") {
            }
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] (granted) in
                if(granted){
                    pickerController.delegate = self
                    self?.present(pickerController, animated: true, completion: nil)
                }
            }
            break
        default:
            break
        }
    }
    //选相册多张
    func lee_showPhotosAction(allowEdit:Bool){
        let pickerController = UIImagePickerController.init()
        pickerController.sourceType = .photoLibrary
        let photoAuthStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthStatus {
        case .authorized:
            //do action
            break
        case .restricted:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if(granted){
                    //do action
                }
            }
            break
        case .denied:
            alertAction(alertTitle: "提示", alertMsg: "请在iPhone的\"设置-隐私-相机\"中允许\"YinYinSwift\"访问您的照片", sureTitle: "确定", sureClosure: {
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else {return}
                guard UIApplication.shared.canOpenURL(url) else {return}
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:]) { (res) in
                    }
                } else {
                    UIApplication.shared.openURL(url)
                }
            }, cancleTitle: "取消") {
            }
            break
        default:
            break
        }
    }
    
    //获取原图一张
    func lee_pickOriginImageAction(image: UIImage) {
        
    }
    //获取可编辑的一张
    func lee_pickEditImageAction(image:UIImage){
        
    }
    //获取多张
    func lee_pickPhotos(images:[UIImage]){
        
    }
    //取消
    func lee_cancleSeletedAction(){
        
    }
    
    //MARK:  pick delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            lee_pickEditImageAction(image: editImage)
        }
        if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            lee_pickOriginImageAction(image: originImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        lee_cancleSeletedAction()
    }
}
