//
//  YZFileManage.m
//  AblumDemo
//
//  Created by yingzhuo on 16/1/9.
//  Copyright © 2016年 yingzhuo. All rights reserved.
//

#import "YZFileManage.h"
#import <AVFoundation/AVFoundation.h>
#import "NSDate+TMBFoundation.h"


NSString *const YZFileManageFileName = @"filename";
NSString *const YZFileManageFilePath = @"filePath";
NSString *const YZFileManageFileIsVideoType = @"fileType";
NSString *const YZFileManageFileDuration = @"videoDuration";
NSString *const YZFileManageUrgentFile = @"isUrgent";
NSString *const YZFileManageFileCreateDate = @"fileCreateDate";

@implementation YZFileManage

+(NSString *)fetchHomeDirectory
{
    NSLog(@"====homePath = %@",NSHomeDirectory());
    return NSHomeDirectory();
}

//!获取缓存目录
+(NSString *)fetchCachesDirectory
{
     NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return caches;
}

+(NSString *)getCachesDirectory:(NSString *)filename
{
    //在caches目录下创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
   // NSLog(@"cachePath = %@",caches);
    NSString *cachesPath = [caches stringByAppendingPathComponent:@"videoThumbnail"];
    if (![fileManager fileExistsAtPath:cachesPath]) {
        [fileManager createDirectoryAtPath:cachesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [cachesPath stringByAppendingPathComponent:filename];
}

+(void)createAlumbsPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *documentPath = [[[self class] fetchHomeDirectory] stringByAppendingPathComponent:@"Documents"];
    NSString *alumbPath = [documentPath stringByAppendingPathComponent:@"Alumbs"];
    if (![fileManager fileExistsAtPath:alumbPath]) {
        [fileManager createDirectoryAtPath:alumbPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *photosPath = [alumbPath stringByAppendingPathComponent:@"Photos"];
    if (![fileManager fileExistsAtPath:photosPath]) {
        [fileManager createDirectoryAtPath:photosPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *videosPath = [alumbPath stringByAppendingPathComponent:@"Videos"];
    if (![fileManager fileExistsAtPath:videosPath]) {
        [fileManager createDirectoryAtPath:videosPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
}

+(NSString *)fetchAlumbsPath
{
   // NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *documentPath = [[[self class] fetchHomeDirectory] stringByAppendingPathComponent:@"Documents"];
    NSString *alumbPath = [documentPath stringByAppendingPathComponent:@"Alumbs"];
    return alumbPath;
}

//!获取图片集路径
+(NSString *)fetchPhotosPath
{
    NSString *alumbsPath = [[self class] fetchAlumbsPath];
    return [alumbsPath stringByAppendingPathComponent:@"Photos"];
   
}

//!获取视频集路径
+(NSString *)fetchVideosPath
{
    NSString *alumbsPath = [[self class] fetchAlumbsPath];
    return [alumbsPath stringByAppendingPathComponent:@"Videos"];
}
////!通过文件名获取相片路径
+(NSString *)fetchPhotoPathWithFileName:(NSString *)filename
{
   // NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *photosPath = [[self class] fetchPhotosPath];
    return [photosPath stringByAppendingPathComponent:filename];
}

//!通过文件名获取视频路径
+(NSString *)fetchVideoPathWithFileName:(NSString *)filename
{
    NSString *photosPath = [[self class] fetchVideosPath];
    return [photosPath stringByAppendingPathComponent:filename];
}

//获取沙盒Alumbs里的文件
+(NSArray *)fetchAllFilesInAlumbs
{
    NSMutableArray * fileArr = [NSMutableArray array];
    //获取document路径
    NSString *alumbPath = [self fetchAlumbsPath];
    NSLog(@"%@",alumbPath);
    
    NSFileManager* fileManage = [NSFileManager defaultManager];
    //获取目录列表里所有文件名
    NSArray *fileList = [fileManage subpathsOfDirectoryAtPath:alumbPath error:nil];
    NSLog(@"%@",fileList);
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString *afile in fileList) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *path = [alumbPath stringByAppendingPathComponent:afile];
        [fileManage fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:afile];
            
        }
        else
        {
            if (![afile hasSuffix:@".DS_Store"]) {
            
                if ([afile rangeOfString:@"/"].location != NSNotFound) {
                    
                    NSString *fileName = [[afile componentsSeparatedByString:@"/"] lastObject];
                    [dic setObject:fileName forKey:YZFileManageFileName];
                    NSString *pathExtensionString = @"mp4/MP4/m4v/M4V/mov/MOV";
                    if ([pathExtensionString rangeOfString:[afile pathExtension]].location != NSNotFound) {
                        [dic setObject:[NSNumber numberWithBool:YES] forKey:YZFileManageFileIsVideoType];
                        //获取视频总时长
                        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:path] options:nil];
                        NSInteger second = urlAsset.duration.value / urlAsset.duration.timescale;
                        [dic setObject:[NSNumber numberWithInteger:second] forKey:YZFileManageFileDuration];
                    }else
                    {
                        [dic setObject:[NSNumber numberWithBool:NO] forKey:YZFileManageFileIsVideoType];
                    }
                }
                else
                {
                    [dic setObject:afile forKey:YZFileManageFileName];
                }
                [dic setObject:path forKey:YZFileManageFilePath];
                NSString *fileCreateDate = [[self class] fetchFileCreateDate:path];
                [dic setObject:fileCreateDate forKey:YZFileManageFileCreateDate];
               // NSLog(@"%@",path);
                [fileArr addObject:dic];
            }
            
        }
        isDir = NO;
    }
    return fileArr;
    
}

//!删除文件
+(BOOL)removeFileItemWithPath:(NSString *)filePath
{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

//!保存图片文件
+(BOOL)savePhotoFileItemWithContent:(NSData *)data fileName:(NSString *)filename
{
    if (data == nil) {
        return NO;
    }
    if (filename == nil) {
        filename = [NSString stringWithFormat:@"%@.png",[[self class] formattedCurrentTime]];
        //filename = @"defaultName.png";
    }

    NSString *path = [[self class] fetchPhotosPath];
    NSString *filePath = [path stringByAppendingPathComponent:filename];
    if ([[self class] fileIsExist:filePath]) {
        //生成新的路径
        filePath = [[self class] p_generateNewFilePath:filePath];
    }
    [data writeToFile:filePath atomically:YES];
    return YES;
}

//保存视频文件
+(BOOL)saveVideoFileItemWithContent:(NSData *)data fileName:(NSString *)filename
{
    if (data == nil) {
        return NO;
    }
    if (filename == nil) {
        filename = [NSString stringWithFormat:@"%@.mp4",[[self class] formattedCurrentTime]];
        //filename = @"defaultName.mp4";
    }
    NSString *path = [[self class] fetchVideosPath];
    NSString *filePath = [path stringByAppendingPathComponent:filename];
    if ([[self class] fileIsExist:filePath]) {
        //生成新的路径
        filePath = [[self class] p_generateNewFilePath:filePath];
    }
    [data writeToFile:filePath atomically:YES];
    return YES;
}
//!文件是否已经存在了
+(BOOL)fileIsExist:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

//!根据文件名判断视频文件是否已经存在了
+(BOOL)videoFileIsExistWithFileName:(NSString *)fileName
{
    NSString *filePath = [[self class] fetchVideoPathWithFileName:fileName];
    
    return [[self class] fileIsExist:filePath];
}

//!生成新的文件路径
+(NSString *)p_generateNewFilePath:(NSString *)oldFilePath
{
    NSString *newFilePath;
    if ([[self class] fileIsExist:oldFilePath]) {
      // NSString *newFilename = [[self class] p_generateNewFileName:oldFilePath];
        NSString *newFilename = [NSString stringWithFormat:@"%@",[[self class] formattedCurrentTime]];
        NSArray *components = [oldFilePath componentsSeparatedByString:@"/"];
        NSString *path ;
        if ([components[components.count - 2] isEqualToString:@"Photos"]) {
            path = [[self class] fetchPhotosPath];
            newFilename = [NSString stringWithFormat:@"%@.png",newFilename];
        }else
        {
            path = [[self class] fetchAlumbsPath];
             newFilename = [NSString stringWithFormat:@"%@.mp4",newFilename];
        }
        newFilePath = [NSString stringWithFormat:@"%@/%@",path,newFilename];
    }
    return newFilePath;
}

+(NSString *)formattedCurrentTime
{
    NSDateFormatter *formatter = [[self class] dateFormatterWithFormat:@"yyyyMMddHHmmss"];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}
+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+(NSString *)p_generateNewFileName:(NSString *)filePath
{
    NSString *newFilename ;
    NSMutableArray *samePrefixArray = [NSMutableArray array];
    NSArray *fileList = [[self class] p_fetchAllFileNameInAblums];
    for (NSString *filename in fileList) {
        NSString *oldFileName = [filePath lastPathComponent];
        NSString *name = [filename lastPathComponent];
        if ([name hasPrefix:oldFileName]) {
            [samePrefixArray addObject:filename];
        }
    }
    NSInteger index = samePrefixArray.count;
    NSString *originalName = [[samePrefixArray firstObject] lastPathComponent];
    newFilename = [NSString stringWithFormat:@"%@%ld.png",originalName,(long)index];
    return newFilename;
}

+(NSArray *)p_fetchAllFileNameInAblums
{
    NSString *photosPath = [[self class] fetchPhotosPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager subpathsOfDirectoryAtPath:photosPath error:nil];
    return fileList;

}

//!获取文件创建日期
+(NSString *)fetchFileCreateDate:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
    NSDate *createDate = attributes[NSFileModificationDate];
    NSString *dateString = [NSDate formattedDate:createDate];
    return dateString;
}
//!获取单个文件大小
+(long long)getFileSize:(NSString *)filePath
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManage attributesOfItemAtPath:filePath error:nil];
    NSNumber *fileSize = [fileAttributes objectForKey:NSFileSize];
    long long fileValue = [fileSize longLongValue];
    return fileValue;
}

//!遍历文件夹获得文件夹大小，返回多少b
+(float )folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [[self class] getFileSize:fileAbsolutePath];
    }
    return folderSize;
}

//!获取缓存目录大小
+(NSString *)fetchCachesSize
{
    float totalSize = [[self class] folderSizeAtPath:[[self class] fetchCachesDirectory]];
    return [[self class] fileSizeWithTotalSize:totalSize];
}

//!写入临时文件到缓存目录
+(BOOL)saveTempFileToCache:(NSData *)data
{
    NSString *filePath = [[[self class] fetchCachesDirectory] stringByAppendingPathComponent:@"tempThumbnail.jpg"];
    BOOL success = [data writeToFile:filePath atomically:YES];
    return success;
}

//!获取网络缓存
+(NSString *)fetchNetworkCache
{
    //图片缓存
    NSUInteger totalSize ;//= [[SDImageCache sharedImageCache] getSize];
    //http 缓存
    totalSize += [[NSURLCache sharedURLCache] currentMemoryUsage];
    
    //视频缩略图 缓存
    totalSize += [[self class] folderSizeAtPath:[[[self class] fetchCachesDirectory] stringByAppendingPathComponent:@"videoThumbnail" ]];
    
    return [[self class] fileSizeWithTotalSize:totalSize] ;
}

//!获取本地相册大小
+(NSString *)fetchAlumbsSize
{
    float totalSize = [[self class] folderSizeAtPath:[[self class] fetchAlumbsPath]];
    return [[self class] fileSizeWithTotalSize:totalSize];
}
//计算出大小
+(NSString *)fileSizeWithTotalSize:(float)size{
    // 1K = 1024, 1M = 1024k
    if (size < 1024) {// 小于1K
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1M
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fKB",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.2fMB",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.2fGB",aFloat];
    }
}

//!清除网络缓存
+(void)clearNetworkCache
{
    //[[SDImageCache sharedImageCache] clearMemory];
    //[[SDImageCache sharedImageCache] clearDisk];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self class] deleteDirectory:[[[self class] fetchCachesDirectory] stringByAppendingPathComponent:@"videoThumbnail" ]];
}
//!删除文件夹里所有文件
+(void)deleteDirectory:(NSString *)directory
{
    NSArray *filePaths = [[self class] fetchFilePathsOfDirectory:directory];
    for (NSString *filePath in filePaths) {
        [[self class] removeFileItemWithPath:filePath];
    }
}
+(NSArray *)fetchFilePathsOfDirectory:(NSString *)directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *allFiles = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    NSMutableArray *filePaths = [NSMutableArray array];
    for (NSString *fileName in allFiles) {
        [filePaths addObject:[directory stringByAppendingPathComponent:fileName]];
    }
    return filePaths.count >0 ? filePaths : nil;
}
//!清除本地相册
+(void)clearAlumbsData
{
    [[self class] deleteDirectory:[[self class] fetchAlumbsPath]];
}

@end
