//
//  AppDelegate.m
//  xcar
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+PushNotification.h"


#import "ASMainViewController.h"
#import "YZFileManage.h"
#import "ASLoginViewController.h"
#import "SLYNavigationController.h"

static NSString* kRecipesStoreName =@"DataModel.sqlite";

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - AppDelegate LifeCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ///登陆消息监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    

    //初始化本地推送
    [self installPushNotification];
    

    //初始化友盟分析
//    [self installUMAnalytics];
    

    //Core Data
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelVerbose];
    //[MagicalRecord setupCoreDataStackWithStoreNamed:kRecipesStoreName];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kRecipesStoreName];
    
    //SH_MR_Msg
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self initMainViewController:NO];
    
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
//        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:0xe94745]];
//        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//        [[UINavigationBar appearance] setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
//    }
    

    [YZFileManage createAlumbsPath];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {


}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
    return;
}

//-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
////    if (self.allowRotation) {
////        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
////    }
////    return UIInterfaceOrientationMaskPortrait;
//    
//    if([UIApplication sharedApplication].keyWindow.rootViewController != self.rootViewController
//       && [UIApplication sharedApplication].keyWindow.rootViewController.view.tag == 8888) {
//        
//        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
//
//    }else{
//        
//        return UIInterfaceOrientationMaskPortrait;
//        
//    }
//    
//    
//}

#pragma mark - Others

//接收URL Scheme
-(BOOL)application:(UIApplication *)application
     handleOpenURL:(NSURL *)url {
    return YES;
}

#pragma mark - 模块跳转
-(void) initMainViewController:(BOOL) loginSuccess
{
    UINavigationController *nav = nil;
    
    //BOOL isAutoLogin = YES;
    
    if (loginSuccess) {//登陆成功加载主窗口控制器SW
        
        if (self.mainController == nil) {
            self.mainController = [[ASMainViewController alloc] init];
            
           // nav = [[SLYNavigationController alloc] initWithRootViewController:self.mainController];
        }else{
           // nav  = self.mainController.navigationController;
        }
        
        COM.mainVC = self.mainController;
        //nav.navigationBar.translucent = NO;
        self.window.rootViewController = self.mainController;
        self.rootViewController = nil;
        
    }else{//登陆失败加载登陆页面控制器
        _mainController = nil;
        ASLoginViewController *loginController = [[ASLoginViewController alloc] init];
        nav = [[SLYNavigationController alloc] initWithRootViewController:loginController];
        
        //设置7.0以下的导航栏
        if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
            nav.navigationBar.barStyle = UIBarStyleDefault;
            [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                    forBarMetrics:UIBarMetricsDefault];
            nav.navigationBar.backgroundColor = RGBACOLOR(37, 182, 237, 1);
            [nav.navigationBar.layer setMasksToBounds:YES];
        }
        //[nav setNavigationBarHidden:NO];
        
        self.window.rootViewController = nav;
        self.rootViewController = nav;
    }
    
    
    return;
}

-(void)loginStateChange:(NSNotification*) noti
{
    NSNumber *value = noti.object;
    [self initMainViewController:[value boolValue]];
}

@end
