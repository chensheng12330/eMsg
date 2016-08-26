//
//  SLYAppSettingTableViewController.m
//  xcar
//
//  Created by sherwin on 16/1/9.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#define SH_APP_Set_loc_key (@"本地相关")
#define SH_APP_Set_dev_key (@"设备相关")
#import "SLYAppSettingTableViewController.h"

#import "SHSettingTableViewCell.h"
#import "SLYWebViewController.h"

@interface SLYAppSettingTableViewController ()
@property (strong, nonatomic) NSDictionary *dataSource;
@property (nonatomic, strong) NSArray *keys;
@end

@implementation SLYAppSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self reloadData];
}

-(void) reloadData {
    
    self.keys = @[SH_APP_Set_loc_key,SH_APP_Set_dev_key];
    
    NSDictionary *arData = [SHJL objectForJsonFileName:@"app_setting_json"];
    
    self.dataSource = [NSDictionary dictionaryWithDictionary:arData];
    
    [self.tableView reloadData];
    return;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
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
        [cell.swSwitch addTarget:self action:@selector(switchActionForTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (tid==2){
        [cell.lbDetail setText:@""];
    }else if (tid==3){
        
//        if(PQLocalizedLanguage ==nil || [PQLocalizedLanguage isEqualToString:@""]) {
//            
//            [cell.lbDetail setText:PQLocalizedSring(@"appset_language_sys", @"跟随系统")];
//        }
//        
//        if([@"zh-Hans" isEqualToString:PQLocalizedLanguage]) {
//            
//            [cell.lbDetail setText:PQLocalizedSring(@"appset_language_chinese", @"中文")];
//            
//        }
//        
//        if([@"en" isEqualToString:PQLocalizedLanguage]) {
//            
//            [cell.lbDetail setText:PQLocalizedSring(@"appset_language_en",@"英文")];
//            
//        }
        
        
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
    SHAlert(@"app无法更改消息通知设置,请到IOS系统下 [设置->通知->%@->开启允许通知]");
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
    
    
    if (tid==2) { //本地存储
     
    }
    else if (tid==3)
    {
        
//        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"中文" otherButtonTitles:nil, nil];
//        [sheet showInView:self.view];
        
//        PQActionSheet *sheet = [[PQActionSheet alloc] initWithTitle:PQLocalizedSring(@"appset_language_set", @"语言设置")
//                                                           delegate:self
//                                                  cancelButtonTitle:PQLocalizedSring(@"common_cancel", @"取消")
//                                                  otherButtonTitles:PQLocalizedSring(@"appset_language_sys", @"跟随系统"),
//                                PQLocalizedSring(@"appset_language_chinese", @"中文"),
//                                PQLocalizedSring(@"appset_language_en",@"英文"),nil];
//        [sheet show];
        
    }

    return;
}

#pragma mark -UIActionSheetDelegate
//-(void)actionSheet:(PQActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        
//        PQLocalizedSet(nil);
//        
//    }
//    
//    if(buttonIndex == 1) {
//        
//        PQLocalizedSet(@"zh-Hans");
//        
//    }
//    
//    if(buttonIndex == 2) {
//        
//        PQLocalizedSet(@"en");
//    }
//    
//    if(buttonIndex == 3) {
//        
//        return;
//        
//    }
//    
//    [SHMJEXT initMJSString];
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Logout object:nil];
//    
//}

@end
