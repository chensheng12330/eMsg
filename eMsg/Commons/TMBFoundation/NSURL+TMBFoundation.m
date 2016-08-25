//
//  NSURL+TMBFoundation.m
//  TMBFoundation
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "NSURL+TMBFoundation.h"

@implementation NSURL (TMBFoundation)


-(NSString *)queryValueWithKey:(NSString *)key {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:self
                                             resolvingAgainstBaseURL:NO];
    
    NSArray *querys = components.queryItems;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",key];
    NSURLQueryItem *queryItem = [[querys filteredArrayUsingPredicate:predicate] firstObject];
    
    return queryItem.value;
    
}


@end
