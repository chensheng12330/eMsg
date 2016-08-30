//
//  ASLoginViewController.m
//  iseeplus
//
//  Created by 黄盼青 on 15/11/24.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "ASLoginViewController.h"
#import "ASMainViewController.h"

#import "ASRegisterViewController.h"


@interface ASLoginViewController () <UITextFieldDelegate,UIAlertViewDelegate>


@property (strong,nonatomic) UIButton *loginBtn;

@property (strong,nonatomic) UIButton *registerBtn;


@end

@implementation ASLoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为背景View增加Tap手势
    UITapGestureRecognizer *tapResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:tapResign];
    
    
    //初始化导航栏标题
    [self installNavigation];
    
    
    //初始化Logo
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[YZCommon getAPPIconName]]];
    [self.view addSubview:logoView];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);;
        make.top.equalTo(self.view).with.offset(88.0f);
    }];
    
    //初始化用户名Field
    _userNameField = [[UITextField alloc]init];
    [_userNameField setPlaceholder:@"请输入您的账号名"];
    _userNameField.layer.borderWidth = 0.7f;
    _userNameField.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    _userNameField.layer.cornerRadius = 20.0f;
    _userNameField.tintColor = [UIColor orangeColor];
    _userNameField.delegate = self;
    _userNameField.textAlignment = NSTextAlignmentCenter;
    _userNameField.leftViewMode = UITextFieldViewModeAlways;
    _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoView.mas_bottom).with.offset(20.0f);
        make.left.equalTo(self.view).with.offset(10.0f);
        make.right.equalTo(self.view).with.offset(-10.0f);
        make.height.mas_equalTo(50.0f);
    }];
    
    //初始化密码Field
    _pwdField = [[UITextField alloc]init];
    [_pwdField setPlaceholder:@"请输入您的密码"];
    _pwdField.layer.borderWidth = 0.7f;
    _pwdField.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    _pwdField.layer.cornerRadius = 20.0f;
    _pwdField.secureTextEntry = YES;
    _pwdField.tintColor = [UIColor orangeColor];
    _pwdField.textAlignment = NSTextAlignmentCenter;
    _pwdField.leftViewMode = UITextFieldViewModeAlways;
    _pwdField.delegate = self;
    _pwdField.returnKeyType = UIReturnKeyDone;
    _pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameField.mas_bottom).with.offset(10.0f);
        make.left.equalTo(_userNameField);
        make.right.equalTo(_userNameField);
        make.height.equalTo(_userNameField);
    }];
    
    
    //初始化登陆按钮
    _loginBtn = [[UIButton alloc]init];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[PQUtil imageWithUIColor:AS_COLOR_MAINBTN] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[PQUtil imageWithUIColor:AS_COLOR_MAINBTN_LIGHT] forState:UIControlStateHighlighted];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
    _loginBtn.layer.cornerRadius = 20.0f;
    _loginBtn.clipsToBounds = YES;
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdField.mas_bottom).with.offset(10.0f);
        make.left.equalTo(_userNameField);
        make.right.equalTo(_userNameField);
        make.height.equalTo(_userNameField);
    }];
    
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPasswordBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordBtn];
    
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(5.0f);
        make.right.equalTo(self.view).with.offset(-20.0f);
        make.size.mas_equalTo(CGSizeMake(80.0f, 40.0f));
    }];
    
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registerBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registerBtn.titleLabel setTextAlignment:NSTextAlignmentRight] ;
    [_registerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPasswordBtn);
        make.right.equalTo(forgetPasswordBtn.mas_left).offset(-20.0f);
        make.height.mas_equalTo(40.0f);
    }];
    //加载账号信息
    [self loadAccountFromCoreData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.878 green:0.184 blue:0.208 alpha:1.000];
//    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
}


#pragma mark - 初始化

//! 初始化导航栏
-(void)installNavigation{
    
    NSString *appName = [YZCommon getAPPName];
    
    UILabel *naviTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [naviTitle setTextColor:[UIColor whiteColor]];
    [naviTitle setFont:[UIFont boldSystemFontOfSize:19.0f]];
    [naviTitle setText:appName];
    [naviTitle setTextAlignment:NSTextAlignmentCenter];
    
    self.navigationItem.titleView = naviTitle;
    
    return;
}


#pragma mark - 手势操作
-(void)resignKeyboard{

    [self.view endEditing:YES];
}

#pragma mark - 事件处理
-(void)loginBtnClicked:(id)sender{
    
    [self saveAccountToCoreData];
    
    if([@"" isEqualToString:_userNameField.text]
       || [@"" isEqualToString:_pwdField.text]){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"请输入用户名和密码!"
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"确定", nil];
        
        [alertView show];
        return;
        
    }
    
    [self showHudInView:self.view hint:@"正在登陆..."];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer.acceptableContentTypes =
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.requestSerializer.timeoutInterval = 10.0f;
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[UC getLoginForUsr:_userNameField.text P:_pwdField.text]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable responseObject) {
             
             [self hideHud];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             
             if (responseObject == NULL || responseObject.length<1) {
                 SHAlert(@"数据异常,请您重新登陆.");
             }
             else{
                 
                 NSString *respStr = [[NSString alloc] initWithData:responseObject encoding:4];
                 
                 COM.mUser = [[SLYUser alloc] initWithIniString:respStr];
                 COM.mUser.strName =_userNameField.text;
                 COM.mUser.strUserPwd=_pwdField.text;
                 
                 //登陆成功，发送消息通知.
                 [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             [self hideHud];
             
             SHAlert(@"服务器请求失败,请检测您的网络.");
             
         }
     
     ];
}



-(void)registerBtnClicked:(UIButton *)button
{
    [self.view endEditing:YES];
    ASRegisterViewController *registerVC = [[ASRegisterViewController alloc] init];
    registerVC.isRegister = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)forgetPasswordBtnClicked:(UIButton *)button
{
    ASRegisterViewController *forgetVC = [[ASRegisterViewController alloc]init];
    forgetVC.isRegister = NO;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 其他

/**
 *  隐藏HUD界面
 */
-(void)hideHud{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
}

#pragma mark -UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.view endEditing:YES];
        [self showHudInView:self.view hint:@"正在登陆..."];
        //[SH_VOIP loginVoIPWithUserName:self.userNameField.text password:self.pwdField.text domain:[alertView textFieldAtIndex:0].text ];
    }
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _userNameField) {
        self.pwdField.text = @"";
    }
    return YES;
}


#pragma mark - 数据库操作
/**
 *  从数据库中加载用户名和密码
 */
-(void)loadAccountFromCoreData {
    
//    self.userNameField.text = @"13548583211";
//    self.pwdField.text=@"123456";
    //    ASAccount *account = [ASAccount MR_findFirst];
    //
    //    if(account){
    //        _userNameField.text = account.username;
    //        _pwdField.text = account.password;
    //    }
    
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    self.userNameField.text = username;
    self.pwdField.text = password;
    
}

/**
 *  保存当前用户名密码到数据库
 */
-(void)saveAccountToCoreData {
    
    /*
     ASAccount *account = [ASAccount MR_findFirst];
     
     if(account == nil){
     account = [ASAccount MR_createEntity];
     }
     
     account.username = _userNameField.text;
     account.password = _pwdField.text;
     
     [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
     */
    
    [[NSUserDefaults standardUserDefaults] setValue:self.userNameField.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setValue:self.pwdField.text forKey:@"password"];
    
}

@end
