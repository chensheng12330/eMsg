//
//  YZFileManage.h
//  AblumDemo
//
//  Created by yingzhuo on 16/1/9.
//  Copyright © 2016年 yingzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const YZFileManageFileName;
extern NSString *const YZFileManageFilePath;
extern NSString *const YZFileManageFileIsVideoType;
extern NSString *const YZFileManageFileDuration;
extern NSString *const YZFileManageUrgentFile;
extern NSString *const YZFileManageFileCreateDate;

@interface YZFileManage : NSObject

//
+(NSString *)fetchHomeDirectory;
//!获取缓存目录
+(NSString *)fetchCachesDirectory;

+(NSString *)getCachesDirectory:(NSString *)filename;


//!创建相册保存路径
+(void)createAlumbsPath;
//!获取相册路径
+(NSString *)fetchAlumbsPath;

//!获取图片集路径
+(NSString *)fetchPhotosPath;

//!获取视频集路径
+(NSString *)fetchVideosPath;

//!通过文件名获取相片路径
+(NSString *)fetchPhotoPathWithFileName:(NSString *)filename;

//!通过文件名获取视频路径
+(NSString *)fetchVideoPathWithFileName:(NSString *)filename;

//!获取相册里的所有文件
+(NSArray *)fetchAllFilesInAlumbs;

//!删除文件
+(BOOL)removeFileItemWithPath:(NSString *)filePath;


//!保存相片文件
+(BOOL)savePhotoFileItemWithContent:(NSData *)data fileName:(NSString *)filename;
//保存视频文件  //需要获取从设备上面下载的视频数据
+(BOOL)saveVideoFileItemWithContent:(NSData *)data fileName:(NSString *)filename;
//!文件是否已经存在了
+(BOOL)fileIsExist:(NSString *)filePath;
//!根据文件名判断视频文件是否已经存在了
+(BOOL)videoFileIsExistWithFileName:(NSString *)fileName;
//!获取文件创建日期
+(NSString *)fetchFileCreateDate:(NSString *)filePath;
//!获取单个文件大小
+(long long)getFileSize:(NSString *)filePath;

//!遍历文件夹获得文件夹大小，返回多少M
+(float )folderSizeAtPath:(NSString*) folderPath;

//!获取缓存目录大小
+(NSString *)fetchCachesSize;

//需要获取缓存目录（绝对路径）

//!写入临时文件到缓存目录
+(BOOL)saveTempFileToCache:(NSData *)data;

//!获取网络缓存
+(NSString *)fetchNetworkCache;

//!获取本地相册大小
+(NSString *)fetchAlumbsSize;

//!清除网络缓存
+(void)clearNetworkCache;
//!清除本地相册
+(void)clearAlumbsData;
//!删除文件夹里所有文件
+(void)deleteDirectory:(NSString *)directory;


@end
