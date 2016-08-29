//
//  SLYAppSettingTableViewController.m
//  xcar
//
//  Created by sherwin on 16/1/9.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#define SH_APP_Set_loc_key (@"小号属性")
#define SH_APP_Set_dev_key (@"小号列表")

#import "SHHomeTableViewController.h"
#import "SHSettingTableViewCell.h"
#import "PQActionSheet.h"
#import "SHItemListTableViewController.h"

@interface SHHomeTableViewController ()<PQActionSheetDelegate>
@property (strong, nonatomic) NSDictionary *dataSource;
@property (nonatomic, strong) NSArray *keys;

@property (nonatomic,strong) NSArray *arSP;// 运营商列表
@property (nonatomic, assign) NSInteger nSpSel;
@end

@implementation SHHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arSP = @[@"[全部]",@"[移动]",@"[联通]",@"[电信]"];
    self.nSpSel = 0;
    
    
    self.clearsSelectionOnViewWillAppear = NO;
    //[self setHidesBottomBarWhenPushed:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.tabBarController.tabBar.hidden = NO;
    //[self setHidesBottomBarWhenPushed:YES];
    [self reloadData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    //[super viewWillDisappear:animated];
    //self.tabBarController.tabBar.hidden = YES;
}

-(void) reloadData {
    
    self.keys = @[SH_APP_Set_loc_key,SH_APP_Set_dev_key];
    
    NSDictionary *arData = [SHJL objectForJsonFileName:@"home_setting"];
    
    self.dataSource = [NSDictionary dictionaryWithDictionary:arData];
    
    [self.tableView reloadData];
    return;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.dataSource.count;
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return ((NSArray*)self.dataSource[self.keys[section]]).count;
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dataInfo = self.dataSource[self.keys[indexPath.section]][indexPath.row];
    
    static NSString *cellIdentifierH = @"SHUserInfoTableViewCell"; //Head Cell
    static NSString *cellIdentifierN = @"SHSwitchTableViewCell";
    
    NSString *cellIdentifier = nil;
    
    
    SHJsonLoadType jlType = [SHJL type:dataInfo];
    if (jlType == eJL_switch) {
        cellIdentifier = cellIdentifierN;
    }
    else if(jlType==eJL_text)
    {
        cellIdentifier = cellIdentifierH;
    }
    else
    {
        cellIdentifier = cellIdentifierH;
    }
    
    SHSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] firstObject];
        
    }

    NSString *strTitle = [SHJL name:dataInfo];
    [cell.lbTitle     setText:strTitle];
    
    NSInteger tid = [SHJL tid:dataInfo];
    
    
    if (tid==1) {
        //值设置
        [cell.lbDetail  setText:self.arSP[self.nSpSel]];
    }
    else if (tid==2){
        [cell.lbDetail setText:@""];
    }else if (tid==3){
        [cell.lbDetail setText:@"中文"];
    }else if (tid>=4||tid<=6){
       
        
        [cell.swSwitch setTag:tid];
        [cell.swSwitch addTarget:self action:@selector(switchActionForValueChange:) forControlEvents:UIControlEventValueChanged];
        
        if (tid==4) {
            //设置value
            
        } else if(tid==5){
            //设置value
        }
        else if(tid==6){
            //设置value
            cell.swSwitch.on = NO;
        }
    }else{
        
        
    }
    
    
    return cell;
}

-(void)switchActionForTouch:(UISwitch*)sender
{
    NSString *appName = [YZCommon getAPPName];
    NSString *alertInfo = [NSString stringWithFormat:@"app无法更改消息通知设置,请到IOS系统下 [设置->通知->%@->开启允许通知].",appName];
    
    SHAlert(alertInfo);
    return;
}

-(void)switchActionForValueChange:(UISwitch*)sender
{
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *dataInfo = self.dataSource[self.keys[indexPath.section]][indexPath.row];
    NSInteger tid = [SHJL tid:dataInfo];
    
    if (tid==1) {
        
        PQActionSheet *sheet = [[PQActionSheet alloc] initWithTitle:@"运营商类型"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:self.arSP[0],self.arSP[1],self.arSP[2],self.arSP[3],nil];
        sheet.tag = tid;
        [sheet show];
        
    }
    else if (tid==2) {
        SHItemListTableViewController *itemListVC = [[SHItemListTableViewController alloc]init];
        itemListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:itemListVC animated:YES];
    }
    else if (tid==3)
    {
        
//        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"中文" otherButtonTitles:nil, nil];
//        [sheet showInView:self.view];
        
        PQActionSheet *sheet = [[PQActionSheet alloc] initWithTitle:@"语言设置"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"中文",nil];
        [sheet show];
        
    }
    
    return;
}

- (void)actionSheet:(PQActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"PQASheet: %ld Index:%ld", actionSheet.tag, buttonIndex);
}

@end
