//
//  ASRegisterViewController.m
//  iseeplus
//
//  Created by yingzhuo on 15/12/15.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "ASRegisterViewController.h"
#import "UIButton+CountDown.h"

@interface ASRegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITextField *usernameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *captchaField;

@property (nonatomic,strong) UIButton *captchaBtn;

@property (nonatomic,assign) NSInteger smscodeID;

@end

@implementation ASRegisterViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(closeVC)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:tap];
    

    [self configUI];
  
}

-(void)closeVC {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)resignTextField {
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)configUI
{
    self.usernameField = [[UITextField alloc] init];
    self.usernameField.borderStyle = UITextBorderStyleNone;
    self.usernameField.placeholder = @"请输入手机号码";
    
    
    self.usernameField.layer.borderWidth = 0.7f;
    self.usernameField.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    self.usernameField.layer.cornerRadius = 20.0f;
    self.usernameField.tintColor = [UIColor blackColor];
    self.usernameField.textAlignment = NSTextAlignmentCenter;
    self.usernameField.delegate = self;
    self.usernameField.returnKeyType = UIReturnKeyDone;
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.usernameField];
    
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.borderStyle = UITextBorderStyleNone;
//    self.passwordField.placeholder = @"请输入密码";
    if(self.isRegister){
        self.passwordField.placeholder = @"请输入密码";
    }else {
        self.passwordField.placeholder = @"请输入新密码";
    }
    
    
    self.passwordField.tintColor = [UIColor orangeColor];
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.layer.borderWidth = 0.7f;
    self.passwordField.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    self.passwordField.layer.cornerRadius = 20.0f;
    self.passwordField.tintColor = [UIColor blackColor];
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.delegate = self;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    [self.view addSubview:self.passwordField];
    

    
    self.captchaField = [[UITextField alloc] init];
    self.captchaField.borderStyle = UITextBorderStyleNone;
    self.captchaField.placeholder = @"验证码";
    self.captchaField.tintColor = [UIColor orangeColor];
//    self.captchaField.secureTextEntry = YES;
    
    self.captchaField.layer.borderWidth = 0.7f;
    self.captchaField.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    self.captchaField.layer.cornerRadius = 20.0f;
    self.captchaField.tintColor = [UIColor blackColor];
    self.captchaField.textAlignment = NSTextAlignmentCenter;
    self.captchaField.delegate = self;
    self.captchaField.keyboardType = UIKeyboardTypeNumberPad;
    self.captchaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:self.captchaField];
    
    
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(124.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(50.0f);
    }];
    
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameField.mas_bottom).with.offset(15.0f);
        make.left.equalTo(self.usernameField);
        make.right.equalTo(self.usernameField);
        make.height.equalTo(self.usernameField);
    }];
    
    
    [self.captchaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom).with.offset(15.0f);
        make.left.equalTo(self.passwordField);
//        make.right.equalTo(self.passwordField);
        make.height.equalTo(self.usernameField);
    }];
    
    self.captchaBtn = [[UIButton alloc]init];
    self.captchaBtn.layer.cornerRadius = 20.0f;
    [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.captchaBtn.backgroundColor = [UIColor colorWithRed:0.878 green:0.373 blue:0.380 alpha:1.000];
    [self.view addSubview:self.captchaBtn];
    [self.captchaBtn addTarget:self action:@selector(didCaptchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.captchaField.mas_right).with.offset(5.0f);
        make.right.equalTo(self.usernameField);
        make.height.equalTo(self.captchaField);
        make.top.equalTo(self.captchaField);
        make.width.mas_equalTo(120.0f);
        
    }];
    
    
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"提  交" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor whiteColor];
    registerBtn.layer.borderColor = [UIColor colorWithRed:0.878 green:0.373 blue:0.380 alpha:1.000].CGColor;
    registerBtn.layer.borderWidth = 0.7f;
    registerBtn.layer.cornerRadius = 20.0f;
    [registerBtn setTitleColor:[UIColor colorWithRed:0.878 green:0.373 blue:0.380 alpha:1.000] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.captchaField.mas_bottom).with.offset(25.0f);
        make.left.equalTo(self.captchaField);
        make.right.equalTo(self.usernameField);
        make.height.mas_equalTo(50.0f);
    }];
    
    return;
}

#pragma mark - 事件处理

-(void)registerAction
{
    [self.view endEditing:YES];
    
    
    
    if([self.usernameField.text isEqual: @""]){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请输入电话号码"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    
    if([self.passwordField.text isEqual: @""]){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请输入密码"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    
    if([self.captchaField.text isEqual: @""]){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请输入验证码"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    
    
    
    
    NSString *method = @"register";
    if(!self.isRegister){
        method = @"forget_password";
    }
    
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在发送请求...";
    
    
    [self requestAccountWithMethod:method
                      withPhoneNum:self.usernameField.text
                           withPwd:self.passwordField.text
                       withSMSCode:self.captchaField.text
                     withSMSCodeID:self.smscodeID
                         withBlock:^(BOOL success, NSString *msg) {
                             
                             
                             if(success){
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     
                                     hud.labelText = @"操作成功!";
                                     [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
                                     
                                     [self.navigationController popViewControllerAnimated:YES];
                                     
                                     
                                     
                                 });
                                 
                             }else {
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     
                                     hud.labelText = msg;
                                     [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
                                     
                                     
                                     
                                 });
                                 
                             }
        
    }];
    

}

-(void)didCaptchBtnClicked:(UIButton *)sender {
    
    
    if([_usernameField.text isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请输入手机号码"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertView show];

        
    }else {
        
        
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"正在发送验证码...";
        
        
        [self requestSMSCatpcha:_usernameField.text
                      withBlock:^(BOOL isSuccess, NSInteger smscode) {
                          
                          if(isSuccess){
                              
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  hud.labelText = @"发送成功!";
                                  [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
                                  
                                  self.smscodeID = smscode;
                                  
                                  
                              });
                              
                              
                              
                          }else{
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  hud.labelText = @"发送失败!";
                                  [hud performSelector:@selector(hide:) withObject:nil afterDelay:0.7f];
                                  
                                  
                              });
                              
                              
                              
                          }
                          
            
        }];
        
    }
    
}

#pragma mark - 网络请求

/**
 *  @brief 请求短信验证码
 *
 *  @param phoneNum 电话号码
 *  @param block    回调块
 */
-(void)requestSMSCatpcha:(NSString *)phoneNum
               withBlock:(void(^)(BOOL isSuccess,NSInteger smscode))block {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params addEntriesFromDictionary:[UC getBaseParams]];
    
    [params setValue:@"get_sms_code" forKey:@"method"];
    [params setValue:phoneNum forKey:@"username"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置为10秒超时
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[UC getHost]
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary *responseData = responseObject;
             
             // 请求成功
             if([COM isOK:responseData]==0) {
                 
                 NSInteger code = [[responseData objectForKey:@"smscode_id"] integerValue];
                 
                 block(YES,code);
                 
                 [self.captchaBtn startWithTime:60
                                          title:@"获取验证码"
                                 countDownTitle:@""
                                      mainColor:[UIColor colorWithRed:0.878 green:0.373 blue:0.380 alpha:1.000]
                                     countColor:[UIColor colorWithWhite:0.725 alpha:1.000]];
                 
                 
             }else {
                 
                 block(NO,0);
                 
             }
             
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             block(NO,0);
             
             
         }
     ];
    
}

/**
 *  @brief 请求注册账号/修改密码
 *
 *  @param method    register或forget_password
 *  @param phoneNum  电话号码
 *  @param password  密码
 *  @param smsCode   短信验证码
 *  @param smsCodeID 验证码ID
 *  @param block     回调块
 */
-(void)requestAccountWithMethod:(NSString *)method
                   withPhoneNum:(NSString *)phoneNum
                        withPwd:(NSString *)password
                    withSMSCode:(NSString *)smsCode
                  withSMSCodeID:(NSInteger)smsCodeID withBlock:(void(^)(BOOL success,NSString *msg))block{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params addEntriesFromDictionary:[UC getBaseParams]];
    
    [params setValue:method forKey:@"method"];
    [params setValue:phoneNum forKey:@"username"];
    [params setValue:password forKey:@"password"];
    [params setValue:smsCode forKey:@"smscode"];
    [params setValue:[NSNumber numberWithInteger:smsCodeID] forKey:@"smscode_id"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置为10秒超时
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[UC getHost]
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary *responseData = responseObject;
             
             // 请求成功
             if([COM isOK:responseData]==0) {
                 
                 
                 block(YES,[responseData objectForKey:@"msg"]);
                 
                 
             }else {
                 
                 block(NO,[responseData objectForKey:@"msg"]);
                 
             }
             
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
             block(NO,[error description]);
             
         }
     ];
    
    
}



#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

-(BOOL)checkMobilePhoneNumber:(NSString *)phoneNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phoneNumber];
    BOOL res2 = [regextestcm evaluateWithObject:phoneNumber];
    BOOL res3 = [regextestcu evaluateWithObject:phoneNumber];
    BOOL res4 = [regextestct evaluateWithObject:phoneNumber];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark GET/SET
-(void)setIsRegister:(BOOL)isRegister {
    
    _isRegister = isRegister;
    
    if(isRegister) {
        
        self.title = @"新用户注册";
        
    }else {
        
        self.title = @"修改密码";
        
    }
    
}

@end
