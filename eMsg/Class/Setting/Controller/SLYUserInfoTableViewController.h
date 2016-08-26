//
//  SLYUserInfoTableViewController.h
//  xcar
//
//  Created by sherwin on 16/1/9.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

//! 用户信息页面[编辑]
@interface SLYUserInfoTableViewController : UITableViewController

/////Cell 0
@property (strong, nonatomic) IBOutlet UITableViewCell *myCell0;
@property (weak, nonatomic) IBOutlet UILabel *lbTitileCell0;
@property (weak, nonatomic) IBOutlet UIImageView *ivImageCell0;
/////


///Cell last
@property (strong, nonatomic) IBOutlet UITableViewCell *myCellLast;
//////

- (IBAction)actionLogout:(id)sender;

@end
