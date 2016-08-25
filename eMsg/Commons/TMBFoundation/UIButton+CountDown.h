//
//  UIButton+CountDown.h
//  xcar
//
//  Created by 黄盼青 on 16/1/18.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 *  @brief 倒计时按钮
 *
 *  @param timeLine 总时间
 *  @param title    标题
 *  @param subTitle 计时子标题
 *  @param mColor   计时之前的颜色
 *  @param color    计时之后的颜色
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color;

@end
