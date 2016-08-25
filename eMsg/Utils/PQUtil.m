//
//  PQUtil.m
//  iseeplus
//
//  Created by 黄盼青 on 15/11/25.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "PQUtil.h"

@implementation PQUtil


/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+(UIImage *)imageWithUIColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  UIImage转UIColor
 *
 *  @param image UIImage
 *
 *  @return UIColor
 */
+(UIColor *)imageToUIColor:(UIImage *)image{
    return [UIColor colorWithPatternImage:image];
}


/**
 *  返回当前的网络状态类型
 *
 *  @return 当前的网络状态类型
 */
+(PQNetworkType)currentNetwrokType {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"]    subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NSNumber *number = (NSNumber*)[dataNetworkItemView valueForKey:@"dataNetworkType"];
    return [number intValue];
}

/**
 *  毫秒时转时间字符串
 *
 *  @param time 毫秒时
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromTimeInterval:(float)time
{
    int seconds, minutes, hours;
    time /= 1000;
    hours = time / 3600;
    time = time - (hours * 3600);
    minutes = time / 60;
    time = time - (minutes * 60);
    seconds = time;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

/**
 *  @brief 是否是SIP群组用户
 *
 *  @param number SIP地址
 *
 *  @return BOOL
 */
+(BOOL)isSIPGroupMemberNumber:(NSString *)number {
    
    NSString *regular = @"sip:\\d{11}@(.*)";
    
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular];
    
    return [regexPredicate evaluateWithObject:number];
    
}

/**
 *  @brief SIP地址过滤号码
 *
 *  @param sipAddress SIP地址
 *
 *  @return 手机号码
 */
+(NSString *)SIPPhoneNumberFilter:(NSString *)sipAddress {
    
    NSRange range = [sipAddress rangeOfString:@"(?<=sip:).*(?=@)" options:NSRegularExpressionSearch];
    
    return [sipAddress substringWithRange:range];
}

+(NSString *)phoneNumberFilter:(NSString *)phoneNumber {
    
    NSString *ph = [phoneNumber stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    ph = [ph stringByReplacingOccurrencesOfString:@"+" withString:@""];
    ph = [ph stringByReplacingOccurrencesOfString:@"-" withString:@""];
    ph = [ph stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    return ph;
    
}

/**
 *  @brief URL使用key获取query值
 *
 *  @param url NSURL
 *  @param key QueryKey
 *
 *  @return Query值
 */
+(NSString *)urlQueryValue:(NSURL *)url
                   withKey:(NSString *)key {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url
                                                resolvingAgainstBaseURL:NO];
    NSArray *querys = urlComponents.queryItems;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",key];
    
    NSURLQueryItem *queryItem = [[querys filteredArrayUsingPredicate:predicate] firstObject];
    
    return queryItem.value;
    
}

@end
