//
//  SHItemListTableViewController.h
//  eMsg
//
//  Created by sherwin.chen on 16/8/27.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IL_ItemID   (@"ItemID")
#define IL_ItemName (@"ItemName")
#define IL_ItemPrice (@"ItemPrice")
#define IL_ItemType (@"ItemType")

typedef NS_ENUM(NSUInteger, RequestDataType) {
    IL_Type_Area,
    IL_Type_Items,
};


@interface SHItemListTableViewController : UITableViewController

@property (nonatomic, assign) RequestDataType dataType;
@end
