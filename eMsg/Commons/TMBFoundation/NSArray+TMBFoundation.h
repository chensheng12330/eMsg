//
//  NSArray+TMBFoundation.h
//  TMBFoundation
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSArray
@interface NSArray (TMBFoundation)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)deepCopy;
- (id)mutableDeepCopy;

- (id)trueDeepCopy;
- (id)trueDeepMutableCopy;


@end

#pragma mark - NSMutableArray
@interface NSMutableArray (WeakReferences)

+ (id)noRetainingArray;
+ (id)noRetainingArrayWithCapacity:(NSUInteger)capacity;

@end


#pragma mark - NSMutableDictionary
@interface NSMutableDictionary (WeakReferences)

+ (id)noRetainingDictionary;
+ (id)noRetainingDictionaryWithCapacity:(NSUInteger)capacity;

@end

