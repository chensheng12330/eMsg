//
//  SHMsgSotre.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHMsgSotre.h"
#import "Msg_Model+CoreDataClass.h"

@implementation SHMsgSotre

static SHMsgSotre *_sharedSHMsgSotre = nil;

#pragma mark - object init
+(SHMsgSotre*) sharedInstance
{
    @synchronized(self)
    {
        if (nil == _sharedSHMsgSotre ) {
            _sharedSHMsgSotre = [[self alloc] init];
        }
    }
    return _sharedSHMsgSotre;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


//! create
-(BOOL)creteDataWithMsgInfo:(SHShowMsgInfo*) msgInfo
{
    if (msgInfo==NULL) {
        return NO;
    }
    
    Msg_Model *msgModel = [Msg_Model MR_createEntity];
    //unix时间截
    msgModel.date = @([msgInfo.dtDate timeIntervalSince1970]);
    msgModel.is_read = @(0);
    msgModel.msg = msgInfo.strMsgContent;
    msgModel.phone_num = msgInfo.strPhoneNum;
    msgModel.platform = msgInfo.strPlatformName;
    msgModel.platform_id = msgInfo.strItemID;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    return YES;
}

//! query
-(NSArray*) queryMsgWithPhoneNum:(NSString*) phoneNum
{
    NSArray *msgList = [Msg_Model MR_findAllSortedBy:@"date" ascending:NO];
    
    NSMutableArray *backMsgList = [[NSMutableArray alloc] init];
    for (Msg_Model *msgModelDB in msgList) {
        SHShowMsgInfo *msg = [[SHShowMsgInfo alloc] initWithMsg_Model:msgModelDB];
        [backMsgList addObject:msg];
    }
    
    return backMsgList;
}

//! update
-(BOOL) updateMsgWithPhoneNum:(NSString*) phoneNum msgInfo:(SHShowMsgInfo*) msgInfo
{
    return YES;
}

//! delete
-(BOOL) deleteMsgWithMsgID:(NSString*) msgID
{
    NSArray *msgList = [Msg_Model MR_findByAttribute:@"platform_id" withValue:msgID];
    
    Msg_Model *msg = [msgList firstObject];
    
    [msg MR_deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return YES;
}
@end
