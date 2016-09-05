//
//  SLYAppSettingTableViewController.m
//  xcar
//
//  Created by sherwin on 16/1/9.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#define SH_APP_Set_loc_key (@"小号属性")
#define SH_APP_Set_dev_key (@"小号列表")
#define SH_APP_Set_sev_key (@"小号服务")

#import "SHHomeTableViewController.h"
#import "SHSettingTableViewCell.h"
#import "PQActionSheet.h"
#import "SHItemListTableViewController.h"

@interface SHHomeTableViewController ()<PQActionSheetDelegate,ItemListDelegate>
@property (strong, nonatomic) NSDictionary *dataSource;
@property (nonatomic, strong) NSArray *keys;

@property (nonatomic,strong) NSArray *arSP;// 运营商列表
@property (nonatomic, assign) NSInteger nSpSel;

@property (nonatomic, strong) NSString *strArea; //地区

@property (nonatomic, strong) NSDictionary *dtPlatform;
@end

@implementation SHHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arSP = @[@"[全部]",@"[移动]",@"[联通]",@"[电信]"];
    self.nSpSel = 0;
    
    self.strArea = @"全国";
    self.dtPlatform = nil;
    
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
    
    self.keys = @[SH_APP_Set_loc_key,SH_APP_Set_sev_key,SH_APP_Set_dev_key];
    
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
    NSInteger tid = [SHJL tid:dataInfo];
    
    if (tid == 4) {
        return  self.myCell1;
    }
    else if(tid ==5)
    {
        return _myCell2;
    }
    
    
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
    
    
    
    
    if (tid==1) {
        //值设置
        [cell.lbDetail  setText:self.arSP[self.nSpSel]];
    }
    else if (tid==2){
        [cell.lbDetail setText:self.strArea];
    }else if (tid==3){
        if (self.dtPlatform) {
            [cell.lbDetail setText:self.dtPlatform[IL_ItemName]];
        }
        else{
            [cell.lbDetail setText:@"未选"];
        }
        
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
        itemListVC.dataType = IL_Type_Area;
        [self.navigationController pushViewController:itemListVC animated:YES];
    }
    else if (tid==3)
    {
        SHItemListTableViewController *itemListVC = [[SHItemListTableViewController alloc]init];
        itemListVC.hidesBottomBarWhenPushed = YES;
        itemListVC.dataType = IL_Type_Items;
        itemListVC.delegate = self;
        [self.navigationController pushViewController:itemListVC animated:YES];
        
    }
    
    return;
}

- (void)actionSheet:(PQActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex>self.arSP.count) { return; }
    
    self.nSpSel = buttonIndex;
    
    SHSettingTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.lbDetail setText:self.arSP[buttonIndex]];
    
    NSLog(@"PQASheet: %ld Index:%ld", actionSheet.tag, buttonIndex);
}

-(void) didSelectItemListWithData:(NSObject*) data requestDataType:(RequestDataType) reqType
{
    //NSLog(@"%@",data);
    if (reqType == IL_Type_Area) {
        SHSettingTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        self.strArea = (NSString *)data;
        [cell.lbDetail setText:self.strArea];
    }
    else if (reqType == IL_Type_Items){
        
        SHSettingTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        self.dtPlatform = (NSDictionary*)data;
        [cell.lbDetail setText:self.dtPlatform[IL_ItemName]];
    }
}

- (IBAction)actionGetPhoneNum:(UIButton *)sender {
 
    if (self.dtPlatform == NULL) {
        SHAlert(@"请选择需要注册的平台.");
        return;
    }
    
    [self getPhoneNum];
    
    return;
}


-(void) getPhoneNum
{
    
    [self showHudInView:self.view hint:@"正在获取电话号码..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    
    [manager GET:[UC getPhoneNumForToken:COM.mUser.strUserToken itemID:self.dtPlatform[@"IL_ItemID"] phoneType:self.nSpSel]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
             [self  hideHud];
             
             if (responseObject==NULL || responseObject.length<1) {
                 
             }
             else
             {
                 NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                 
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:enc];
                 
                 //错误处理
                 //False:Session 过期
                 
                 if ([[respStr substringToIndex:4] isEqualToString:@"False"]) {
                     
                 }
                 else{
                     
                 }
                 
                 NSArray *arPhoneList =  [respStr componentsSeparatedByString:@";"];
                 
                 //@{@"phone":@"13112345678",@"time":@"2015-08-26 15:36:33",@"itemName":@"嗒嗒巴士"}
                 [self.tableView reloadData];
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             [self hideHud];
             
             SHAlert(@"服务器请求失败,请检测您的网络.");
             
         }
     
     ];
}

@end
