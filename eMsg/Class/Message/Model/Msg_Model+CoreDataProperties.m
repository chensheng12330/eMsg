//
//  Msg_Model+CoreDataProperties.m
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "Msg_Model+CoreDataProperties.h"

@implementation Msg_Model (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Msg_Model"];
}

@dynamic date;
@dynamic is_read;
@dynamic msg;
@dynamic phone_num;
@dynamic platform;

@end
