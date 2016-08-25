//
//  UIColor+Category.h
//  DiscoverSelectionDemo
//
//  Created by yingzhuo on 16/1/4.
//  Copyright © 2016年 yingzhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
+ (UIColor*) systemBlue;

+(UIColor *)navigationBarColor;

+(UIColor *)backgroundColor;
@end
