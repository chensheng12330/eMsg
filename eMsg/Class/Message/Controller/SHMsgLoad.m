//
//  SHMsgLoad.m
//  eMsg
//
//  Created by sherwin.chen on 16/9/19.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHMsgLoad.h"


@interface SHMsgLoad ()
@end

@implementation SHMsgLoad

- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}

/*
 2. 获取短信验证码消息队列/可一次获取多个所有的短信状态
 
 [方法] /Api/userGetMessage
 
 说明：
 1.使用该方法获得验证码后，系统自动加黑该号码
 2. 因部分短信可能延迟，所以建议该方法每5秒调用一次，调用60秒（可增加获取成功率）
 
 传入参数：
 1. token ：token[必须]
 
 GET方式调用实例：http://api.ema6.com:20161/Api/userGetMessage?token=登陆token
 
 方法调用返回值示例： 成功返回：【消息队列】
 
 消息队列介绍：
 
 1. 消息队列信息最后末尾为[End]结束
 2. 消息队列信息划分都已 & 符号分割
 3. 消息队列第一分割字符为命令类型
 
 消息队列命令种类介绍：
 
 1. 用户状态信息：
 USER&余额&最大登录数&最大获取号码数&客户端最大获取号码数&折扣
 2. 短信内容：
 MSG&项目ID&号码&短信内容
 3. 发送状态：
 STATE&项目ID&号码&短信内容
 4. 号码释放通知：
 RES&项目ID&号码
 多号号码返回的内容要根据手机号来分割获取验证码
 
 注意：
 返回内容有两个格式，请兼容解析，格式如下：
 第一种： RES&12711&15692024415[End]MSG&12711&18508406360&验证码：985651，请勿将验证码泄露给他人[End]
 第二种： MSG&12711&13002964529&验证码：379297，请勿将验证码泄露给他人[End]RES&12711&15692024415[End]
 3: NOTION&★★★★备用网址★★www.ema6.com:8000。冲值方**,下线分成10点.欢迎定制各种软件。API特惠Q1666371515。提供长期在线号。[End]
 */

#define MAX_T  30
#define MIN_T  10

-(void) startMsgLoad
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
   
    [manager GET:[UC getGetMessage4Token:COM.mUser.strUserToken]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
             if (responseObject==NULL || responseObject.length<1) {
                 [self performSelector:@selector(startMsgLoad) withObject:nil afterDelay:MIN_T];
             }
             else
             {
                 
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:4];
                 
                 //respStr = @"MSG&18551&15712439849&【小猪巴士】您的验证码为：0770，2分钟内有效，请尽快验证。[End]";
                 
                 NSLog(@"[respStr] %@",respStr);
                 
                 //错误处理
                 //False:Session 过期
                 
                 if ([COM getCodeFromRespString:respStr]) {
                     [self performSelector:@selector(startMsgLoad) withObject:nil afterDelay:MIN_T];
                     return ;
                 }
                 
                 //解释短信内容;
                 BOOL isOK = NO;
                 NSArray *msgQueue = [respStr componentsSeparatedByString:@"[End]"];
                 for (NSString *msgStr in msgQueue) {
                     if ([msgStr hasPrefix:@"MSG"]) {
                         //MSG&12711&13002964529&验证码
                         //MSG&项目ID&号码&短信内容
                         isOK = YES;
                         
                         SHShowMsgInfo *msgInfo = [[SHShowMsgInfo alloc] initWithMsgString:msgStr];
                         if (msgInfo) {
                             self.latelyMsgInfo = msgInfo;
                             
                             //存入数据库
                             [SH_MR_Msg creteDataWithMsgInfo:msgInfo];
                             

                             //发送 Noti消息
                             [[NSNotificationCenter defaultCenter] postNotificationName:kMSG_RECV_NOTI object:msgInfo];
                             NSLog(@"MSG: %@",msgStr);
                         }

                         break;
                     }
                 }
                 
                 if (isOK == NO) {
                     [self performSelector:@selector(startMsgLoad) withObject:nil afterDelay:MIN_T];
                 }
                 else{
                     [self performSelector:@selector(startMsgLoad) withObject:nil afterDelay:MAX_T];
                 }
                 /*
                 NSArray *arPhoneList =  [respStr componentsSeparatedByString:@"[End]"];
                 if (arPhoneList.count<1) {
                     //未获取到手机号码
                 
                 }
                 else
                 {
                     // 侟入数据
 
                 }*/
                 
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             [self performSelector:@selector(startMsgLoad) withObject:nil afterDelay:MAX_T];
         }
     
     ];
}

-(void) stopMsgLoad
{
    [SHMsgLoad cancelPreviousPerformRequestsWithTarget:self];
}

@end
