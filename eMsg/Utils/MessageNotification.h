//
//  MessageNotification.h
//  MAE_Standard
//
//  Created by sherwin.chen on 13-8-28.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageNotification : NSObject

//监听者使用
+(BOOL) addMessageNotificationObserver:(id)observer Selector:(SEL) selector;
+(void) removeMessageNotificationObserver:(id)observer;

//推送者使用
+(void) postMessageNotificationObject:(id)observer MessageInfo:(NSDictionary*) userInfo;



//监听者使用
+(BOOL) addVideoNotificationObserver:(id)observer Selector:(SEL) selector;
+(void) removeVideoNotificationObserver:(id)observer;

//推送者使用
+(void) postVideoNotificationObject:(id)observer MessageInfo:(NSDictionary*) userInfo;
@end
