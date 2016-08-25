//
//  SLYUser.m
//  xcar
//
//  Created by sherwin on 16/1/18.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYUser.h"

#define kUser_usertoken (@"usertoken")
#define kUser_sip_host  (@"sip_host")
#define kUser_sip_password  (@"sip_password")
#define kUser_sip_port      (@"sip_port")
#define kUser_sip_username  (@"sip_username")
#define kUser_userid     (@"userid")
#define kUser_usertoken  (@"usertoken")
#define kUser_user       (@"user")
#define kUser_cover_path (@"coverPath")
#define kUser_nick       (@"nick")
#define kUser_usersign   (@"usersign")
#define KUser_app_name (@"app_name")
#define KUser_app_help_url (@"help_url")
#define KUser_app_qq (@"qq")
#define KUser_app_tele (@"tele")
#define KUser_app_webside (@"webside")
#define KUser_app_config (@"app_config")
#define KUser_app_update (@"ios_update")
#define KUser_update_server_version (@"server_version")
#define KUser_update_updateMsg (@"updateMsg")
#define KUser_update_url (@"url")

@implementation SLYSipInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strSip_host = @"";
        self.strSip_port = @"";
        self.strSip_username = @"";
        self.strSip_password = @"";
    }
    return self;
}
-(instancetype) initWithDictionary:(NSDictionary*) dictInfo
{
    if (dictInfo==NULL) {
       // TMBLogError(@"SLYSipInfo -> initWithDictionary:dictInfo 参数为空.");
        return nil;
    }
    
    self = [super init];
    
    self.strSip_host = dictInfo[kUser_sip_host];
    self.strSip_port = dictInfo[kUser_sip_port];
    self.strSip_username = dictInfo[kUser_sip_username];
    self.strSip_password = dictInfo[kUser_sip_password];
    
    return self;
}
@end


@implementation SLYUserDetail
- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.strNickName  = @"";
        self.strCoverPath = @"";
        self.strDescribe  = @"";
    }
    return self;
}

-(instancetype) initWithDictionary:(NSDictionary*) dictInfo
{
    if (dictInfo==NULL) {
        //TMBLogError(@"SLYUserDetail -> initWithDictionary:dictInfo 参数为空.");
        return nil;
    }
    self = [super init];
    
    self.strNickName  = dictInfo[kUser_nick];
    self.strCoverPath = dictInfo[kUser_cover_path];
    self.strDescribe  = dictInfo[kUser_usersign];
    
    return self;
}
@end

@implementation SLYAppConfigInfo

-(instancetype)init
{
    if (self = [super init]) {
        self.strAppName = @"";
        self.strAppHelpUrl = @"";
        self.strAppQq = @"";
        self.strAppTele = @"";
        self.strAppWebside = @"";
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictInfo
{
    if (dictInfo==NULL) {
        //TMBLogError(@"SLYAppConfigInfo -> initWithDictionary:dictInfo 参数为空.");
        return nil;
    }
    self = [super init];
    
    self.strAppName = dictInfo[KUser_app_name];
    self.strAppHelpUrl = dictInfo[KUser_app_help_url];
    self.strAppQq = dictInfo[KUser_app_qq];
    self.strAppTele = dictInfo[KUser_app_tele];
    self.strAppWebside = dictInfo[KUser_app_webside];
    
    return self;

}

@end

@implementation SLYAppUpdateInfo

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.strServerVersion = @"";
        self.strUpdateMsg = @"";
        self.strUpdateUrl = @"";
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictInfo
{
    if (dictInfo==NULL) {
        //TMBLogError(@"SLYAppUpdateInfo -> initWithDictionary:dictInfo 参数为空.");
        return nil;
    }
    self = [super init];
    self.strServerVersion = dictInfo[KUser_update_server_version];
    self.strUpdateMsg = dictInfo[KUser_update_updateMsg];
    self.strUpdateUrl = dictInfo[KUser_update_url];
    return self;
}

@end

@implementation SLYUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strUserToken = @"";
        self.strUserId    = @"";
        self.strUserName  = @"";
        self.strUserPwd   = @"";
    }
    return self;
}

-(instancetype) initWithDictionary:(NSDictionary*) dictInfo
{
    if (dictInfo==NULL) {
        //TMBLogError(@"SLYUser -> initWithDictionary:dictInfo 参数为空.");
        return nil;
    }
    
    self = [super init];
    
    self.strUserId = dictInfo[kUser_userid];
    self.strUserToken = dictInfo[kUser_usertoken];
    
    self.mSipInfo   = [[SLYSipInfo alloc] initWithDictionary:dictInfo];
    
    NSDictionary *userInfo = dictInfo[kUser_user];
    if (userInfo && ![userInfo isKindOfClass:[NSNull class]]) {
        self.mUserDetail= [[SLYUserDetail alloc] initWithDictionary:userInfo];
    }
    
    self.mAppConfigInfo = [[SLYAppConfigInfo alloc] initWithDictionary:dictInfo[KUser_app_config]];
    
    self.mAppUpdateInfo = [[SLYAppUpdateInfo alloc] initWithDictionary:dictInfo[KUser_app_update]];
    
    return self;
}

-(NSDictionary*) userSerializeDictionary
{
    return @{
             kUser_userid:      self.strUserId,
             kUser_usertoken:   self.strUserToken,
             kUser_sip_host:    self.mSipInfo.strSip_host,
             kUser_sip_port:    self.mSipInfo.strSip_port,
             kUser_sip_username:self.mSipInfo.strSip_username,
             kUser_sip_password:self.mSipInfo.strSip_password,
             kUser_user: @{
                 kUser_nick: self.mUserDetail.strNickName,
                 kUser_usersign: self.mUserDetail.strDescribe,
                 kUser_cover_path:self.mUserDetail.strCoverPath
             }
             };
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@  \n 【%@】", [self class], self, [super description], [self userSerializeDictionary]];
}
@end
