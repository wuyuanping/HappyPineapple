//
//  BaseTabBarController.h
//  HLBLPay

//  自定义TabBarController

//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kTabBarHeight = 49;

@interface BaseTabBarController : UITabBarController

/**
 * 初始化Tabbar
 *@prama normalImages:默认状态下item图片数组
 *@prama selectedImages:选中状态下item图片数组
 *@prama bgImage:tabbar背景图片
 */
- (instancetype)initWithTabBarItemsWithNormalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages titles:(NSArray *)titles backgroudImage:(UIImage *)bgImage;
/**
 * 根据VC的index在tabbarItem上添加新消息数量标示
 @param number 消息数量(-1：显示小点，大于99:显示99+)
 @param index tabbar item 索引
 */
- (void)showBadgeViewWithNumber:(NSInteger)number atIndex:(NSInteger)index;

/**
 * 隐藏消息标示
 @param index : tabbar item 索引
 */
-(void)hideBadgeView:(int)index;

//显示或隐藏tabbar
-(void)showTabBarControllerOrHide:(BOOL)show;
-(void)showTabBarControllerOrHide:(BOOL)show WithDuraton:(float)duration;

//显示或隐藏黑幕
-(void)showBlackView:(BOOL)show;

@end

@interface YPTabBarItemButton : UIButton

@property (nonatomic,strong) UILabel *badgeNumberLabel; //显示消息

@end





