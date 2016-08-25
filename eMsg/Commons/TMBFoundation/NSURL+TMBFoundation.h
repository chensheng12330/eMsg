//
//  NSURL+TMBFoundation.h
//  TMBFoundation
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (TMBFoundation)

/**
 *  @brief 获取URL的Query值
 *
 *  @discuz 例如http://xxx.com/x.do?name=docee 使用该方法获取key为name的值就是docee
 *
 *  @param key QueryKey
 *
 *  @return QueryValue
 */
-(NSString *)queryValueWithKey:(NSString *)key;

@end
