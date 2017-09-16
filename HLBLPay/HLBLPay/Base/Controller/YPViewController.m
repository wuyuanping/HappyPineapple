//
//  YPViewController.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPViewController.h"

@interface YPViewController ()

@end

@implementation YPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    // todo:??
    if (self.navBar) {
        [self.navBar.leftButton addTarget:self action:@selector(navBarBackItemButtonClickedEvent:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
}

// 如果控制器加了自定义导航条，点击导航条左键返回
- (void)navBarBackItemButtonClickedEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
