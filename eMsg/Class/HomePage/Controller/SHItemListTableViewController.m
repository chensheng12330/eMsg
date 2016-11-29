//
//  SHItemListTableViewController.m
//  eMsg
//
//  Created by sherwin.chen on 16/8/27.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "MJRefresh.h"
#import "SHItemListTableViewController.h"

@interface SHItemListTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@property (strong, nonatomic) NSArray *dataSource;


//@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UISearchController *searchController;
@property (strong, nonatomic) NSArray *filterData;
@end

@implementation SHItemListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
     //self.automaticallyAdjustsScrollViewInsets=NO;

    if (self.dataType == IL_Type_Area) {
        self.title = @"地区选择";
    }
    else{
        self.title = @"平台选择";
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createRefreshControl];
    [self createSearchBar];
    
    [self refreshAction];
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
    /*
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新…"];
    self.refreshControl.tintColor = [UIColor grayColor];
    //[self.refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl endRefreshing];
     */
}

-(void)refreshAction
{
    if (_dataType == IL_Type_Area) {
        [self getAreaDataSource];
    }
    else if (_dataType == IL_Type_Items){
        [self getItemsDataSource];
    }
}

-(void)createSearchBar
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.searchBar.delegate    = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    /*
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width
                                                                           , 44)];
    searchBar.placeholder = @"搜索";
    self.tableView.tableHeaderView = searchBar;
    //self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    //self.searchDisplayController.searchResultsDataSource = self;
    //self.searchDisplayController.searchResultsDelegate = self;
     */
    return ;
}

-(void)stopHUB
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self hideHud];
    //[self.refreshControl endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - SH 网络请求

-(void) getAreaDataSource
{
    [self showHudInView:self.view hint:@"正在加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;

    [manager GET:[UC getArea]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
             [self stopHUB];
             
             if (responseObject==NULL || responseObject.length<1) {
                 
             }
             else
             {
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:4];
                 int code = [COM getCodeFromRespString:respStr];
                 if (code==1) {
                     //过期，需要重新登陆.
                     
                     return ;
                 }
                 else if(code==2){
                     //请求失败.
                     SHAlert(@"请求失败,请您重试.");
                     return ;
                 }
            
                 self.dataSource =  [respStr componentsSeparatedByString:@"\n"];
                 [self.tableView reloadData];
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             [self stopHUB];
             
             SHAlert(@"服务器请求失败,请检测您的网络.");
             
         }
     
     ];
}



-(void) getItemsDataSource
{
    self.dataSource = [SHPlatformStore getPlatformsFromDB];
    
    if(self.dataSource==NULL)
    {
        [self showHudInView:self.view hint:@"正在加载数据..."];
        [SH_PS getPlatformList4Net:^(NSArray *list, NSError *error) {
            
            [self stopHUB];
            
            if (list) {
                
                self.dataSource = list;
                
                [self.tableView reloadData];
            }
            else
            {
                if (error.code == 1001 || error.code == 1003) {
                    SHAlert(error.userInfo[@"error"]);
                }
                else if(error.code == 1002)
                {
                    //需要重新登陆.
                }
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.isActive) {
        return self.filterData.count;
    }
    else
    {
        return self.dataSource.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (cell==NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
    }
    
    NSArray *selData = nil;
    if (self.searchController.isActive) {
        selData = self.filterData;
    }
    else{
        selData = self.dataSource;
    }
    
    
    if (_dataType == IL_Type_Area) {
        [cell.textLabel setText:selData[indexPath.row]];
    }
    else if (_dataType == IL_Type_Items){
        NSDictionary *itemInfo = selData[indexPath.row];
        [cell.textLabel setText:itemInfo[IL_ItemName]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"价格:%@",itemInfo[IL_ItemPrice]]];
    }
    
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemListWithData:requestDataType:)]) {
        
        NSArray *objAr = nil;
        if (self.searchController.isActive) {
            objAr = self.filterData;
        }
        else{
            objAr = self.dataSource;
        }
        
        NSObject *objData = nil;
        if (_dataType == IL_Type_Area) {
            objData = objAr[indexPath.row];
           
        }
        else if (_dataType == IL_Type_Items){
            objData = objAr[indexPath.row];
        }
        
        [self.delegate didSelectItemListWithData:objData requestDataType:self.dataType];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
//http://blog.csdn.net/lmf208/article/details/38345321
//http://www.cnblogs.com/lesliefang/p/3929677.html
//http://www.tuicool.com/articles/6viqEn
//http://supershll.blog.163.com/blog/static/370704362012116946365/
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    
    if (searchString.length<1) {  return ;}
    //searchString = @"美";
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.%@ CONTAINS %@",IL_ItemName,searchString];
    //NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];

    //过滤数据
    self.filterData = [NSMutableArray arrayWithArray:[self.dataSource filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.filterData = self.dataSource;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchController setActive:NO];
    self.filterData = self.dataSource;
    [self.tableView reloadData];
}


@end
