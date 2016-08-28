//
//  SLYUserInfoTableViewController.m
//  xcar
//
//  Created by sherwin on 16/1/9.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYUserInfoTableViewController.h"
#import "SHSettingTableViewCell.h"
#import "YZCommon.h"
#import "PQAlertView.h"
#import "SHURLConfig.h"


@interface SLYUserInfoTableViewController () <UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *dataSrouce;
@property (nonatomic,strong) NSDictionary *userInfoData;

@end

@implementation SLYUserInfoTableViewController

-(void)dealloc
{
    NSLog(@"%s------>dealloc",__func__);

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithHex:0xe6e5e5];
    
    [self loadData];
    [self requestData];

}

-(void) loadData
{
    NSString *tempData     = [[NSString alloc]  initWithContentsOfFile:SH_BundlePath(@"user_info_json",@"json") encoding:4 error:nil];
    NSMutableArray *arData = [NSString parseJSONString:tempData];
    if (arData==NULL && arData.count<1) {
        NSAssert(1, @"---> 无法加载用户信息页面静态表数据,检测user_info.json 文件是否存在&无数据。");
    }
    
    self.dataSrouce = arData;
    
    return;
}

-(void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self setUserImage];
}

-(void) setUserImage
{
    self.ivImageCell0.clipsToBounds = YES;
    self.ivImageCell0.layer.cornerRadius = self.ivImageCell0.bounds.size.width / 2;
    self.ivImageCell0.layer.borderWidth = 2;
    self.ivImageCell0.layer.borderColor = [UIColor colorWithWhite:0.788 alpha:1.000].CGColor;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSrouce.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)self.dataSrouce[section]).count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        return 70;
    }
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0 && indexPath.row==0) {
        //设置用户信息头
        NSString *avatarURL = [self.userInfoData valueForKey:@"coverPath"];
        SLYUser *user = [YZCommon sharedCommon].mUser;

        if(![avatarURL isKindOfClass:[NSNull class]]){
            
            //[self.ivImageCell0 sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:[UIImage imageNamed:@"noavatar_big"]];
            
        }
        [self.lbTitileCell0 setText:user.strUserName];
        return self.myCell0;
    }
    else if (indexPath.section== (self.dataSrouce.count-1))
    {
        return self.myCellLast;
    }
    
    
    //加载其它类型CELL
    static NSString *cellID = @"SHUserInfoTableViewCell";
    SHSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] firstObject];
    }
    
    [cell.lbTitle setText:self.dataSrouce[indexPath.section][indexPath.row]];
    
    NSInteger section = indexPath.section;
    NSInteger index   = indexPath.row;
    
    if (section==0 &&index==1) {
        //设置呢称
        NSString *nickName = [self.userInfoData valueForKey:@"nick"];
        
        if(![nickName isKindOfClass:[NSNull class]]){
            
            [cell.lbDetail setText:nickName];
            
        }
    }
    else if (section==1 && index==0)
    {
        //签名
        NSString *userSign = [self.userInfoData valueForKey:@"usersign"];
        
        if(![userSign isKindOfClass:[NSNull class]]){
            
          //  [cell.lbDetail setText:!userSign?PQLocalizedSring(@"profile_nosign", @"暂无签名"):userSign];
            
        }
        
    }
    
    return cell;
}



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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 & indexPath.row == 0) {
        
        
//        
//        PQActionSheet *actionSheet = [[PQActionSheet alloc]initWithTitle:PQLocalizedSring(@"profile_avatar_select", @"请选择一张图片作为头像")
//                                                                delegate:self
//                                                       cancelButtonTitle:PQLocalizedSring(@"common_cancel", @"取消")
//                                                       otherButtonTitles:PQLocalizedSring(@"avatar_fromalbum", @"从相册选择"),PQLocalizedSring(@"avatar_takephoto",@"拍摄一张照片"),nil];
//        
//        [actionSheet show];
//        
//        
        
    }
    
    if (indexPath.section==0 && indexPath.row==1){
        
//        PQAlertView *alertView = [[PQAlertView alloc]initWithTitle:nil
//                                                           message:PQLocalizedSring(@"profile_nick_placeholder", @"请输入新昵称")
//                                                      clickedIndex:^(NSInteger index,UIAlertView *alert) {
//                                                          
//                                                          if(index == 1){
//                                                              
//                                                              UITextField *textField = [alert textFieldAtIndex:0];
//                                                              
//                                                              if(textField.text.length >0 && textField.text.length <= 6){
//                                                                  
//                                                                                                                                [self requestChangeUserProfile:@"nick" withValue:textField.text];
//                                                                  
//                                                              }else{
//                                                                  
//                                                                  
//                                                                  UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:PQLocalizedSring(@"profile_nick_limit", @"昵称必须长度小于6且不为空!") delegate:nil cancelButtonTitle:PQLocalizedSring(@"common_ok", @"确定") otherButtonTitles:nil, nil];
//                                                                  
//                                                                  [alertView show];
//                                                                  
//                                                              }
//                                                              
//                                                              
//                                                          }
//                                                          
//                                                      
//                                                      }
//                                                              show:NO
//                                                 cancelButtonTitle:PQLocalizedSring(@"common_cancel", @"取消")
//                                                  otherButtonTitle:PQLocalizedSring(@"common_ok",@"确定")];
//        
//        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
//        UITextField *textField = [alertView textFieldAtIndex:0];
//        textField.placeholder = PQLocalizedSring(@"profile_nick_placeholder", @"请输入新昵称");
//        
//        NSString *nickName = [self.userInfoData valueForKey:@"nick"];
//        
//        if(![nickName isKindOfClass:[NSNull class]]){
//            
//            textField.text = nickName;
//            
//        }
//        
//        [alertView show];
        
    }
    
    if (indexPath.section==1 && indexPath.row==0){
        
//        PQAlertView *alertView = [[PQAlertView alloc]initWithTitle:nil
//                                                           message:PQLocalizedSring(@"profile_sign_placeholder", @"请输入新签名")
//                                                      clickedIndex:^(NSInteger index,UIAlertView *alert) {
//                                                          
//                                                          if(index == 1){
//                                                              
//                                                              UITextField *textField = [alert textFieldAtIndex:0];
//                                                              
//                                                              
//                                                              [self requestChangeUserProfile:@"usersign" withValue:textField.text];
//                                                              
//                                                              
//                                                          }
//                                                          
//                                                          
//                                                      }
//                                                              show:NO
//                                                 cancelButtonTitle:PQLocalizedSring(@"common_cancel", @"取消")
//                                                  otherButtonTitle:PQLocalizedSring(@"common_ok", @"确定")];
//        
//        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
//        UITextField *textField = [alertView textFieldAtIndex:0];
//        textField.placeholder = PQLocalizedSring(@"profile_sign_placeholder", @"请输入新签名");
//        [alertView show];
        
    }
    
    
    return;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - SH UI接口交互函数
//! 退出登陆
- (IBAction)actionLogout:(id)sender {
    
//    HdMsgBox *msgBox = [HdMsgBox sharedInstance];
//    [msgBox showHUDLoadingWithText:@"正在注销..." inView:self.view];
    
    //发送注销通知
    //[[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Logout object:nil];
    
    
}

#pragma mark - 网络请求
-(void)requestData {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    __weak typeof(self) weakSelf = self;
    
    /*
    [SLYNet requestWithMethod:@"get_user_profile"
                       params:@{}
                      success:^(NSDictionary *responseData, NSInteger code) {
                          
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                          
                          if(SLYNetworkCode_OK == code){
                          
                              weakSelf.userInfoData = responseData;
                              SLYUserDetail *userDt = [[SLYUserDetail alloc] initWithDictionary:responseData];
                              if (userDt) {
                                  COM.mUser.mUserDetail = userDt;
                              }
                              [weakSelf.tableView reloadData];
                          
                          }else {
                              
                              PQAlertView *alert = [[PQAlertView alloc]initWithTitle:nil
                                                                             message:PQLocalizedSring(@"common_req_failed", @"请求失败")
                                                                        clickedIndex:^(NSInteger index, UIAlertView *alertView) {
                                                                            
                                                                            [self actionLogout:nil];
                                                                            
                                                                            
                                                                        }
                                                                                show:NO
                                                                   cancelButtonTitle:PQLocalizedSring(@"common_ok", @"确定")
                                                                    otherButtonTitle:nil];
                              [alert show];
                            
                          }
                      
                      
                      }
     
                      failure:^(NSError *error) {
                      
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                          
                      }
     ];
    */
}

/**
 *  @brief 上传文件
 *
 *  @param data    文件数据
 *  @param success 成功返回文件地址
 *  @param fail    错误原因

-(void)uploadFile:(NSData *)data
      withSuccess:(void(^)(NSString *fileURL)) success
         withFail:(void(^)(NSError *error)) fail {
    
    NSString *urlString = [UC getUploadFileForU:COM.mUser.strUserId uTok:COM.mUser.strUserToken];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置为10秒超时
    manager.requestSerializer.timeoutInterval = 10.0f;
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",COM.mUser.strUserName];
        NSString *mimeType = @"image/jpg";
        
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:fileName
                                mimeType:mimeType];
    
    }
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSString *retcode = [responseObject valueForKey:@"retcode"];
              if([@"0" isEqualToString:retcode]) {
                  
                  NSString *imageURL = [responseObject valueForKey:@"url"];
                  
                  TMBLogInfo(@"图片上传地址:%@",imageURL);
                  
                  success([imageURL copy]);
                  
              }else {
                  
                  fail([NSError errorWithDomain:@"uploadAvatar" code:retcode.integerValue userInfo:@{@"msg":@"上传失败!"}]);
                  
              }
          
          }
     
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              fail([error copy]);
              
          }
     ];
    
    
    
}


-(void)requestChangeUserProfile:(NSString *)key withValue:(NSString *)value {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:value forKey:key];
    
    [SLYNet requestWithMethod:@"edit_user_profile"
                       params:params
                      success:^(NSDictionary *responseData, NSInteger code) {
                          
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                          
                          [weakSelf requestData];
                      
                      }
                      failure:^(NSError *error) {
                      
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                      
                      }
     ];
    
}

#pragma mark - UIActionSheetDelegate
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
//    picker.delegate = self;
//    
//    switch (buttonIndex) {
//        case 0:
//        {
//            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//            
//            [self presentViewController:picker animated:YES completion:nil];
//            
//            break;
//        }
//        case 1:
//        {
//            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//            {
//                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
//                
//                [self presentViewController:picker animated:YES completion:nil];
//                
//                
//                
//            }else
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾!"
//                                                             message:@"无法开启摄像头!"
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"确定"
//                                                   otherButtonTitles:nil, nil];
//                [alert show];
//                return;
//            }
//            break;
//        }
//        default:
//            break;
//    }
//    
//    
//}

#pragma mark - PQActionSheetDelegate

-(void)actionSheet:(PQActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0:
        {
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:nil];
            
            break;
        }
        case 1:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:picker animated:YES completion:nil];
                
                
                
            }else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:PQLocalizedSring(@"profile_sosad", @"很遗憾")
                                                             message:PQLocalizedSring(@"profile_cannot_open_camera", @"无法开启摄像头!")
                                                            delegate:nil
                                                   cancelButtonTitle:PQLocalizedSring(@"common_ok", @"确定")
                                                   otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *_photo=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __weak typeof(self) weakSelf = self;
    
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = PQLocalizedSring(@"avatar_uploading", @"正在上传头像...");
    
    //请求网络，上传头像
    [self uploadFile:UIImageJPEGRepresentation(_photo, 0.5f)
     
         withSuccess:^(NSString *fileURL) {
             
             hud.labelText = PQLocalizedSring(@"avatar_setting", @"正在设置头像...");
             
             [weakSelf requestChangeUserProfile:@"coverPath" withValue:fileURL];
             
             [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
             
         
         }
            withFail:^(NSError *error) {
                
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PQLocalizedSring(@"avatar_upload_failed", @"头像上传失败!");
                
                [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
                
            
            }
     ];
    
}
 */
@end