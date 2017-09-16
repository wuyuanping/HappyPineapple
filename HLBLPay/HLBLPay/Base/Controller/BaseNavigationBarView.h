//
//  BaseNavigationBarView.h
//  HLBLPay
//
//  此类为公共的自定义NavigationBarView,界面采用自动布局，如果需要改变控件位置，
//  请在初始化自定义导航栏后复写控件布局

//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YPNavigationBarStyle)
{
        YPNavigationBarStyleRed , //default
        YPNavigationBarStyleWhite
};

#define kSTATUS_BAR_HIGHT     20
#define kNAVIGATION_BAR_HIGHT 64


@interface BaseNavigationBarView : UIView

@property (nonatomic, readonly) YPNavigationBarStyle style;
@property (nonatomic, copy)     NSString *title;
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UIButton *leftButton;
@property (nonatomic, strong)   UIButton *rightButton;
@property (nonatomic, assign)   CGFloat barHeight;

//创建时必须进行初始化
- (instancetype)initWithFrame:(CGRect)frame style:(YPNavigationBarStyle)style;

//设置左边按钮背景图片
- (void)setLeftButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state;
//设置右边按钮背景图片
- (void)setRightButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state;

//设置状态栏高度
- (void)setBarHeight:(CGFloat)barHeight;

//设置底部线条颜色
- (void)setBottomLineColor:(UIColor *)color;
- (void)setBottomLineHidden:(BOOL)hidden;

/**
 * 设置是否隐藏右侧按钮
 *@param hidden 如果是yes,此方法会删除右侧按钮,为NO会新建一个按钮
 */
- (void)setRightButtonHidden:(BOOL)hidden;

/**
 * 设置是否隐藏左侧按钮
 *@param hidden 如果是yes,此方法会删除左侧按钮,为NO会新建一个按钮
 */
- (void)setLeftButtonHidden:(BOOL)hidden;

//设置style 初始化默认style
- (void)setStyle:(YPNavigationBarStyle)style;

//状态栏消息
- (void)showStatusMessage:(NSString *)message;
- (void)hideStatusMessage:(BOOL)hidden;


@end
