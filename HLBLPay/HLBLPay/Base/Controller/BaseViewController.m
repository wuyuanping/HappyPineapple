//
//  BaseViewController.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseViewController.h"
//#import "BaseNavigationBarView.h"
#import "BaseTabBarController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置隐藏默认导航栏
    self.navigationController.navigationBarHidden = YES;
    //设置当push View Controller时，隐藏底部tabbar
    self.hidesBottomBarWhenPushed = YES;
    self.extendedLayoutIncludesOpaqueBars = YES; //包含不透明Bar
    //忽略导航高度，从最顶部开始算
    self.navigationController.navigationBar.translucent = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - lifeCircle

- (void)viewWillAppear:(BOOL)animated
{
    //友盟页面统计
    // [MobClick beginLogPageView:NSStringFromClass([self class])];
    // self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;
    
    // 这里也放一份是为了防止其他人创建的ViewCtrl打开系统NavigationBar 设置隐藏默认导航栏
    self.navigationController.navigationBarHidden = YES;
    if(self.navigationController.viewControllers.count > 1) {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:NO]; //隐藏tabBar
    } else {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:YES]; //显示tabBar
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //友盟页面统计
    // [MobClick endLogPageView:NSStringFromClass([self class])];
}


- (BaseTabBarController *)getTabBarViewCtrl
{
    return (BaseTabBarController *)self.tabBarController;
}

/**
 * 设置导航栏布局
 */
- (void)setupNavigationBarLayout
{
    if (!_navBar) {
      BaseNavigationBarView  *Bar = [[BaseNavigationBarView alloc] initWithFrame:CGRectZero style:YPNavigationBarStyleWhite];
        _navBar = Bar;
    }
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@(kNAVIGATION_BAR_HIGHT));
    }];
}

#pragma mark - Getter
- (BaseNavigationBarView *)navBar
{
    if (nil == _navBar) {
        _navBar = [[BaseNavigationBarView alloc] initWithFrame:CGRectZero
                                                       style:YPNavigationBarStyleWhite];
    }
    return _navBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
