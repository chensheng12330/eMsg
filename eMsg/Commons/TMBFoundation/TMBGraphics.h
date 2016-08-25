//
//  TMBGraphics.h
//  xcar
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

//画四角圆角
extern void CGContextAddRoundCornerToPath(CGContextRef context, CGRect rect, CGFloat cornerRadius);
//画圆形区域
extern void CGContextAddCircleRectToPath(CGContextRef context, CGRect rect);

extern CGRect CGRectFromSize(CGSize size);
extern CGPoint CGRectGetCenter(CGRect rect);


@interface TMBGraphics : NSObject

@end
