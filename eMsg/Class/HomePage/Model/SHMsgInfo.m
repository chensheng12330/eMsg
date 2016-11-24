//
//  SHMsgInfo.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHMsgInfo.h"

@implementation SHBaseMsgInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        _strItemID  = _strPhoneNum = _strMsgContent =nil;
    }
    return self;
}

-(instancetype) initWithMsgString:(NSString*) msgStr
{
    //MSG&12711&13002964529&验证码：379297，请勿将验证码泄露给他人[End]
    
    if (msgStr.length<1) {
        SHLog(@"%s 解析出错",__FUNCTION__);
        return nil;
    }
    
    self = [self init];
    
    NSArray *msgParam = [msgStr componentsSeparatedByString:@"&"];
    
    NSInteger parCount = msgParam.count;
    
    if (parCount>1) {
        self.strItemID = msgParam[1];
    }
    
    if (parCount>2) {
        self.strPhoneNum = msgParam[2];
    }
    
    if (parCount>3) {
        self.strMsgContent = msgParam[3];
    }
    
    return self;
}

@end
