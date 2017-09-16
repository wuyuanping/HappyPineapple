//
//  BaseNavigationController.m
//  HLBLPay
//
//  Created by 吴园平 on 15/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak BaseNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf; //必须遵守代理协议才能做代理
        self.delegate = weakSelf;
    }
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //先统一取消系统提供的右滑返回手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        //到根控制器的时候不可以把滑动返回手势打开，否则会出bug
        if(self.viewControllers.count!=1)
        {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
