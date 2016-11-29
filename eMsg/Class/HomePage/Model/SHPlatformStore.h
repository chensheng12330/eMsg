//
//  SHPlatformStore.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/29.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SH_PS [SHPlatformStore sharedInstance]

@interface SHPlatformStore : NSObject

+ (instancetype) sharedInstance;

//! 从网络获取数据，并存在本地.
-(void) getPlatformList4Net:(void (^)(NSArray *list, NSError * error))backBlock;
+(NSArray*)  getPlatformsFromDB;
+(NSString*) getPlatformNameWithItemID:(NSString *) itemID;

@end
