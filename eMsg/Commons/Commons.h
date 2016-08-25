//
//  Commons.h
//  xcar
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#ifndef Commons_h
#define Commons_h


#ifdef __OBJC__

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

//#pragma mark - Others

#import "PQJSONKit.h"           //JSON处理
#import "PQAlertView.h"         //Block形式的UIAlertView
#import "pinyin.h"              //汉字拼音获取
#import "SystemInfo.h"          //系统信息
#import "TMBSandBox.h"          //应用沙盒路径获取
#import "SHURLConfig.h"

#pragma mark - TMBFoundation

//#import "NSData+GZIP.h"              //ZIP压缩数据
#import "NSData+Base64.h"            //Base64
#import "NSData+Crypto.h"            //数据加密
#import "NSArray+TMBFoundation.h"    //NSArray扩展
#import "UIImage+TMBFoundation.h"    //UIImage扩展
#import "NSURL+TMBFoundation.h"      //NSURL扩展
#import "NSDate+TMBFoundation.h"     //NSDate扩展
#import "NSString+TMBFoundation.h"   //NSString扩展


///网络
#import "AFNetworking.h"
#import "YZFileManage.h"

#endif


#endif /* Commons_h */

