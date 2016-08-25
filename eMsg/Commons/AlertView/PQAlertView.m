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

#import "PQAlertView.h"

@interface PQAlertView () <UIAlertViewDelegate>

@property (copy,nonatomic) AlertBlock block;

@end

@implementation PQAlertView

#pragma mark - LifeCycle

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
            otherButtonTitle:(NSString *)otherButtonTitle{
    

    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    
    if(self){
        
        self.block = block;
        
        if(isShow){
            
            [self show];
            
        }
        
    }
    
    return self;
    
}


#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    self.block(buttonIndex,alertView);
    
}

@end
