//
//  SLYWebViewController.m
//  xcar
//
//  Created by sherwin on 16/1/14.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYWebViewController.h"

@interface SLYWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;
@end

@implementation SLYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mWebView.backgroundColor  = [UIColor lightGrayColor];
    [self loadUrl];
}

-(void) loadUrl
{
    NSURL *url = [NSURL URLWithString:self.strReqUrl];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    [self.mWebView loadRequest:req];
    
   // [self showHudInView:self.view hint:PQLocalizedSring(@"browser_loading", @"正在加载中...")];
    return;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self hideHud];
    //SHAlert(PQLocalizedSring(@"browser_load_failed", @"加载失败,请您再重试一下."));
}
@end
