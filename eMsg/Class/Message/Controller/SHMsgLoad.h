//
//  SHMsgLoad.h
//  eMsg
//
//  Created by sherwin.chen on 16/9/19.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHShowMsgInfo.h"

static NSString* kMSG_RECV_NOTI= @"k_Msg_Recv_noti";

@interface SHMsgLoad : NSObject

@property (nonatomic, retain) SHShowMsgInfo *latelyMsgInfo;

-(void) startMsgLoad;
-(void) stopMsgLoad;
@end
