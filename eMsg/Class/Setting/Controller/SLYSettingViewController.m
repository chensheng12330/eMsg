//
//  SLYSettingViewController.m
//  xcar
//
//  Created by sherwin on 15/12/30.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "SLYWebViewController.h"
#import "SHSettingTableViewCell.h"
#import "SLYSettingViewController.h"
#import "SLYUserInfoTableViewController.h"
#import "SLYAppSettingTableViewController.h"
#import "SLYAboutTableViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SLYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)  UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation SLYSettingViewController

-(void)dealloc
{
    NSLog(@"%s---->dealloc",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"关于";
    self .automaticallyAdjustsScrollViewInsets = NO;
    [self installTableView];
    
    [self reloadData];
    
    return;
}



#pragma mark - View init &load
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
   // NSLog(@"about = %@",self.tableView);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
   // self.tableView.contentOffset = CGPointMake(0, 0);
    
}

/**
 *  初始化TableView
 */
-(void)installTableView {
    
    UIView *anchorView = [[UIView alloc] init];
    [self.view addSubview:anchorView];
    [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(-1.0f);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1.0f);
    }];

    self.tableView = [[UITableView alloc] init];
    _tableView.delegate     = self;
    _tableView.dataSource   = self;
    _tableView.scrollsToTop = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithHex:0xe6e5e5];
    
    [self.view addSubview:_tableView];
 
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(anchorView.mas_bottom);
        make.left.equalTo(self.view).with.offset(0.0f);
        make.bottom.equalTo(self.view).with.offset(-49.0f);
        make.right.equalTo(self.view).with.offset(0.0f);
    }];
    return;
}

#pragma mark - UITableView Datasource

/**
 *  重新加载数据
 */
-(void) reloadData {
    
    NSArray *arData = [SHJL objectForJsonFileName:@"setting_json"];
    
    self.dataSource = [NSMutableArray arrayWithArray:arData];
    
    
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (SH_StringIsNULL(COM.mUser.strUserId)) {
        return;
    }

    return;
}

-(void) loadHeadViewData
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 200;
    }
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dataInfo = self.dataSource[indexPath.row];
    
    static NSString *cellIdentifierT = @"SHSettingTableViewCell"; //Head Cell
    static NSString *cellIdentifierC = @"SHSettingHeadTableViewCell";
    
    NSString *cellIdentifier = nil;
    
    SHJsonLoadType jlType = [SHJL type:dataInfo];
    NSInteger tid = [SHJL tid:dataInfo];
    
    if(jlType==eJL_text)
    {
        cellIdentifier = cellIdentifierT;
    }
    else if(jlType==eJL_custom)
    {
        cellIdentifier = cellIdentifierC;
    }
    else{
        cellIdentifier = cellIdentifierT;
    }
    
    SHSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
         cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] firstObject];

        //分割线
        UIImageView *separatorLine = [[UIImageView alloc]initWithImage:[PQUtil imageWithUIColor:[UIColor colorWithWhite:0.765 alpha:1.000]]];
        [cell addSubview:separatorLine];
        
        [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell).with.offset(0.0f);
            make.right.equalTo(cell).with.offset(0.0f);
            make.bottom.equalTo(cell).with.offset(0.0f);
            make.height.mas_equalTo(0.5f);
            
        }];
        
        if(tid==1)
        {
            [cell.ivImageVIew setUserInteractionEnabled:YES];
            cell.ivImageVIew.layer.cornerRadius = cell.ivImageVIew.frame.size.width/2;
            cell.ivImageVIew.layer.masksToBounds = YES;
            
            UITapGestureRecognizer *gap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goUserInfo)];
            [cell.ivImageVIew addGestureRecognizer:gap];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    if (tid==1) {
        if (!SH_StringIsNULL(COM.mUser.mUserDetail.strNickName)) {
            [cell.lbTitle     setText:COM.mUser.mUserDetail.strNickName];
        }
        else
        {
             [cell.lbTitle     setText:COM.mUser.strUserName];
        }
        
        if (!SH_StringIsNULL(COM.mUser.mUserDetail.strCoverPath)) {
            [cell.ivImageVIew setImageWithURL:[NSURL URLWithString:COM.mUser.mUserDetail.strCoverPath] placeholderImage:[UIImage imageNamed:[SHJL icon:dataInfo]]];
        }
        else{
             [cell.ivImageVIew setImage:[UIImage imageNamed:[SHJL icon:dataInfo]]];
        }
    }
    else
    {
        [cell.lbTitle     setText:[SHJL name:dataInfo]];
        [cell.ivImageVIew setImage:[UIImage imageNamed:[SHJL icon:dataInfo]]];
    }
    
    return cell;
}

-(UITableViewCell *) loadHeadCell
{
    //cell H: 165
    
    
    return nil;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dataInfo = self.dataSource[indexPath.row];
    NSInteger tid = [SHJL tid:dataInfo];
    NSString* strName = [SHJL name:dataInfo];
    
    //NSInteger section = indexPath.section;
    //NSInteger index   = indexPath.row;
    
    if (tid==2) {
        SLYAppSettingTableViewController *appSet = [[SLYAppSettingTableViewController alloc] init];
        appSet.title = strName;
        [self.navigationController pushViewController:appSet animated:YES];
    }
    else if(tid==3)
    {
        SLYWebViewController *webVC = [[SLYWebViewController alloc] init];
        webVC.strReqUrl = COM.mUser.mAppConfigInfo.strAppHelpUrl;
        webVC.title = strName;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if (tid==5)
    {
        SLYAboutTableViewController *aboutVC = [[SLYAboutTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        aboutVC.title = strName;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
    return;
}

#pragma mark - 功能函数

//!  跳转用户设置界面.如果没登陆，跳登陆窗口

-(void) goUserInfo
{
    SLYUserInfoTableViewController *userVC = [SLYUserInfoTableViewController new];
    userVC.title = @"个人信息";
    [self.navigationController pushViewController:userVC animated:YES];
    return;
}

@end
