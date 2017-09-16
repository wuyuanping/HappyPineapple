//
//  YPHUDHelper.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPHUDHelper.h"

static MBProgressHUD *loadingHUD;

@implementation YPHUDHelper

+ (void)showLoadding
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [self showLoaddingInView:view]; //默认显示在主窗口
}

+ (void)showLoaddingInView:(UIView *)view
{
    [self showLoaddingInView:view withMessage:@""];
}

+ (void)showLoaddingWithMessage:(NSString *)msg
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [self showLoaddingInView:view withMessage:msg];
}

+ (void)showLoaddingInView:(UIView *)view withMessage:(NSString *)msg
{
    [self showLoaddingInView:view withMessage:msg completion:nil];
}

+ (void)showLoaddingInView:(UIView *)view withMessage:(NSString *)msg completion:(void (^)())completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil == loadingHUD) {
            loadingHUD = [[MBProgressHUD alloc] initWithView:view];
        }
        loadingHUD.bezelView.color = HEXCOLOR(0xfdd115);
        loadingHUD.minShowTime = 1;
        loadingHUD.removeFromSuperViewOnHide = YES;
        loadingHUD.contentColor = [UIColor whiteColor];
        loadingHUD.animationType = MBProgressHUDAnimationZoom;
        //字太长，可能需要换行，用detail
        loadingHUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        loadingHUD.detailsLabel.text = msg;
        
        [loadingHUD hideAnimated:YES afterDelay:TimeOut];
        [loadingHUD showAnimated:YES];
        [view addSubview:loadingHUD];
        [view bringSubviewToFront:loadingHUD];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TimeOut * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}

// Tip:提示消息
+ (void)showTipMessage:(NSString *)msg
{
    [self showTipMessage:msg delay:2]; //默认延时两秒消失
}

+ (void)showTipMessage:(NSString *)msg delay:(NSTimeInterval)seconds
{
    [self showTipMessage:msg delay:seconds completion:nil];
}

+ (void)showTipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *view = [[UIApplication sharedApplication] keyWindow];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        hud.mode = MBProgressHUDModeText;
        hud.minSize = CGSizeMake((SCREEN_WIDTH-100), 40);
        hud.bezelView.backgroundColor = [UIColor whiteColor];
        hud.backgroundView.backgroundColor = HEXACOLOR(0x000000, 0.5);
        hud.detailsLabel.text = msg;
        hud.detailsLabel.textColor = HEXCOLOR(0xfdd115);
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:seconds];
        
        [view addSubview:hud];
        [view bringSubviewToFront:hud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}

//提示各种状态消息
//+ (void)showWithStatus:(NSString *)status
//{
//    [self showHUDWithMsg:status type:HUDMessageTypeInfo];
//}

+ (void)showInfoWithStatus:(NSString *)status
{
    [self showHUDWithMsg:status type:HUDMessageTypeInfo];
}

+ (void)showSuccessWithStatus:(NSString *)status
{
    [self showHUDWithMsg:status type:HUDMessageTypeSuccess];
}

+ (void)showFailedWithStatus:(NSString *)status
{
    [self showHUDWithMsg:status type:HUDMessageTypeFailed];
}

+ (void)showWarningWithStatus:(NSString *)status
{
    [self showHUDWithMsg:status type:HUDMessageTypeWaring];
}


+(void)showHUDWithMsg:(NSString *)msg type:(HUDMessageType)type
{
    [self dismiss];
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.bezelView.color = HEXCOLOR(0x099d8e);
    hud.minSize = CGSizeMake(100, 100);
    hud.minShowTime = 1;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoom;
    //字太长，可能需要换行，用detail
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = msg;
    
    hud.mode = MBProgressHUDModeCustomView;
    switch (type) {
        case HUDMessageTypeInfo: {
            UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
            infoImageView.image = [UIImage imageNamed:@"hud_info"];
            hud.customView = infoImageView;
        }
            break;
        case HUDMessageTypeWaring: {
            UIImageView *warningImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
            warningImageView.image = [UIImage imageNamed:@"hud_warning"];
            hud.customView = warningImageView;
        }
            break;
        case HUDMessageTypeFailed: {
            UIImageView *failedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
            failedImageView.image = [UIImage imageNamed:@"hud_failed"];
            hud.customView = failedImageView;
        }
            break;
        case HUDMessageTypeSuccess: {
            UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
            successImageView.image = [UIImage imageNamed:@"hud_success"];
            hud.customView = successImageView;
        }
            break;
    }
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:HUD_DELAY_TIME];
    
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
}

//隐藏HUD ?
+ (void)dismiss
{
    [loadingHUD hideAnimated:YES];
    loadingHUD = nil;
}


@end
