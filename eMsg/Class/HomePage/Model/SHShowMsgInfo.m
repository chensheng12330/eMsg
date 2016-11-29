//
//  SHShowMsgInfo.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHShowMsgInfo.h"
#import "SHItemListTableViewController.h"
#import "Msg_Model+CoreDataClass.h"


@implementation SHShowMsgInfo

-(instancetype) initWithMsgString:(NSString *)msgStr
{
    self = [super initWithMsgString:msgStr];
    
    self.isRead = NO;
    self.dtDate = [NSDate new];
    self.strPlatformName = [SHPlatformStore getPlatformNameWithItemID:self.strItemID];
    return self;
}

-(instancetype) initWithBaseMsgInfo:(SHBaseMsgInfo *)msgInfo
{
    self = [super init];
    
    self.isRead     = NO;
    self.strItemID  = msgInfo.strItemID;
    self.strMsgContent= msgInfo.strMsgContent;
    self.strPhoneNum = msgInfo.strPhoneNum;
    
    self.dtDate=[NSDate new];
    
    self.strPlatformName = [SHPlatformStore getPlatformNameWithItemID:self.strItemID];
    return self;
}

-(instancetype) initWithMsg_Model:(Msg_Model*) msgModel
{
    self = [super init];
    
    self.strItemID  = msgModel.platform_id;
    self.strPlatformName = msgModel.platform;
    
    self.strMsgContent= msgModel.msg;
    self.strPhoneNum  = msgModel.phone_num;
    
    self.dtDate = [NSDate dateWithTimeIntervalSince1970:[msgModel.date floatValue]];
    self.isRead = msgModel.is_read;
    
    return self;
}

@end
