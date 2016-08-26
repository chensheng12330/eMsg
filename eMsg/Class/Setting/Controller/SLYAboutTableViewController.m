//
//  SLYAboutTableViewController.m
//  xcar
//
//  Created by sherwin on 16/1/16.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYAboutTableViewController.h"
#import "SHSettingTableViewCell.h"
#import "SLYWebViewController.h"


@interface SLYAboutTableViewController ()
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation SLYAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self reloadData];
}

-(void) reloadData {
    
    NSArray *arData = [SHJL objectForJsonFileName:@"about_json"];
    
    self.dataSource = [NSArray arrayWithArray:arData];
    
    [self.tableView reloadData];
    return;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 200;
    }
    
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dataSource.count-1;//隐藏版本检查入口
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dataInfo = self.dataSource[indexPath.row];
    
    static NSString *cellIdentifierT = @"SHUserInfoTableViewCell"; //Head Cell
    static NSString *cellIdentifierC = @"SHSettingHeadTableViewCell";
    
    NSString *cellIdentifier = nil;
    
    SHJsonLoadType jlType = [SHJL type:dataInfo];
    
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
        
    }
    
    NSString *strTitle = [SHJL name:dataInfo];
    [cell.lbTitle     setText:strTitle];
    
    NSInteger tid = [SHJL tid:dataInfo];
    
    //NSString *strValue = [SHJL value:dataInfo];
    
    //设置值
    if (tid==1) { //logo
        
        [cell.ivImageVIew setImage:[UIImage imageNamed:[SHJL icon:dataInfo]]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.lbTitle.text = [NSString stringWithFormat:@"v%@",[SystemInfo appVersion]];
    }
    else if(tid>=2 && tid<=4)//服务热线
    {
        //[cell.lbDetail setText:strValue];
        if (tid == 2) {
           cell.lbDetail.text = COM.mUser.mAppConfigInfo.strAppTele;
        }else if (tid == 3){
            cell.lbDetail.text = COM.mUser.mAppConfigInfo.strAppQq;
        }else if (tid == 4){
            cell.lbDetail.text = COM.mUser.mAppConfigInfo.strAppWebside;
        }
        
        [cell.lbDetail setTextColor:[UIColor systemBlue]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(tid==5)
    {
        [cell.lbDetail setText:@""];
    }
    else if(tid==6)//检测新版本
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.lbDetail setText:@"当前已是最新"];
        [cell.lbDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.with.equalTo(cell).offset(-20.0f);
        }];
    }
    
    return cell;
}


#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dataInfo = self.dataSource[indexPath.row];
    NSInteger tid = [SHJL tid:dataInfo];
    
    if(tid==2)
    {
        //NSString *strTitle = [SHJL name:dataInfo];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel:%@",COM.mUser.mAppConfigInfo.strAppTele]]];
    }
    else if (tid==3)
    {
//        NSString *alertMsg =[NSString stringWithFormat:@"%@: %@ .",PQLocalizedSring(@"about_contact_server", ),COM.mUser.mAppConfigInfo.strAppQq];
//        SHAlert(alertMsg);
    }
    else if (tid==4)
    {
        SLYWebViewController *webVC = [[SLYWebViewController alloc] init];
        webVC.title = [YZCommon getCompanyName];
        webVC.strReqUrl =  [NSString stringWithFormat:@"http://%@",COM.mUser.mAppConfigInfo.strAppWebside]; //@"http://cheluyun.com/cheluyun/server/asset/page/treadty.html";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if(tid==5)
    {
//        SLYFeedbackViewController *feedbackVC = [[SLYFeedbackViewController alloc]init];
//        [self.navigationController pushViewController:feedbackVC animated:YES];
//        
    }
    
    return;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 130;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SHSettingTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SHAboutFootView" owner:nil options:nil] firstObject];
    [cell.btnButton addTarget:self action:@selector(treadtyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.lbDetail.text = [NSString stringWithFormat:@"CopyRight (C) 2015-2017 %@  All rights reserved",[YZCommon getCompanyName]];
    //UIColor *color =  cell.btnButton.titleLabel.textColor;
    
    return cell;
}

//-(void)treadtyAction:(UIButton*) sender
//{
//    SLYWebViewController *webVC = [[SLYWebViewController alloc] init];
//    webVC.title = PQLocalizedSring(@"about_privacy", @"隐私声明");
//    webVC.strReqUrl = COM.mUser.mAppConfigInfo.strTreatyUrl; //@"http://cheluyun.com/cheluyun/server/asset/page/treadty.html";
//    [self.navigationController pushViewController:webVC animated:YES];
//    
//    return;
//}

@end
