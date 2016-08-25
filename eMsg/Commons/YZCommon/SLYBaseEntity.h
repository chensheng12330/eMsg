//
//  SLYBaseEntity.h
//  xcar
//
//  Created by sherwin on 16/1/18.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//


#import <Foundation/Foundation.h>

//! 基类实体类,定义一些常用的通知基础数据
@interface SLYBaseEntity : NSObject

@property (nonatomic, copy) NSString *strID;
@property (nonatomic, copy) NSString *strName;

/*!
 @method
 @brief      从NSDictionary对象化的字典中实例化本类
 @abstract   nil
 @discussion 可在本类内部定义相关的KEY值，解析操作
 @param      dictInfo JSON化的NSDictionary数据湃，
 @result     实例化本类对象
 */
-(instancetype) initWithDictionary:(NSDictionary*) dictInfo;

/*!
 @method
 @brief      从JSON化的Array数据中获取array
 @abstract   nil
 @discussion 从JSON化的 NSArray数组中实例化每个SLYBaseEntity对象，并以数组形式返回。
 @param      arInfo JSON化的NSArray数组，可在类内部定义相关的KEY值。
 @result     返回包裹 SLYBaseEntity NSMutableArray 类型的数组对象
 */
+(NSArray *) arrayFromArray:(NSArray*) arInfo;

/*!
 @method
 @brief      从JSON化的Dictionary数据中获取array
 @abstract   nil
 @discussion 从JSON化的 NSDictionary数组中实例化每个SLYBaseEntity对象，并以数组形式返回。
 @param      dictInfo JSON化的NSDictionary字典，可在类内部定义相关的KEY值。
 @result     返回包裹 SLYBaseEntity NSMutableArray 类型的数组对象
 */
+(NSArray *) arrayFromDictionary:(NSDictionary*) dictInfo;

@end
