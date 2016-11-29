//
//  SHItemListTableViewController.h
//  eMsg
//
//  Created by sherwin.chen on 16/8/27.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RequestDataType) {
    IL_Type_Area,
    IL_Type_Items,
};

@protocol ItemListDelegate <NSObject>

-(void) didSelectItemListWithData:(NSObject*) data requestDataType:(RequestDataType) reqType;

@end

@interface SHItemListTableViewController : UITableViewController

@property (nonatomic, weak) id<ItemListDelegate> delegate;
@property (nonatomic, assign) RequestDataType dataType;


@end
