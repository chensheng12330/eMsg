//
//  SLYFullScreenViewController.m
//  xcar
//
//  Created by 黄盼青 on 16/1/28.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYFullScreenViewController.h"

@interface SLYFullScreenViewController ()

@end

@implementation SLYFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
