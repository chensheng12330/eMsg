/*
 *  @file SystemInfo.h
 *
 *  @brief 设备与系统信息查看
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-29
 *
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IOS8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )


typedef NS_ENUM(NSInteger,NetworkType){
    NetworkType_None,
    NetworkType_2G,
    NetworkType_3G,
    NetworkType_4G,
    NetworkType_LTE,
    NetworkType_Wifi
};

@interface SystemInfo : NSObject

/*系统版本*/
+ (NSString *)osVersion;

/*硬件版本*/
+ (NSString *)platform;

/*硬件版本名称*/
+ (NSString *)platformString;

/*系统当前时间 格式：yyyy-MM-dd HH:mm:ss*/
+ (NSString *)systemTimeInfo;

/*应用版本*/
+ (NSString *)appVersion;

/*是否是iPhone5*/
+ (BOOL)is_iPhone_5;

/*是否越狱*/
+ (BOOL)isJailBroken;

/*越狱版本*/
+ (NSString *)jailBreaker;

/*本地ip*/
+ (NSString *)localIPAddress;

/*公网IP*/
+ (NSString *)publicIPAddress;

/*当前的网络状态类型*/
+(NetworkType)currentNetwrokType;

/**
 *  @brief 屏幕绝对大小(iOS8以后旋屏宽高会对调，这里修正这个误差)
 *
 *  @return 绝对屏幕大小
 */
+(CGSize)absoluteScreenSize;

@end
