//
//  ASMainViewController.m
//  iseeplus
//
//  Created by 黄盼青 on 15/11/30.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "ASMainViewController.h"
#import "SLYDefine.h"

#import "SHHomeTableViewController.h"
#import "SLYSettingViewController.h"
#import "SHMessageTableViewController.h"

#import "SHMsgLoad.h"

#define TABBAR_HEIGHT 55.0f

@interface ASMainViewController () <UIAlertViewDelegate>

@property (nonatomic) NSInteger homeSelectedSegmentIndex;
@property (nonatomic) NSInteger ablumSelectedSegmentIndex;

@end

@implementation ASMainViewController

#pragma mark - LifeCycle

+(instancetype)shared{
    
    static ASMainViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       // instance = [[ASMainViewController alloc]init];
        
    });
    
    return instance;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:0xe94745]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:17.0], NSFontAttributeName, nil]];
    
    
    //[self customNavigationView:0];
    [self setupSubviews];
    
    //监控是否接收到新短消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvMsg:) name:kMSG_RECV_NOTI object:nil];
    
    return;
}

-(void)recvMsg:(NSNotification*) notification
{
    //1,红点
    //2,本地消息通知
    //3,短信存储
}

- (void)setupSubviews
{
    //状态栏黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.subVCS = [NSMutableArray array];
    
    NSArray *titles    = @[@"首页",@"短信",@"我的"];
    NSArray *icons_nor = @[@"tab_home_nor",@"tab_image_nor",@"tab_my_nor"];
    NSArray *icons_sel = @[@"tab_home_sel",@"tab_image_sel",@"tab_my_sel"];
    
    NSArray *classes= @[@"SHHomeTableViewController",@"SHMessageTableViewController",@"SLYSettingViewController"];
    for (int i=0; i<classes.count; i++) {
        
        UIViewController *obj = [[NSClassFromString(classes[i]) alloc] init];
        
        if (i == 0) {
 //           self.discoverVC = (SLYDiscoverViewController *)obj;
        }else if (i==2){
   //         self.albumVC = (SLYAlbumViewController *)obj;
        }
        obj.title = titles[i];
        UIImage *selectedImage=nil;
        selectedImage = [UIImage imageNamed:icons_sel[i]] ;
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        obj.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:icons_nor[i]] selectedImage:selectedImage];
        obj.tabBarItem.tag = i;
        
        [self unSelectedTapTabBarItems:obj.tabBarItem];
        [self selectedTapTabBarItems:obj.tabBarItem];
        
        UINavigationController  *navC = [[UINavigationController alloc]initWithRootViewController:obj];
        navC.navigationBar.translucent = YES;

        [self.subVCS addObject:navC];
    }
    
    self.viewControllers = self.subVCS;
    self.selectedIndex = 0;
    
    return;
}


#pragma mark - UITabBarDelegate

- (void)tabBar1:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [self customNavigationView:item.tag];
        self.title = @"首页";
        
    }else if (item.tag == 1){
        self.navigationItem.titleView = nil;
        [self customrightNav:item.tag];
        self.title = @"记录仪";
    }else if (item.tag == 2){
        [self customNavigationView:2];
         self.title = @"相册";
    }else if (item.tag == 3){
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.title = @"关于";
    }
}
-(void)customNavigationView:(NSInteger)tag
{
    NSArray *items =@[@"精选",@"最新",@"附近"];
    if (tag == 2) {
        items = @[@"本地相册",@"记录仪相册"];
    }
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 7, 225, 30);
    if (tag == 2) {
        segment.tag = 200;
    }
    segment.selectedSegmentIndex = tag == 0 ? self.homeSelectedSegmentIndex : self.ablumSelectedSegmentIndex;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    [self customrightNav:tag];
    
}
-(void)customrightNav:(NSInteger)tag
{

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    backBtn.frame = CGRectMake(10, 7, 30, 30);
    if (tag == 0) {
       [backBtn setImage:[UIImage imageNamed:@"nav_share_nor"] forState:UIControlStateNormal];
        backBtn.tag = 500;
    }else if(tag == 1)
    {
        //[backBtn setTitle:@"刷新" forState:UIControlStateNormal];  setting@2x.png
        [backBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        backBtn.tag = 501;
    }else if (tag == 2)
    {
        [backBtn setTitle:@"选择" forState:UIControlStateNormal];
        backBtn.tag = 502;
    }
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    [backBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

/*
 - (void)initNavBarItem
 {
 UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 
 backBtn.frame = CGRectMake(10, 7, 30, 30);
 [backBtn setImage:[UIImage imageNamed:@"play_recycle_all"] forState:UIControlStateNormal];
 [backBtn setHighlighted:YES];
 [backBtn addTarget:self action:@selector(clickConnetBtn:) forControlEvents:UIControlEventTouchUpInside];
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
 return ;
 }
 */


-(void)clickRightBtn:(UIButton *)button
{
    
    if (button.tag == 500) {
        ///分享
      
        [[NSNotificationCenter defaultCenter] postNotificationName:YZ_SHOW_DROPDOWN_LIST object:nil];
      
        
    }else if (button.tag == 501)
    {
        //设置
        [[NSNotificationCenter defaultCenter] postNotificationName:YZ_Device_Setting object:nil];
        
    }else if (button.tag == 502)
    {
        //选择
        
        button.selected = !button.selected;
        
        //多选相片
        if (button.selected) {//多选
            [[NSNotificationCenter defaultCenter] postNotificationName:YZ_ABLUMS_ALLOW_MULTISELECT object:@YES];
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }else//取消多选
        {
             [[NSNotificationCenter defaultCenter] postNotificationName:YZ_ABLUMS_ALLOW_MULTISELECT object:@NO];
            [button setTitle:@"选择" forState:UIControlStateNormal];
        }

        
    }
}

/*
-(void)segmentAction:(UISegmentedControl *)segment
{
    if (segment.tag == 200) {//相册
        self.ablumSelectedSegmentIndex = segment.selectedSegmentIndex;
        if (segment.selectedSegmentIndex == 0) {
            //本地相册
            [self.albumVC reloadData];
            self.albumVC.isDevice = NO;
        }else
        {
            //记录仪相册
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedDeviceAblums" object:@YES];
        }
        return;
    }
    self.homeSelectedSegmentIndex = segment.selectedSegmentIndex;
    ///发现
    if (segment.selectedSegmentIndex == 0) {
        //精选
        [self.discoverVC configSelectionUI];
    }else if (segment.selectedSegmentIndex == 1)
    {
        //最新
        [self.discoverVC configLastNewUI];
    }else if (segment.selectedSegmentIndex == 2)
    {
        //附近
        [self.discoverVC configNearbyUI];
    }
    
}

*
 *  隐藏自定义TabBar
 *
 *  @param isHide 是否隐藏
 */
-(void)setTabBarHidden:(BOOL)isHide {
    
    if(isHide){
        self.tabBar.hidden = YES;
    }else{
        self.tabBar.hidden = NO;
    }
    return;
}


-(void)dealloc {
    
}


-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:12], NSFontAttributeName,[UIColor colorWithHex:0x000000],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:12],
                                        NSFontAttributeName,[UIColor colorWithHex:0xe94745],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}

@end
