//
//  SHSettingTableViewCell.h
//  xcar
//
//  Created by sherwin on 16/1/7.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (weak, nonatomic) IBOutlet UILabel *lbIsRead;

-(void) setCellWithShowMsgInfo:(id)msgInfo;
@end
