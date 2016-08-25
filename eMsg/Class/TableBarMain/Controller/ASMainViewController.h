//
//  ASMainViewController.h
//  iseeplus
//
//  Created by 黄盼青 on 15/11/30.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

//!  *主控制器  [4个子项->首页,记录仪,相册,我] TabBarController
@interface ASMainViewController : UITabBarController
@property (nonatomic, strong) NSMutableArray *subVCS;

+(instancetype)shared;

/**
 *  隐藏自定义TabBar
 *
 *  @param isHide 是否隐藏
 */
-(void)setTabBarHidden:(BOOL)isHide;

@end
