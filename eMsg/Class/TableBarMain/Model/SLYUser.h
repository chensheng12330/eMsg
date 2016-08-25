//
//  SLYUser.h
//  xcar
//
//  Created by sherwin on 16/1/18.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYBaseEntity.h"

@interface SLYSipInfo : SLYBaseEntity
//! SIP 服务器IP
@property (nonatomic, copy) NSString *strSip_host;
//! SIP 服务器port
@property (nonatomic, copy) NSString *strSip_port;
//! SIP 账户用户名（与当前 车路宝账户进行关联）
@property (nonatomic, copy) NSString *strSip_username;
//! SIP 账户密码
@property (nonatomic, copy) NSString *strSip_password;

@end

//! 用户详情类
@interface SLYUserDetail : SLYBaseEntity
//! 用户昵称
@property (nonatomic, copy) NSString *strNickName;
//! 用户头像
@property (nonatomic, copy) NSString *strCoverPath;
//! 用户个人签名&描述
@property (nonatomic, copy) NSString *strDescribe;
@end

//!app配置信息类
@interface SLYAppConfigInfo:SLYBaseEntity
//!app名称
@property (nonatomic,copy) NSString *strAppName;
//!app帮助信息
@property (nonatomic,copy) NSString *strAppHelpUrl;
//!客服qq
@property (nonatomic,copy) NSString *strAppQq;
//!服务热线
@property (nonatomic,copy) NSString *strAppTele;
//!官方网站
@property (nonatomic,copy) NSString *strAppWebside;

@end

//!app版本更新类
@interface SLYAppUpdateInfo : SLYBaseEntity
//!服务器版本号
@property (nonatomic,copy) NSString *strServerVersion;
//!服务器更新信息
@property (nonatomic,copy) NSString *strUpdateMsg;
//!下载app地址
@property (nonatomic,copy) NSString *strUpdateUrl;

@end

//! 用户信息类
@interface SLYUser : SLYBaseEntity

//继承父类
//@property (nonatomic, copy) NSString *strID;  //   userid
//@property (nonatomic, copy) NSString *strName;

//! 用户登陆后的UID
@property (nonatomic, copy) NSString *strUserId;

//! 用户登陆后的UserToken
@property (nonatomic, copy) NSString *strUserToken;

//!用户名
@property (nonatomic, copy) NSString *strUserName;
//!用户密码
@property (nonatomic, copy) NSString *strUserPwd;

//! 用户详细信息
@property (nonatomic, strong) SLYUserDetail* mUserDetail;

#pragma mark - SIP账号信息
//! 用户关联的SIP账号信息
@property (nonatomic, strong) SLYSipInfo *mSipInfo;

//!app配置信息
@property (nonatomic,strong) SLYAppConfigInfo *mAppConfigInfo;

//!app更新信息
@property (nonatomic,strong) SLYAppUpdateInfo *mAppUpdateInfo;


@end









