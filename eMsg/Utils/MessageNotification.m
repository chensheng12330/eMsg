//
//  MessageNotification.m
//  MAE_Standard
//
//  Created by sherwin.chen on 13-8-28.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "MessageNotification.h"

#define MESSAGE_Notification     (@"DeviceChangeNotification")
#define VIDEO_OPERT_Notification (@"VIDEO_OPERT_Notification")

@implementation MessageNotification

+(BOOL) addMessageNotificationObserver:(id)observer Selector:(SEL) selector
{
    if([observer respondsToSelector:selector])
    {
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:MESSAGE_Notification object:nil];
    }
    else
    {
        return NO;
    }
    
    return YES;
}

+(void) removeMessageNotificationObserver:(id)observer
{
    if (observer==NULL) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:MESSAGE_Notification object:nil];
}


//推送者使用
+(void) postMessageNotificationObject:(id)observer MessageInfo:(NSDictionary*) userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_Notification object:observer userInfo:userInfo];
}



#pragma mark - VideoID Process
+(BOOL) addVideoNotificationObserver:(id)observer Selector:(SEL) selector
{
    if([observer respondsToSelector:selector])
    {
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:VIDEO_OPERT_Notification object:nil];
    }
    else
    {
        return NO;
    }
    
    return YES;
}

+(void) removeVideoNotificationObserver:(id)observer
{
    if (observer==NULL) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:VIDEO_OPERT_Notification object:nil];
}

//推送者使用
+(void) postVideoNotificationObject:(id)observer MessageInfo:(NSDictionary*) userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:VIDEO_OPERT_Notification object:observer userInfo:userInfo];
}

@end
