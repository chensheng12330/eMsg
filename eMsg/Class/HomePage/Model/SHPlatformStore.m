//
//  SHPlatformStore.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/29.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHPlatformStore.h"

@implementation SHPlatformStore

static SHPlatformStore *_sharedSHPlatformStore = nil;

#pragma mark - object init
+(instancetype) sharedInstance
{
    @synchronized(self)
    {
        if (nil == _sharedSHPlatformStore ) {
            _sharedSHPlatformStore = [[self alloc] init];
        }
    }
    return _sharedSHPlatformStore;
}


//)^(BOOL yesOrNo, NSError* error)
-(void) getPlatformList4Net:(void (^)(NSArray *list, NSError * error))backBlock
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    
    [manager GET:[UC getPlatformItemsForUTok:COM.mUser.strUserToken] //
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
          
             
             if (responseObject==NULL || responseObject.length<1) {
                 backBlock(nil,[NSError errorWithDomain:@"eMsg" code:1001 userInfo:@{@"error":@"数据异常，请重新."}]);
                 
                 return ;
             }
             else
             {
                 //29400&咪咕星宝&0.18&4
                 //项目ID&项目名称&项目价格&项目类型\n
                 
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:4];
                 int code = [COM getCodeFromRespString:respStr];
                 if (code==1) {
                     //过期，需要重新登陆.
                     backBlock(nil,[NSError errorWithDomain:@"eMsg" code:1002 userInfo:@{@"error":@"过期，需要重新登陆."}]);
                     return ;
                 }
                 else if(code==2){
                     //请求失败.
                    
                     backBlock(nil,[NSError errorWithDomain:@"eMsg" code:1001 userInfo:@{@"error":@"请求失败,请您重试."}]);
                     return ;
                 }
                 
                 NSArray *itemInfoList =  [respStr componentsSeparatedByString:@"\n"];
                 
                 NSMutableArray *addSource = [NSMutableArray new];
                 for (NSString *itemInfo in itemInfoList) {
                     
                     NSArray *itemInfoList =  [itemInfo componentsSeparatedByString:@"&"];
                     if (itemInfoList.count >3) {
                         NSMutableDictionary *itemInfo = [NSMutableDictionary new];
                         [itemInfo setObject:itemInfoList[0] forKey:IL_ItemID];
                         [itemInfo setObject:itemInfoList[1] forKey:IL_ItemName];
                         [itemInfo setObject:itemInfoList[2] forKey:IL_ItemPrice];
                         [itemInfo setObject:itemInfoList[3] forKey:IL_ItemType];
                         [addSource addObject:itemInfo];
                     }
                 }
                 
                 if (itemInfoList.count>0) {
                     
                     NSString *fileP = [NSString stringWithFormat:@"%@/%@_itemInfoList",SH_LibraryDir,COM.mUser.strUserName];
                     [addSource writeToFile:fileP atomically:YES];
                     
                 }
                 backBlock(addSource,nil);
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             backBlock(nil,[NSError errorWithDomain:@"eMsg" code:1003 userInfo:@{@"error":@"服务器请求失败,请检测您的网络."}]);
             
         }
     
     ];
}


+(NSArray*) getPlatformsFromDB
{
    NSString *fileP = [NSString stringWithFormat:@"%@/%@_itemInfoList",SH_LibraryDir,COM.mUser.strUserName];
    return [[NSArray alloc] initWithContentsOfFile:fileP];
}

+(NSString*) getPlatformNameWithItemID:(NSString *) itemID
{
    if (itemID.length<1) {
        return nil;
    }
    
    NSArray *saveItems = [self getPlatformsFromDB];
    if (saveItems.count<1) {
        return nil;
    }
    
    for (NSDictionary *info in saveItems) {
        if ([itemID isEqualToString:info[IL_ItemID]]) {
            return info[IL_ItemName];
        }
    }
    
    return nil;
}


@end
