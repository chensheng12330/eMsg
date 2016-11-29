//
//  SHShowMsgInfo.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHMsgInfo.h"


@interface SHShowMsgInfo : SHBaseMsgInfo

//! 平台名称
@property (nonatomic, copy) NSString *strPlatformName;

//! 接收时间
@property (nonatomic, retain) NSDate *dtDate;

//! 是否已读.
@property (nonatomic, assign) BOOL isRead;

-(instancetype) initWithMsgString:(NSString *)msgStr;

//! 根据SHBaseMsgInfo类进行实例化.
-(instancetype) initWithBaseMsgInfo:(SHBaseMsgInfo *)msgInfo;

//! 根据DB结构表实例化.
-(instancetype) initWithMsg_Model:(id) msgModel;
@end
