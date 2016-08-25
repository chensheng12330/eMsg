//
//  AppDelegate.h
//  xcar
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASMainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIViewController *rootViewController;

@property (nonatomic ,strong) ASMainViewController *mainController;

/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;

@end

