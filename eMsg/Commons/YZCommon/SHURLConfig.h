//
//  SHURLConfig.h
//  tmAlbum
//
//  Created by sherwin on 14-2-18.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UC [SHURLConfig sharedInstance]

#define DEVLP_KEY  (@"nl%2b%2bva55Az%2bstOKhuti4Hg%3d%3d")

//! 静态配置服务端接口
@interface SHURLConfig : NSObject
@property (nonatomic, strong) NSString *v; //接口版本

+ (instancetype) sharedInstance;

//! 获取接口主地址
-(NSString*) getHost;

//! 登陆接口
-(NSString*) getLoginForU:(NSString*)uName P:(NSString*) pWd;

//! 注册接口
-(NSString*) getRegisterForU:(NSString*)uName
                           P:(NSString*) pWd
                          sC:(NSString*) smsCode
                          sI:(NSString*) smsCodeID;

//! 获取个人资料
-(NSString*) getUserProfileForU:(NSString*) uid
                           uTok:(NSString*) userToken;
//! 编辑/上传个人资料
-(NSString*) getEditProfileForU:(NSString*) uid
                           uTok:(NSString*) userToken
                           nick:(NSString*) nickName
                           icon:(NSString*) iconUrl
                           desc:(NSString*) describe;

//!获取首页数据
-(NSString *)getHomePageForU:(NSString*)uid
                        uTok:(NSString*)userToken;

//!上拉加载更多数据
-(NSString *)getMoreHomePageFor:(NSString *)uid
                           uTok:(NSString *)userToken
                  lastTimestamp:(NSString *)laststamp;

//!获取单条动态详细信息
-(NSString *)getSingleInfoForU:(NSString *)uid
                          uTok:(NSString *)userToken
                     dynamicId:(NSString *)dynamicId;
//!获取文件上传信息
-(NSString *)getUploadFileForU:(NSString *)uid
                          uTok:(NSString *)userToken;


//!获取分享url
-(NSString *)getShareUrl:(NSString *)dynamicId;

//!获取app配置信息
-(NSString *)getAppConfigInformationForU:(NSString *)uid
                                    uTok:(NSString *)userToken;



-(NSDictionary *)getBaseParams;

-(NSString*) getLoginForUsr:(NSString *)uName P:(NSString *)pWd;

@end
