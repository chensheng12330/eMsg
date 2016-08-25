/*
 *  @file PQAlertView.h
 *
 *  @brief Block方式实现UIAlertView，使用更便捷
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-9
 *
 */

#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(NSInteger index,UIAlertView *alertView);

@interface PQAlertView : UIAlertView


/**
 *  @brief 初始化PQAlertView
 *
 *  @param title             标题
 *  @param message           消息内容
 *  @param block             当前选中index Block
 *  @param isShow            是否立即显示
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitle  其他按钮标题
 *
 *  @return PQAlertView
 */
-(instancetype)initWithTitle:(NSString *)title
                     message:(NSString *)message
                clickedIndex:(AlertBlock)block
                        show:(BOOL)isShow
           cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitle:(NSString *)otherButtonTitle;

@end
