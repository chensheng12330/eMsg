//
//  AppDelegate+PushNotification.m
//  xcar
//
//  Created by 黄盼青 on 15/12/30.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "AppDelegate+PushNotification.h"

@implementation AppDelegate (PushNotification)


/**
 *  @brief 初始化本地推送
 */
-(void)installPushNotification {
    
    // 处理iOS8本地推送不能收到的问题
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 直接打开app时，图标上的数字清零
  //  application.applicationIconBadgeNumber = 0;
    
    
}

-(void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    // 图标上的数字减1
    application.applicationIconBadgeNumber = 0;
    
    SHAlert(notification.alertBody);
}


@end
