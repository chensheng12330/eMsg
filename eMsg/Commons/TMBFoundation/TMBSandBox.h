/*
 *  @file TMBSandBox.h
 *
 *  @brief 应用沙盒地址获取
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-9
 *
 */

#import <Foundation/Foundation.h>

@interface TMBSandBox : NSObject

/**
 *  @brief 应用程序目录，不能存任何东西
 *
 *  @return 应用程序目录
 */
+(NSString *)AppPath;

/**
 *  @brief 文档目录，需要ITUNES同步备份的数据存这里
 *
 *  @return 文档目录
 */
+(NSString *)DocPath;

/**
 *  @brief 配置目录，配置文件存这里
 *
 *  @return 配置目录
 */
+(NSString *)LibPrefPath;

/**
 *  @brief 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 *
 *  @return 缓存目录
 */
+(NSString *)LibCachePath;

/**
 *  @brief 缓存目录，APP退出后，系统可能会删除这里的内容
 *
 *  @return 缓存目录
 */
+(NSString *)TmpPath;

@end
