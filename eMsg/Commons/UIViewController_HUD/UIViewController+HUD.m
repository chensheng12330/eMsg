/************************************************************
 *  * 深蓝蕴 CONFIDENTIAL
 * __________________
 * Copyright (C) 2015 深蓝蕴 Technologies. All rights reserved.
 *
 * NOTICE: All information included here,to protect technology propert
 * of 深蓝蕴,all reproduction and dissemination of this material without
 * permission is strictly forbidden.
 */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void) addHUDActivityViewExCancel:(NSString*) labelText inView:(UIView *)view
{
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];

    HUD.labelText = labelText;
    
    UIButton *btnCancle = [UIButton buttonWithType:0];
    
    CGSize size = [labelText boundingRectWithSize: CGSizeMake(HUD.frame.size.width, CGFLOAT_MAX)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:nil
                               context:nil].size;

    
    CGPoint point = view.center;
    point.x += 60;
    point.y -= 38;
    
    [btnCancle setFrame:CGRectMake(point.x, point.y, 30, 30)];
    
    [btnCancle setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
    [btnCancle addTarget:self action:@selector(MB_Canecel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancle setShowsTouchWhenHighlighted:YES];
    
    //HUD.customView = btnCancle;
    [HUD addSubview:btnCancle];
//    UIProgressView *progessView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 30, size.width+20, 50)];
//    progessView.trackTintColor = [UIColor whiteColor];
//    progessView.progressTintColor = [UIColor navigationBarColor];
    //HUD.customView = progessView;
    //HUD.mode = MBProgressHUDModeCustomView;
    HUD.mode = MBProgressHUDModeDeterminate;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

-(void)showHudWithCacel:(NSString *)labelText inView:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.labelText = labelText;
    
    UIButton *btnCancle = [UIButton buttonWithType:0];
    
    CGSize size = [labelText boundingRectWithSize: CGSizeMake(HUD.frame.size.width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:nil
                                          context:nil].size;
    
    
    CGPoint point = view.center;
    point.x += (size.width/2-30);
    point.y -= 38;
    
    [btnCancle setFrame:CGRectMake(point.x, point.y, 30, 30)];
    
    [btnCancle setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
    [btnCancle addTarget:self action:@selector(MB_Canecel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancle setShowsTouchWhenHighlighted:YES];
    
    [HUD addSubview:btnCancle];
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];

}
-(void) MB_Canecel:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHNOTI_MSG object:nil];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hide:YES];
}

@end
