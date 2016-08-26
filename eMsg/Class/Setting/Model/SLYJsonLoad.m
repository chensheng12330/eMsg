//
//  SLYJsonLoad.m
//  xcar
//
//  Created by sherwin on 16/1/12.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYJsonLoad.h"

static SLYJsonLoad *sharedInstance;
static NSDictionary *_gobTypeMap;

@implementation SLYJsonLoad

+ (instancetype)sharedInstance
{
    static dispatch_once_t DDASLLoggerOnceToken;
    
    dispatch_once(&DDASLLoggerOnceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
        _gobTypeMap  = @{
                         dSHJL_Type_info:@(eJL_Info),
                         dSHJL_Type_text:@(eJL_text),
                         dSHJL_Type_image:@(eJL_image),
                         dSHJL_Type_switch:@(eJL_switch),
                         dSHJL_Type_custom:@(eJL_custom)
                         };
    });
    
    return sharedInstance;
}


-(id) objectForJsonFileName:(NSString*) jsonName
{
    NSString *tempData   = [[NSString alloc]  initWithContentsOfFile:SH_BundlePath(jsonName,@"json") encoding:NSUTF8StringEncoding error:nil];
    id object = [tempData toJSONObject];
    if (object==NULL) {
        
        NSString *erInfo = [NSString stringWithFormat:@"---> 无法加载用户信息页面静态表数据,检测 %@.json 文件是否存在&无数据。",jsonName];
        
        NSLog(@"%@",erInfo);
        //NSAssert(1, erInfo);
    }
    
    return object;
}


-(SHJsonLoadType)type:(NSDictionary*)dict
{
    return [self getTypeForDictionary:dict];
}

-(NSString*)name:(NSDictionary*)dict
{
    return [self getNameForDictionary:dict];
}
-(NSInteger)tid:(NSDictionary*)dict
{
    return [self getTidForDictionary:dict];
}

-(NSString*)icon:(NSDictionary*)dict
{
    return [self getIconForDictionary:dict];
}

-(id)value:(NSDictionary*)dict
{
    return [self getValueForDictionary:dict];
}

-(SHJsonLoadType)getTypeForDictionary:(NSDictionary*)dict
{
    
    if (dict) {
        NSString *strType = dict[kSHJL_CellType_Type];
        SHJsonLoadType jlType = eJL_None;
        if (_gobTypeMap[strType] != NULL ) {
            jlType = (SHJsonLoadType)[_gobTypeMap[strType] integerValue];
        }
        
        return jlType;
    }
    
    return eJL_None;
}

-(NSString*) getNameForDictionary:(NSDictionary*)dict
{
    if (dict) {
        return dict[kSHJL_CellType_Name];
    }
    
    return nil;
}

-(NSInteger) getTidForDictionary:(NSDictionary*)dict
{
    if (dict) {
        return [dict[kSHJL_CellType_Id] integerValue];
    }
    
    return -1;
}

-(NSString*) getIconForDictionary:(NSDictionary*)dict
{
    if (dict) {
        return dict[kSHJL_CellType_Icon];
    }
    
    return nil;
}

-(id) getValueForDictionary:(NSDictionary*)dict
{
    if (dict) {
        return dict[kSHJL_CellType_Value];
    }
    
    return nil;
}
/*
-(NSString*) getNameForKey:(NSString*)key
{
    
}

-(NSString*) getTypeForKey:(NSString*)key
{
    
}*/

@end
