//
//  Msg_Model+CoreDataProperties.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "Msg_Model+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Msg_Model (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *date;
@property (nullable, nonatomic, copy) NSNumber *is_read;
@property (nullable, nonatomic, copy) NSString *msg;
@property (nullable, nonatomic, copy) NSString *phone_num;
@property (nullable, nonatomic, copy) NSString *platform;
@property (nullable, nonatomic, copy) NSString *platform_id;
@end

NS_ASSUME_NONNULL_END
