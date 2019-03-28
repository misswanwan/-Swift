//
//  NSData+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit

extension NSData{
    // MARK: - 压缩图片(到最小多少M)
    static func lee_compressImage(sourceImage:UIImage,size:CGFloat) -> Data{
        //压缩图片到100K以下
        var data = UIImage.jpegData(sourceImage)(compressionQuality: 1)!
        while data.count/1024 > 100{
            data = UIImage.jpegData(sourceImage)(compressionQuality: 0.15)!;// 压缩比例在0~1之间
        }
        return data;
    }

}

