//
//  UIImage+Extension.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/25.
//  Copyright © 2019年 ww. All rights reserved.
//

import Foundation
import UIKit


extension UIImage{
// MARK: - 返回一个可拉伸的图片
    static func lee_resizableImageWithName(imageName:String) -> UIImage?{
        let image = UIImage.init(named: imageName)
        let imgW = image!.size.width
        let imgH = image!.size.height
        let edgeInsets = UIEdgeInsets(top: imgH*CGFloat(0.5), left: imgH*CGFloat(0.5), bottom: imgH*CGFloat(0.5), right: imgW*CGFloat(0.5))
        let newImage = image?.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
        return newImage
    }
// MARK: - 获取一个指定颜色指定大小的纯色图片
    static func lee_imageWithColor(color:UIColor,frame:CGRect) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(frame.size, true, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext ()
        return image
    }
// MARK: - 把图片绘制到指定的大小
    static func lee_scaleToSize(image:UIImage,size:CGSize) -> UIImage?{
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: size.width, height: size.height))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaleImage
    }

// MARK: - 根据url获取图片
    static func getImageFromURL(imageUrl:String) -> UIImage?{
 
        let data = NSData(contentsOf: NSURL(string: imageUrl)! as URL)
        let resultImg = UIImage.init(data: data! as Data)
        return resultImg
    }
 
}
