//
//  SHSettingTableViewCell.h
//  xcar
//
//  Created by sherwin on 16/1/7.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDetail;

@property (weak, nonatomic) IBOutlet UISwitch *swSwitch;


@property (weak, nonatomic) IBOutlet UIButton *btnButton;


@end
