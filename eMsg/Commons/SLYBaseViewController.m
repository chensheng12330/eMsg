//
//  SLYBaseViewController.m
//  xcar
//
//  Created by yingzhuo on 16/1/8.
//  Copyright © 2016年 深蓝蕴. All rights reserved.
//

#import "SLYBaseViewController.h"

@interface SLYBaseViewController ()

@end

@implementation SLYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
static bool isFirstLoad = YES;
static bool isFirstAppear = YES;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.baseScrollView.contentOffset = CGPointMake(0, 0);
    //return;
    if ([UIDevice currentDevice].systemVersion.floatValue <9.0) {
        return;
    }
    
    if (isFirstLoad == NO) {
        [self.view setNeedsUpdateConstraints];
        
        // update constraints now so we can animate the change
        [self.view updateConstraintsIfNeeded];
        
        [self.view layoutIfNeeded];
        isFirstAppear = NO;
    }else{
        isFirstLoad = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
