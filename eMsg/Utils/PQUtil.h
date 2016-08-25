//
//  PQUtil.h
//  iseeplus
//
//  Created by 黄盼青 on 15/11/25.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _NetworkType {
    network_none = 0,
    network_2g,
    network_3g,
    network_4g,
    network_lte,
    network_wifi
} PQNetworkType;

@interface PQUtil : NSObject

/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+(UIImage *)imageWithUIColor:(UIColor *)color;

/**
 *  UIImage转UIColor
 *
 *  @param image UIImage
 *
 *  @return UIColor
 */
+(UIColor *)imageToUIColor:(UIImage *)image;

/**
 *  返回当前的网络状态类型
 *
 *  @return 当前的网络状态类型
 */
+(PQNetworkType)currentNetwrokType;

/**
 *  毫秒时转时间字符串
 *
 *  @param time 毫秒时
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromTimeInterval:(float)time;

/**
 *  @brief 是否是SIP群组用户
 *
 *  @param number SIP地址
 *
 *  @return BOOL
 */
+(BOOL)isSIPGroupMemberNumber:(NSString *)number;

/**
 *  @brief SIP地址过滤号码
 *
 *  @param sipAddress SIP地址
 *
 *  @return 手机号码
 */
+(NSString *)SIPPhoneNumberFilter:(NSString *)sipAddress;

+(NSString *)phoneNumberFilter:(NSString *)phoneNumber;

/**
 *  @brief URL使用key获取query值
 *
 *  @param url NSURL
 *  @param key QueryKey
 *
 *  @return Query值
 */
+(NSString *)urlQueryValue:(NSURL *)url
                   withKey:(NSString *)key;

@end
