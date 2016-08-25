//
//  NSDate+TMBFoundation.m
//  xcar
//
//  Created by 黄盼青 on 16/1/11.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "NSDate+TMBFoundation.h"

@implementation NSDate (TMBFoundation)

/**
 *  @brief 显示 XX分钟前/XX小时前/XX天前等信息
 *
 *  @return NSString
 */
- (NSString *)prettyDate{
    
    NSString *suffix = @"前";
    NSString *yearStr = @"年";
    NSString *monthStr = @"个月";
    NSString *weekStr = @"周";
    NSString *dayStr = @"天";
    NSString *hourStr = @"小时";
    NSString *minuteStr = @"分钟";
    NSString *momentStr = @"刚刚";
    
    float different = [NSDate date].timeIntervalSince1970 - self.timeIntervalSince1970/1000;

    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60) {
            return momentStr;
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120) {
            return [NSString stringWithFormat:@"1%@%@", minuteStr,suffix];
        }
        
        // lower than 60 minutes
        if (different < 60 * 60) {
            return [NSString stringWithFormat:@"%d%@%@", (int)floor(different / 60), minuteStr,suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            return [NSString stringWithFormat:@"1%@%@", hourStr, suffix];
        }
        
        // lower than one day
        if (different < 86400) {
            return [NSString stringWithFormat:@"%d%@%@", (int)floor(different / 3600), hourStr, suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        return [NSString stringWithFormat:@"%d%@%@", days, dayStr, suffix];
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        return [NSString stringWithFormat:@"%d%@%@", weeks, weekStr, suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        return [NSString stringWithFormat:@"%d%@%@", months, monthStr, suffix];
    }
    // lager than a year
    else {
        return [NSString stringWithFormat:@"%d%@%@", years, yearStr, suffix];
    }
    
    return self.description;
}

+(NSString *)formattedDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    return [dateFormatter stringFromDate:date];
}

@end
