//
//  SHMsgSotre.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHShowMsgInfo.h"

@interface SHMsgSotre : NSObject

//! create
-(BOOL)creteDataWithMsgInfo:(SHShowMsgInfo*) msgInfo;

//! query
-(SHShowMsgInfo*) queryMsgWithPhoneNum:(NSString*) phoneNum;

//! update
-(BOOL) updateMsgWithPhoneNum:(NSString*) phoneNum msgInfo:(SHShowMsgInfo*) msgInfo;

//! delete
-(BOOL) deleteMsgWithMsgID:(NSString*) msgID;

@end
