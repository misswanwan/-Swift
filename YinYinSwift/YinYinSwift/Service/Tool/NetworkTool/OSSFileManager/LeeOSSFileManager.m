//
//  LeeOSSFileManager.m
//  FirstMet
//
//  Created by 姜自立 on 9/26/18.
//  Copyright © 2018 姜自立. All rights reserved.
//

#import "LeeOSSFileManager.h"
#import "YinYinSwift-Swift.h"


#import <AliyunOSSiOS/OSSService.h>
NSString * const AccessKey = @"LTAIHNVm4MGhOcP5";
NSString * const SecretKey = @"oTG6tLXmyeDZzMUbAtOEayppXs0Eaz";
NSString * const OSSBucketName = @"faint-app";
NSString * const OSSAlbumKey = @"album/";//相册
NSString * const OSSChat_voiceKey = @"chat_voice/";//实时聊天语音
NSString * const OSSHeadKey = @"head/";//头像
NSString * const OSSVoiceKey = @"voice/";//播放语音
NSString * const OSSEndpoint = @"https://oss-cn-hangzhou.aliyuncs.com";//外网访问 OSS地址
NSString * const OSSSecurityToken = @"LTAIHNVm4MGhOcP5";//SecurityToken

@interface LeeOSSFileManager()
{
 
}
@property (nonatomic,strong) OSSClient * client;
@property (nonatomic,strong) OSSPutObjectRequest * putRequest;
@property (nonatomic,strong) OSSGetObjectRequest * getRequest;

@property (nonatomic ,copy)NSString *recordPathSuffix;//语音本地地址后缀后缀

@end

@implementation LeeOSSFileManager

/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */
+(instancetype)sharedManager {
    static LeeOSSFileManager *instance;
     
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LeeOSSFileManager alloc] init];
    });
    
    return instance;
}


/**
 上传头像
 
 @param album 头像
 @param imageName 图片名称
 @param callBack  上传头像地址回调
 */
-(void)requestUploadProfilePhoto:(UIImage *)album :(NSString *)imageName callBack:(callBack)callBack{
    id credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    //    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:AccessKey secretKeyId:SecretKey securityToken:OSSSecurityToken];
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:OSSEndpoint credentialProvider:credential];
    OSSPutObjectRequest* put = [OSSPutObjectRequest new];
    put.bucketName = OSSBucketName;//文件目录
    put.objectKey = [NSString stringWithFormat:@"%@%@",OSSHeadKey,imageName];//文件名
    NSData *albumData= [NSData lee_compressImageWithSourceImage:album size:1];
    put.uploadingData = albumData;//自己的NSData数据
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        //        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task){
        task = [client presignPublicURLWithBucketName:OSSBucketName
                                        withObjectKey:OSSHeadKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            if (!task.error) {
                [dic setValue:@200 forKey:@"code"];
                [dic setValue:@"头像上传成功" forKey:@"msg"];
                [dic setValue:[NSString stringWithFormat:@"%@%@",OSSHeadKey,imageName] forKey:@"imageUrl"];
               
                callBack(dic);
            } else {
                [dic setValue:@300 forKey:@"code"];
                [dic setValue:@"头像上传失败" forKey:@"msg"];
                callBack(dic);
            }
        });
        return nil;
    }];
}
/**
 下载图片
 
 @param imageUrl 图片地址
 @param callBack 下载图片回调
 */
-(void)requestDownLoadProfilePhoto:(NSString *)imageUrl callBack:(callBack)callBack{
   
    id credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    //    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:AccessKey secretKeyId:SecretKey securityToken:OSSSecurityToken];
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:OSSEndpoint credentialProvider:credential];
    
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = OSSBucketName;
    
    NSArray *array = [imageUrl componentsSeparatedByString:OSSHeadKey]; //字符串按照OSSBucketName分隔成数组
    request.objectKey = imageUrl;//array.lastObject;//
    NSString *downloadFilePath = [[NSString oss_documentDirectory] stringByAppendingPathComponent:array.lastObject];
//    request.downloadToFileURL = [NSURL fileURLWithPath:downloadFilePath];//[NSURL URLWithString:downloadFilePath];
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
//                NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    NSMutableData *totalData = [[NSMutableData alloc] init];
    __block NSMutableData *blockTotalData = totalData;
    // 分段回调函数
    request.onRecieveData = ^(NSData * data) {
         [blockTotalData appendData:data];
//        NSLog(@"-----------------------Recieve data, length: %ld", [data length]);
    };

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    OSSTask * getTask = [client getObject:request];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    OSSTask * task = [client getObject:request];
    [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
            task = [client presignPublicURLWithBucketName:OSSBucketName withObjectKey:OSSHeadKey];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (task.error) {
                    //failure(task.error);
                    [dic setValue:@300 forKey:@"code"];
                    [dic setValue:@"头像下载失败" forKey:@"msg"];
                    callBack(dic);
                } else {
                    //success(downloadFilePath);
                    [dic setValue:@200 forKey:@"code"];
                    [dic setValue:@"头像下载成功" forKey:@"msg"];
                    [dic setValue:downloadFilePath forKey:@"imagePath"];
                    [dic setValue:totalData forKey:@"imageData"];
                    callBack(dic);
                }
            });
            return nil;
        }];
    });
}

 
/**
 上传相册
 
 @param album 图片
 @param imageName 图片名称
 @param callBack 上传图片回调
 */
-(void)requestUploadAlbum:(UIImage *)album :(NSString *)imageName callBack:(callBack)callBack{
    id credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    //    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:AccessKey secretKeyId:SecretKey securityToken:OSSSecurityToken];
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:OSSEndpoint credentialProvider:credential];
    OSSPutObjectRequest* put = [OSSPutObjectRequest new];
    put.bucketName = OSSBucketName;//文件目录
    put.objectKey = [NSString stringWithFormat:@"%@%@",OSSAlbumKey,imageName];//文件名
    NSData *albumData = [NSData lee_compressImageWithSourceImage:album size:1];
    put.uploadingData = albumData;//自己的NSData数据
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        //        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task){
        task = [client presignPublicURLWithBucketName:OSSBucketName
                                        withObjectKey:OSSAlbumKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            if (!task.error) {
                [dic setValue:@200 forKey:@"code"];
                [dic setValue:@"头像上传成功" forKey:@"msg"];
                [dic setValue:[NSString stringWithFormat:@"%@%@",OSSAlbumKey,imageName] forKey:@"imageUrl"];
                callBack(dic);
            } else {
                [dic setValue:@300 forKey:@"code"];
                [dic setValue:@"头像上传失败" forKey:@"msg"];
                callBack(dic);
            }
        });
        return nil;
    }];
}

/**
 下载图片
 
 @param imageUrl 图片地址
 @param callBack 下载图片回调
 */
-(void)requestDownLoadAlbum:(NSString *)imageUrl callBack:(callBack)callBack{
    //图片权限开放的情况下 不需要这个功能 直接下载使用就好
}
 

@end


