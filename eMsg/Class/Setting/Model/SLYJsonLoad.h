//
//  SLYJsonLoad.h
//  xcar
//
//  Created by sherwin on 16/1/12.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kSHJL_CellType_Id   = @"id";
static NSString *const kSHJL_CellType_Name = @"name";
static NSString *const kSHJL_CellType_Type = @"type";
static NSString *const kSHJL_CellType_Icon = @"icon";
static NSString *const kSHJL_CellType_Value= @"value";

typedef enum : NSUInteger {
    eJL_None=0,
    eJL_Info,
    eJL_text,
    eJL_switch,
    eJL_image,
    eJL_custom
} SHJsonLoadType;

#define dSHJL_Type_info    (@"info")  //可选信息，将有多个选项目例如：|  名称        IOS大神 > |
#define dSHJL_Type_text    (@"text")  //纯文本信息，不可修          |  性别        男        |
#define dSHJL_Type_switch  (@"switch") //开关器
#define dSHJL_Type_image   (@"image")  //图像器
#define dSHJL_Type_custom  (@"custom") //自定义

#define SHJL [SLYJsonLoad sharedInstance]

@interface SLYJsonLoad : NSObject

+ (instancetype)sharedInstance;

-(id) objectForJsonFileName:(NSString*) jsonName;

//-(NSString*) getNameForKey:(NSString*)key;
//-(NSString*) getTypeForKey:(NSString*)key;
//!快速方法
-(SHJsonLoadType)type:(NSDictionary*)dict;
-(NSString*)name:(NSDictionary*)dict;
-(NSInteger)tid:(NSDictionary*)dict;
-(NSString*)icon:(NSDictionary*)dict;
-(id)value:(NSDictionary*)dict;

-(SHJsonLoadType)getTypeForDictionary:(NSDictionary*)dict;
-(NSString*) getNameForDictionary:(NSDictionary*)dict;
-(NSInteger) getTidForDictionary:(NSDictionary*)dict;
-(NSString*) getIconForDictionary:(NSDictionary*)dict;
-(id) getValueForDictionary:(NSDictionary*)dict;

@end
