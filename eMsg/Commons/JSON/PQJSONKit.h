/*
 *  @file PQJSONKit.h
 *
 *  @brief JSON格式化工具
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-9
 *
 */

#import <Foundation/Foundation.h>

@interface PQJSONKit : NSObject

@end

#pragma mark - NSString Category

@interface NSString (PQJSONCategory)

/**
 *  @brief JSON字符串转NSArray或NSDictionary
 *
 *  @param jsonString JSON字符串
 *
 *  @return NSArray或NSDictionary
 */
+(id)parseJSONString:(NSString *)jsonString;

-(id)toJSONObject;
@end

#pragma mark - NSDictionary Category

@interface NSDictionary (PQJSONCategory)

/**
 *  @brief NSDictionary转JSON字符串
 *
 *  @return JSON字符串
 */
-(NSString *)toJSONString;


@end

#pragma mark - NSMutableDictionary Category

@interface NSMutableDictionary (PQJSONCategory)

/**
 *  @brief NSMutableDictionary转JSON字符串
 *
 *  @return JSON字符串
 */
-(NSString *)toJSONString;

@end

@interface NSArray (PQJSONCategory)
-(NSString *)toJSONString;
@end


@interface NSMutableArray (PQJSONCategory)
-(NSString *)toJSONString;
@end



@interface NSData (PQJSONCategory)
-(id) toJSONObject;
@end