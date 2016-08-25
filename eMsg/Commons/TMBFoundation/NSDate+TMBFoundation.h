//
//  NSDate+TMBFoundation.h
//  xcar
//
//  Created by 黄盼青 on 16/1/11.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TMBFoundation)

/**
 *  @brief 显示 XX分钟前/XX小时前/XX天前等信息
 *
 *  @return NSString
 */
- (NSString *)prettyDate;

+(NSString *)formattedDate:(NSDate *)date;

@end
