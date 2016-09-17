//
//  MKURLConfig.m
//  tmAlbum
//
//  Created by sherwin on 14-2-18.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "SHURLConfig.h"

static SHURLConfig *_sharedURLConfig= nil;

//商户ID值,代码写死
//#define app_agent_id 43


@interface SHURLConfig ()
@property (nonatomic, strong) NSString *basePath;

@property (nonatomic, strong) NSString *strAppAgentId;
@end

@implementation SHURLConfig

#pragma mark - SH 单例化
+ (instancetype) sharedInstance
{
    @synchronized(self)
    {
        if (nil == _sharedURLConfig ) {
            _sharedURLConfig = [[self alloc] init];
        }
    }
    return _sharedURLConfig;
}

+(id)alloc
{
    @synchronized([SHURLConfig class]) //线程访问加锁
    {
        NSAssert(_sharedURLConfig == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedURLConfig  = [super alloc];
        return _sharedURLConfig;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.strAppAgentId = [YZCommon getAgentID];
        
        self.v = @"1.0";
        self.basePath = [NSString stringWithFormat:@"%@?v=%@&agent_id=%@&",[self getHost],self.v,self.strAppAgentId];
    }
    return self;
}

#pragma mark - SH 外部接口函数
/*
 http://120.55.163.83  正式服务器
 http://121.42.52.249  测试服务器
 
 */
-(NSString*) getHost
{
    return @"http://api.ema6.com:20161";
}

-(NSString*) getArea
{
    return [NSString stringWithFormat:@"%@/Api/userGetArea?Code=UTF8",[self getHost]];
}

-(NSString*) getLoginForUsr:(NSString *)uName P:(NSString *)pWd
{
    return [NSString stringWithFormat:@"%@/Api/userLogin?Code=UTF8&uName=%@&pWord=%@&Developer=%@",[self getHost],uName,pWd,DEVLP_KEY];
}

-(NSString*) getPlatformItemsForUTok:(NSString*) userToken
{
    return [NSString stringWithFormat:@"%@/Api/userGetItems?Code=UTF8&token=%@&tp=ut",[self getHost],userToken];
}

-(NSString*) getPhoneNumForToken:(NSString *)token itemID:(NSString *)itemID phoneType:(NSInteger)phoneType
{
    //http://api.ema6.com:20161/Api/userGetPhone?ItemId=项目ID&token=登陆token&PhoneType=0
    
    return [NSString stringWithFormat:@"%@/Api/userGetPhone?Code=UTF8&token=%@&ItemId=%@&PhoneType=%ld",[self getHost],token,itemID,phoneType];
}

-(NSString*) getGetMessage4Token:(NSString *)token
{
    return [NSString stringWithFormat:@"%@/Api/userGetMessage?token=%@",[self getHost],token];
}
///////////////////////////


-(NSString*) getLoginForU:(NSString*)uName P:(NSString*) pWd
{
    NSAssert((uName || pWd), @"uName && pwd 不能为空.");
    
    return [NSString stringWithFormat:@"%@method=login&username=%@&password=%@",self.basePath,uName,pWd];
}

-(NSString*) getRegisterForU:(NSString*)uName
                           P:(NSString*) pWd
                          sC:(NSString*) smsCode
                          sI:(NSString*) smsCodeID
{
    NSAssert((uName || pWd || smsCode || smsCodeID), @"uName && pwd &&smsCode &&smsCodeID 不能为空.");
    
    return [NSString stringWithFormat:@"%@method=register&username=%@&password=%@&smscode=%@&smscode_id=%@",self.basePath,uName,pWd,smsCode,smsCodeID];
}

-(NSString*) getUserProfileForU:(NSString*) uid
                           uTok:(NSString*) userToken
{
     NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    
     return [NSString stringWithFormat:@"%@method=get_user_profile&userid=%@&usertoken=%@",self.basePath,uid,userToken];
}

-(NSString*) getEditProfileForU:(NSString*) uid
                           uTok:(NSString*) userToken
                           nick:(NSString*) nickName
                           icon:(NSString*) iconUrl
                           desc:(NSString*) describe
{
    NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    
    NSString *strBase = [NSString stringWithFormat:@"%@method=get_user_profile&userid=%@&usertoken=%@",self.basePath,uid,userToken];
    
    if (nickName) {
        strBase = [NSString stringWithFormat:@"&nick=%@",strBase];
    }
    
    if (iconUrl) {
        strBase = [NSString stringWithFormat:@"&cover_path=%@",iconUrl];
    }
    
    if (describe) {
        strBase = [NSString stringWithFormat:@"&usersign=%@",describe];
    }
    
    return strBase;
}

-(NSString *)getHomePageForU:(NSString *)uid uTok:(NSString *)userToken
{
    //NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    return [NSString stringWithFormat:@"%@method=get_homepage_data&userid=%@&usertoken=%@&is_recommend=1",self.basePath,uid,userToken];
    
}

-(NSString *)getMoreHomePageFor:(NSString *)uid uTok:(NSString *)userToken lastTimestamp:(NSString *)laststamp
{
    //NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    NSString *urlString = [NSString stringWithFormat:@"%@method=find_dynamic_page&userid=%@&usertoken=%@&is_recommend=1",self.basePath,uid,userToken];
    if (![laststamp isEqual:[NSNull null]] && laststamp) {
        urlString = [NSString stringWithFormat:@"%@&last_timestamp=%@",urlString,laststamp];
    }
    return urlString;
}

-(NSString *)getSingleInfoForU:(NSString *)uid uTok:(NSString *)userToken dynamicId:(NSString *)dynamicId
{
    NSAssert((uid || userToken || dynamicId), @"uid && userToken && dynamicId 不能为空.");
     return [NSString stringWithFormat:@"%@method=get_dynamic_detail&userid=%@&usertoken=%@&dynamic_id=%@",self.basePath,uid,userToken,dynamicId];
}

-(NSString *)getUploadFileForU:(NSString *)uid uTok:(NSString *)userToken
{
    NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    //return [NSString stringWithFormat:@"%@method=upload&userid=%@&usertoken=%@",self.basePath,uid,userToken];
    return @"http://121.42.52.249:7051/FileOperate/FileUploadServlet";
}



-(NSString *)getShareUrl:(NSString *)dynamicId
{
    return [NSString stringWithFormat:@"http://120.55.163.83/chelubao/App/AppShare/?id=%@",dynamicId];
}

-(NSDictionary *)getBaseParams {
    
    SLYUser *user = [YZCommon sharedCommon].mUser;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setValue:@"1.0" forKey:@"v"];
    [params setValue:user.strUserId forKey:@"userid"];
    [params setValue:user.strUserToken  forKey:@"usertoken"];
    [params setValue:[NSNumber numberWithInteger:[self.strAppAgentId integerValue]] forKey:@"agent_id"];
    
    return [params copy];
    
    
}

//!获取app配置信息
-(NSString *)getAppConfigInformationForU:(NSString *)uid
                                    uTok:(NSString *)userToken
{
    NSAssert((uid || userToken), @"uid && userToken 不能为空.");
    return [NSString stringWithFormat:@"%@&method=get_app_config&userid=%@&usertoken=%@",self.basePath,uid,userToken];
}

@end
