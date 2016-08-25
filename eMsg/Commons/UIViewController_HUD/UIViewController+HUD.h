/************************************************************
 *  * 深蓝蕴 CONFIDENTIAL
 * __________________
 * Copyright (C) 2015 深蓝蕴 Technologies. All rights reserved.
 *
 * NOTICE: All information included here,to protect technology propert
 * of 深蓝蕴,all reproduction and dissemination of this material without
 * permission is strictly forbidden.
 */

#import <UIKit/UIKit.h>
#define SHNOTI_MSG @("HUB_Cancel_noti")

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void) addHUDActivityViewExCancel:(NSString*) labelText inView:(UIView *)view;

-(void)showHudWithCacel:(NSString *)labelText inView:(UIView *)view;

@end
