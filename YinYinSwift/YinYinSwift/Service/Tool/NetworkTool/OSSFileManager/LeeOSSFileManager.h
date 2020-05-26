//
//  LeeOSSFileManager.h
//  FirstMet
//
//  Created by 姜自立 on 9/26/18.
//  Copyright © 2018 姜自立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^callBack)(id responseBody);

@interface LeeOSSFileManager : NSObject


/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */
+(instancetype)sharedManager;



/**
 上传头像
 
 @param album 头像
 @param imageName 图片名称
 @param callBack  上传头像地址回调
 */
-(void)requestUploadProfilePhoto:(UIImage *)album :(NSString *)imageName callBack:(callBack)callBack;

/**
 下载图片
 
 @param imageUrl 图片地址
 @param callBack 下载图片回调
 */
-(void)requestDownLoadProfilePhoto:(NSString *)imageUrl callBack:(callBack)callBack;


/**
 上传相册

 @param album 图片
 @param imageName 图片名称
 @param callBack 上传图片回调
 */
-(void)requestUploadAlbum:(UIImage *)album :(NSString *)imageName callBack:(callBack)callBack;

/**
 下载相册图片 

 @param imageUrl 图片地址
 @param callBack 下载图片回调
 */
-(void)requestDownLoadAlbum:(NSString *)imageUrl callBack:(callBack)callBack;

 
 
@end
