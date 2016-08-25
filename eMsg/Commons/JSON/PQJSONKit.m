/*
 *  @file PQJSONKit.m
 *
 *  @brief JSON格式化工具
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-9
 *
 */

#import "PQJSONKit.h"

@implementation PQJSONKit


#pragma mark - Private

/**
 *  @brief 对象转JSON数据
 *
 *  @param theData 被转对象
 *  @param error   错误信息
 *
 *  @return NSData
 */
+(NSData *)toJSONData:(id)theData error:(NSError *)error{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    //转换成功
    if(jsonData.length > 0 && error == nil){
        
        return jsonData;
        
    }
    
    NSLog(@"JSON Format Error!");
    return nil;
    
}

/**
 *  @brief JSON数据转字符串
 *
 *  @param jsonData JSON数据
 *
 *  @return JSON字符串
 */
+(NSString *)jsonDataToString:(NSData *)jsonData {
    
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end

#pragma mark - NSString Category

@implementation NSString (JSONCategory)

/**
 *  @brief JSON字符串转NSArray或NSDictionary
 *
 *  @param jsonString JSON字符串
 *
 *  @return NSArray或NSDictionary
 */
+(id)parseJSONString:(NSString *)jsonString {
    
    if(jsonString == nil){
        return nil;
    }
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError *error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error !=nil){
        
        NSLog(@"Parse JSON String Error!");
        return nil;
        
    }
    
    return result;
    
}


-(id)toJSONObject {
    
    return [NSString parseJSONString:self];
}

@end


#pragma mark - NSArray Category
@implementation NSArray (JSONCategory)
-(NSString *)toJSONString {
    
    NSData *data = [PQJSONKit toJSONData:self error:nil];
    
    return [PQJSONKit jsonDataToString:data];
    
}
@end

@implementation NSMutableArray (JSONCategory)
-(NSString *)toJSONString {
    
    NSData *data = [PQJSONKit toJSONData:self error:nil];
    
    return [PQJSONKit jsonDataToString:data];
    
}
@end


#pragma mark - NSDictionary Category

@implementation NSDictionary (JSONCategory)

/**
 *  @brief NSDictionary转JSON字符串
 *
 *  @return JSON字符串
 */
-(NSString *)toJSONString {
    
    NSData *data = [PQJSONKit toJSONData:self error:nil];
    
    return [PQJSONKit jsonDataToString:data];
    
}

@end

#pragma mark - NSMutableDictionary Category

@implementation NSMutableDictionary (JSONCategory)

/**
 *  @brief NSMutableDictionary转JSON字符串
 *
 *  @return JSON字符串
 */
-(NSString *)toJSONString {
    
    NSDictionary *dictionary = [self copy];
    
    return [dictionary toJSONString];
    
}

@end

@implementation NSData (JSONCategory)

/**
 *  @brief NSMutableDictionary转JSON字符串
 *
 *  @return JSON字符串
 */
-(id) toJSONObject {
    
    __autoreleasing NSError *error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    
    if(error !=nil){
        
        NSLog(@"Parse JSON String Error!");
        return nil;
        
    }
    
    return result;
}
@end

