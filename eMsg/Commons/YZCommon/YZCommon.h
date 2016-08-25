/************************************************************
 *  * Temobi CONFIDENTIAL
 * __________________
 * Copyright (C) 2015 Temobi Technologies. All rights reserved.
 *
 * NOTICE: All information included here,to protect technology propert
 * of Temobi,all reproduction and dissemination of this material without
 * permission is strictly forbidden.
 */

#import <Foundation/Foundation.h>

#import "SLYUser.h"

#import "AppDelegate.h"


#define COM [YZCommon sharedCommon]

@interface YZCommon : NSObject

@property (nonatomic, strong) SLYUser* mUser;

@property (nonatomic,strong) NSString *lastTimestamp;


@property (nonatomic,weak) UITabBarController *mainVC;
+(YZCommon*) sharedCommon;


-(NSInteger) isOK:(NSDictionary*) info;



//!  获取APP名称
+(NSString *) getAPPName;

//!  获取APP名称
+(NSString *) getAPPIconName;

//!  获取APP版权公司名
+(NSString *) getCompanyName;

//!  获取APP商户名ID
+(NSString *) getAgentID;

//!  获取APP版权公司code
+(NSString *) getVersionCode;

//!获取app当前版本号
+(NSString *)getAPPCurrentVersion;


//!  获取当前登陆用户的用户名
+(NSString *) getUserName;

//! 获取当前登陆用户的nickname，如果为nil,用username代替
+(NSString *) getNickName;
//!获取指定用户的nickname，如果为nil，则用username代替
+(NSString *)getNickName:(NSString *)username;

//+(void) setUserDefaultsForKey:(NSString*) key Value:(NSString*) Value;

//清除缓存
+(void)clearCaches;

-(BOOL) getFirstGuide;
-(void) setFirstGuide:(BOOL)bYesOrNo;
@end
