//
//  SHItemListTableViewController.m
//  eMsg
//
//  Created by sherwin.chen on 16/8/27.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SHItemListTableViewController.h"

@interface SHItemListTableViewController ()

@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation SHItemListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self reloadData];
}

-(void) reloadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer.timeoutInterval = 15.0f;

    [manager GET:[UC getArea]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             if (responseObject==NULL || responseObject.length<1) {
                 
             }
             else
             {
                 NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                 
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:enc];
                 self.dataSource =  [respStr componentsSeparatedByString:@"\n"];
                 [self.tableView reloadData];
             }
             

             [self hideHud];
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             [self hideHud];
             
             SHAlert(@"服务器请求失败,请检测您的网络.");
             
         }
     
     ];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (cell==NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    // Configure the cell...
    [cell.textLabel setText:self.dataSource[indexPath.row]];
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
