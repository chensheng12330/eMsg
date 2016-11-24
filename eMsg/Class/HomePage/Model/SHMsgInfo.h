//
//  SHMsgInfo.h
//  eMsg
//
//  Created by sherwin.chen on 2016/11/24.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHBaseMsgInfo : NSObject

//! 平台ID
@property (nonatomic, copy) NSString *strItemID;

//! 电话号码
@property (nonatomic, copy) NSString *strPhoneNum;

//! 短信验证码
//@property (nonatomic, copy) NSString *strMsgCode;

//! 短信内容
@property (nonatomic, copy) NSString *strMsgContent;

//! 根据服务端返回消息串，进行对象化解析.
-(instancetype) initWithMsgString:(NSString*) msgStr;

@end
