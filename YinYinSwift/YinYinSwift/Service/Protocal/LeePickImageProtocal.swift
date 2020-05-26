//
//  LeePickImageProtocal.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/21.
//  Copyright © 2019 ww. All rights reserved.
//

import UIKit

@objc enum LeePickImageType: Int {
    case leeCameraType                 = 0   //相机
    case leePhotosType                 = 1   //图片(多选)
}

@objc protocol LeePickImageProtocal : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func lee_selectdImageWithpickType(pickType:LeePickImageType, maxCount:Int ,allowEdit:Bool)
    @objc optional func lee_pickEditImageAction(image:UIImage)
    @objc optional func lee_pickOriginImageAction(image:UIImage)
    @objc optional func lee_pickPhotos(imagesAction:[UIImage])
    @objc optional func lee_cancleSeletedAction()
}


