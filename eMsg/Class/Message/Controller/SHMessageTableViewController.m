//
//  SHItemListTableViewController.m
//  eMsg
//
//  Created by sherwin.chen on 16/8/27.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "MJRefresh.h"
#import "SHMessageTableViewCell.h"
#import "SHMessageTableViewController.h"

@interface SHMessageTableViewController ()

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SHMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
     //self.automaticallyAdjustsScrollViewInsets=NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createRefreshControl];
    
    [self refreshAction];
    //1监听消息通知 [Home发过来的]
    //2加载本地 消息存储文件数据.
    
    //self.dataSource = @[@"1",@"2"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - SH 视图创建

-(void)createRefreshControl
{
    __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        ////[weakSelf requestNetworkData];
        [self refreshAction];
    }];
    
    return;
}

-(void)refreshAction
{
    [self getItemsDataSource];
}

-(void)stopHUB
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self hideHud];
    //[self.refreshControl endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - SH 网络请求



-(void) getItemsDataSource
{
    [self showHudInView:self.view hint:@"正在加载数据..."];
    
    self.dataSource = (NSArray*)[SH_MR_Msg queryMsgWithPhoneNum:COM.mUser.strUserName];

    [self stopHUB];
    
    [self.tableView reloadData];
    return;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHMessageTableViewCell"];
    
    if (cell==NULL) {
         cell =  (SHMessageTableViewCell*)[[NSBundle mainBundle] loadNibNamed:@"SHMessageTableViewCell" owner:nil options:nil].firstObject;
        //cell.reuseIdentifier = @"SHMessageTableViewCell";
    }
    

    [cell setCellWithShowMsgInfo:self.dataSource[indexPath.row]];
    
    // Configure the cell...
    
    return cell;
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
    // Navigation logic may go here, for example:
    // Create the next view controller.

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
