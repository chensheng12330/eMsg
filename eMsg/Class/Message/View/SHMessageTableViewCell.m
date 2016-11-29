//
//  SHSettingTableViewCell.m
//  xcar
//
//  Created by sherwin on 16/1/7.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHMessageTableViewCell.h"
#include "SHShowMsgInfo.h"

@implementation SHMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void) setCellWithShowMsgInfo:(SHShowMsgInfo*)msgInfo
{
    self.lbPhoneNum.text = msgInfo.strPhoneNum;
    self.lbDate.text = [msgInfo.dtDate description];
    self.lbTitle.text = msgInfo.strPlatformName;
    self.lbMsg.text = msgInfo.strMsgContent;
    
    if (msgInfo.isRead) {
        self.lbIsRead.text = @"已读";
        self.lbIsRead.backgroundColor = [UIColor blueColor];
    }
    else{
        self.lbIsRead.text = @"未读";
    }
    
    return;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
