//
//  UIImageView+Category.h
//  AblumDemo
//
//  Created by yingzhuo on 16/1/9.
//  Copyright © 2016年 yingzhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImageView (Category)

-(void)cancelAllThumbnailGeneration;

-(void)yz_setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder;

-(void)yz_setImageWithVideoUrl:(NSURL *)url placehodlerImage:(UIImage *)placeholder;

+(UIImage *)fetchVideoThumbnailWithTime:(CMTime)time filePath:(NSString *)filePath settingThumb:(BOOL)isSetting;

@end
