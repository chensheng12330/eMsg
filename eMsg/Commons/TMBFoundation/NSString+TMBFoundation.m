//
//  NSString+TMBFoundation.m
//  xcar
//
//  Created by 黄盼青 on 16/1/19.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "NSString+TMBFoundation.h"

@implementation NSString (TMBFoundation)

/**
 *  @brief 去除两边空白
 *
 *  @return NSString
 */
-(NSString *)trim {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}

@end
