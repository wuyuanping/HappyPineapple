//
//  BaseViewController.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 基础控制器：提供设置白色导航栏  + 智能隐藏bottomBar

#import <UIKit/UIKit.h>
#import "BaseNavigationBarView.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) BaseNavigationBarView *navBar;

/**
 * 设置导航栏布局
 */
- (void)setupNavigationBarLayout;

@end
