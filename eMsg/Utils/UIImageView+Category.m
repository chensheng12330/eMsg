//
//  UIImageView+Category.m
//  AblumDemo
//
//  Created by yingzhuo on 16/1/9.
//  Copyright © 2016年 yingzhuo. All rights reserved.
//   UPDATA WITH Sherwin.Chen : 多线程运行时判断

#import "UIImageView+Category.h"
#import "YZFileManage.h"
#import "SLYDefine.h"

@implementation UIImageView (Category)

-(void)cancelAllThumbnailGeneration
{
    
}

-(void)yz_setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    if (!placeholder) {
        self.backgroundColor = [UIColor blackColor];
    }else
    {
        self.image = placeholder;
    }
    if (!url) {
        return;
    }
    __block UIImage *thumbImage = nil;
    //先判断图片是否有缓存
    NSString *fileName = [NSString stringWithFormat:@"%lu",(unsigned long)[url hash]];
    NSString *filePath =[self getCachesDirectory:fileName];
    
    if ([NSData dataWithContentsOfFile:filePath]) {
        self.image =[UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    }else
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            generator.appliesPreferredTrackTransform=TRUE;
            CGFloat width = ([UIScreen mainScreen].bounds.size.width - 8*3)/4;
            generator.maximumSize = CGSizeMake(width, width);
            CMTime thumbTime = CMTimeMakeWithSeconds(0.0,600);
            
            AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
            {
                if (result == AVAssetImageGeneratorFailed)
                {
                    NSLog(@"couldn't generate thumbnail, error:%@", error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = placeholder;
                        dispatch_semaphore_signal(semaphore);
                    });
                }
                else if (result==AVAssetImageGeneratorSucceeded)
                {
                    if (im) {
                        thumbImage=[UIImage imageWithCGImage:im];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.image = thumbImage;
                     
                            //将获取到的缩略图缓存
                            NSData *data = UIImageJPEGRepresentation(thumbImage, 0.5);
                            [data writeToFile:filePath atomically:YES];
                            dispatch_semaphore_signal(semaphore);
                            
                        });
                        
                    }else
                    {
                        if (!placeholder) {
                            self.backgroundColor = [UIColor lightGrayColor];
                        }else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.image = placeholder;
                                [self setNeedsLayout];
                                dispatch_semaphore_signal(semaphore);
                            });
                            
                        }
                        
                    }
                    
                    
                    //将获取到的缩略图缓存
                    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    // });
                }
            };
            
            [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
        });
        
        
    }
}

static dispatch_once_t onceToken ;
static dispatch_semaphore_t semaphore ;
static dispatch_queue_t receiverQueue;//专门控制并发等待的线程
static NSMutableDictionary *mURLQueue; //url Req Dict;

-(void)yz_setImageWithVideoUrl:(NSURL *)url placehodlerImage:(UIImage *)placeholder
{
   // NSLog(@"记录仪上视频URL：%@",url);
    if (!placeholder) {
        
        self.backgroundColor = [UIColor blackColor];
    }else
    {
        self.image = placeholder;
    }
    if (!url) {
        return;
    }
    //0x1 先判断图片是否有缓存
    NSString *fileName = [NSString stringWithFormat:@"%lu",(unsigned long)[url hash]];
    NSString *filePath =[self getCachesDirectory:fileName];
    
    if ([NSData dataWithContentsOfFile:filePath]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *cacheImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = cacheImage;
            });
        });
        return;
    }
    
    //0x2 请求网络，加载图片
    
    //0x2.1  判断当前请求的图片是否已经在请求队列里面.
    if (mURLQueue[url.absoluteString]) {
        //如果已经在，直接返回.
        //TMBLogDebug(@"??????? 已存在线程，返回.....");
        return;
    }
    else{
        //如果不存在，请求创建新的线程
        @synchronized(mURLQueue)
        {
            [mURLQueue setObject:@(1) forKey:url.absoluteString];
        }
    }
    
    //0x2.2  队列初使化
    dispatch_once(&onceToken, ^{
        semaphore     = dispatch_semaphore_create(1);
        receiverQueue = dispatch_queue_create("receiver", DISPATCH_QUEUE_SERIAL);
        mURLQueue     = [[NSMutableDictionary alloc] init];
    });
    

    //0x3  开始请求
    dispatch_async(receiverQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generator.appliesPreferredTrackTransform=TRUE;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 8*3)/4;
        generator.maximumSize = CGSizeMake(width, width);
        CMTime thumbTime = CMTimeMakeWithSeconds(0.0,600);
        
        
        NSError *error      = nil;
        UIImage *thumbImage = nil;
        NSData  *thumbData  = nil;
        
        CGImageRef im =[generator copyCGImageAtTime:thumbTime actualTime:NULL error:&error];
        
        if (im) {
            thumbImage = [UIImage imageWithCGImage:im];
            thumbData  = UIImageJPEGRepresentation(thumbImage, 0.5);
            
            [thumbData writeToFile:filePath atomically:YES];
        }
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            @synchronized(mURLQueue)
            {
                [mURLQueue removeObjectForKey:url.absoluteString];
            }
            
            //返回错误处理
            if (error) {
                
               // TMBLogError(@"%@",error);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = placeholder;
                    [self setNeedsLayout];
                    dispatch_semaphore_signal(semaphore);
                    
                    
                });
                return ;
            }
            
            //设置加载的图片
            if (thumbImage) {
                
                self.image = thumbImage;
                [self setNeedsLayout];
                
                dispatch_semaphore_signal(semaphore);
                
            }
            else if(!placeholder)
            {
                self.backgroundColor = [UIColor lightGrayColor];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = placeholder;
                    
                    [self setNeedsLayout];
                    dispatch_semaphore_signal(semaphore);
                });
            }

        });
    });
    return;
}

-(NSString *)getCachesDirectory:(NSString *)filename
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


+(UIImage *)fetchVideoThumbnailWithTime:(CMTime)time filePath:(NSString *)filePath settingThumb:(BOOL)isSetting
{
    __block UIImage *thumbImage = nil;
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    //CMTime thumbTime = CMTimeMakeWithSeconds(seconds,600);
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
    {
        if (result == AVAssetImageGeneratorFailed)
        {
            NSLog(@"couldn't generate thumbnail, error:%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置封面失败
                [[NSNotificationCenter defaultCenter] postNotificationName:YZ_SETTHUMBNAIL_STATUS object:nil];
            });
            
        }
        if (result==AVAssetImageGeneratorSucceeded)
        {
            if (im) {
                thumbImage=[UIImage imageWithCGImage:im];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
                
            }else
            {
                
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                NSData *data = UIImageJPEGRepresentation(thumbImage, 0.5);
                //                //NSString *saveFileName = @"thumbnail";
                //                BOOL isSaved = [YZFileManage savePhotoFileItemWithContent:data fileName:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //通知相册主界面相册内容有更改
                    [[NSNotificationCenter defaultCenter] postNotificationName:YZ_ABLUMS_ABLUMSCONTENTCHANGED object:@{YZ_THUMBNAIL:thumbImage,YZ_IS_SETTING_THUMBNAIL:@(isSetting)}];
                    //设置封面成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:YZ_SETTHUMBNAIL_STATUS object:@{YZ_THUMBNAIL:thumbImage,YZ_IS_SETTING_THUMBNAIL:@(isSetting)}];
                });
                
                
            });
        }
    };
    
    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:time]] completionHandler:handler];
    return nil;
}

@end
