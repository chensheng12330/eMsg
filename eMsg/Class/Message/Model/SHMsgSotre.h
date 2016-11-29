//
//  SHMsgSotre.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHShowMsgInfo.h"

#define SH_MR_Msg [SHMsgSotre sharedInstance]

@interface SHMsgSotre : NSObject


+ (instancetype) sharedInstance;

//! create
-(BOOL)creteDataWithMsgInfo:(SHShowMsgInfo*) msgInfo;

//! query
-(NSArray*) queryMsgWithPhoneNum:(NSString*) phoneNum;

//! update
-(BOOL) updateMsgWithPhoneNum:(NSString*) phoneNum msgInfo:(SHShowMsgInfo*) msgInfo;

//! delete
-(BOOL) deleteMsgWithMsgID:(NSString*) msgID;

@end
