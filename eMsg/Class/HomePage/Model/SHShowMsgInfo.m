//
//  SHShowMsgInfo.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHShowMsgInfo.h"
#import "SHItemListTableViewController.h"

@implementation SHShowMsgInfo

-(instancetype) initWithMsgString:(NSString *)msgStr
{
    self = [super initWithMsgString:msgStr];
    
    self.dtDate = [NSDate new];
    self.strPlatformName = [SHItemListTableViewController getPlatformNameWithItemID:self.strItemID];
    return self;
}

-(instancetype) initWithBaseMsgInfo:(SHBaseMsgInfo *)msgInfo
{
    self = [super init];
    
    self.strItemID  = msgInfo.strItemID;
    self.strMsgContent= msgInfo.strMsgContent;
    self.strPhoneNum = msgInfo.strPhoneNum;
    
    self.dtDate=[NSDate new];
    
    self.strPlatformName = [SHItemListTableViewController getPlatformNameWithItemID:self.strItemID];
    return self;
}
@end
