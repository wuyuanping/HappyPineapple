//
//  BaseTabBarController.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@property (nonatomic, strong) UIView *separateLine;//tabBar顶部的分割线（颜色是动态变化的）
@property (nonatomic, strong) UIImageView *tabBarView;//自定义的tabbar底板
//@property (nonatomic, strong) UIImageView *badgeView;//显示有未读新消息的提示
@property (nonatomic, strong) UIView *blackView;//黑幕
@property (nonatomic, strong) NSMutableArray *tabBarItems;//tabbar上的items

@end

@implementation BaseTabBarController

#pragma mark - LifeCircle

- (instancetype)init
{
    if (self = [super init]) {
        //隐藏tabBar
        self.tabBar.hidden = YES;
        [self.tabBar removeFromSuperview];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    _tabBarItems = [[NSMutableArray alloc] initWithCapacity:5];
}

- (instancetype)initWithTabBarItemsWithNormalImages:(NSArray *)normalImages
                                     selectedImages:(NSArray *)selectedImages
                                             titles:(NSArray *)titles
                                     backgroudImage:(UIImage *)bgImage
{
    if (self = [super init]) {
        //自定义tabBar视图
        _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTabBarHeight, SCREEN_WIDTH, kTabBarHeight)];
        _tabBarView.userInteractionEnabled = YES;
        //添加毛玻璃效果
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _tabBarView.width,_tabBarView.height)];
        [_tabBarView addSubview:toolBar];
        //设置背景
//        if(bgImage) {
//            _tabBarView.image = bgImage;
//            _tabBarView.backgroundColor = [UIColor clearColor];
//        } else {
//            _tabBarView.backgroundColor = HEXACOLOR(0xfafafa, 0.9);
//        }
        [self.view addSubview:_tabBarView];
        
        //设置tabBar上的item
        for (int i =0; i < normalImages.count; i++) {
            //初始化按键，默认选中第一个
            YPTabBarItemButton *item = [YPTabBarItemButton buttonWithType:UIButtonTypeCustom];
            item.frame = CGRectMake(i*(SCREEN_WIDTH/normalImages.count), 0, SCREEN_WIDTH/normalImages.count, kTabBarHeight);
            
            //本地提供图片
//            UIImage *normalImage = [UIImage imageNamed:normalImages[i]];
//            UIImage *selectedImage = [UIImage imageNamed:selectedImages[i]];
//            [item setImage:normalImage forState:UIControlStateNormal];
//            [item setImage:normalImage forState:UIControlStateHighlighted];
//            [item setImage:selectedImage forState:UIControlStateSelected];
            //服务器远程提供图片地址
            NSURL *normalImageUrl = [NSURL URLWithString:normalImages[i]];
            NSURL *selectedImageUrl = [NSURL URLWithString:selectedImages[i]];
            [item sd_setImageWithURL:normalImageUrl forState:UIControlStateNormal];
            [item sd_setImageWithURL:normalImageUrl forState:UIControlStateHighlighted];
            [item sd_setImageWithURL:selectedImageUrl forState:UIControlStateSelected];
            
            item.backgroundColor = [UIColor clearColor];
            [item setTitle:titles[i] forState:UIControlStateNormal];
            [item setTitleColor:HEXCOLOR(0x606060) forState:UIControlStateNormal];
            [item setTitleColor:HEXCOLOR(0x606060) forState:UIControlStateHighlighted];
            [item setTitleColor:HEXCOLOR(0xff498c) forState:UIControlStateSelected];
            item.titleLabel.font = [UIFont systemFontOfSize:10.0f];
            
            // 调整item内部图片和文字位置
            CGSize iconSize = CGSizeMake(30, 30);
            CGFloat imageLeftAndRight = (item.width-iconSize.width)/2.0;
            item.imageEdgeInsets = UIEdgeInsetsMake(5, imageLeftAndRight, 15, imageLeftAndRight);
            item.titleEdgeInsets = UIEdgeInsetsMake(5 + iconSize.height, -15, 5, 15);
            
            [item addTarget:self action:@selector(changeSelectedVC:) forControlEvents:UIControlEventTouchUpInside];
            
            [_tabBarView addSubview:item];
            [_tabBarItems addObject:item];
        }
        //初始化分割线
        _separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _separateLine.backgroundColor = HEXCOLOR(0xe2e2e2);
        [_tabBarView addSubview:_separateLine];
        //黑幕
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTabBarHeight)];
        _blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
        [_tabBarView addSubview:_blackView];
        _blackView.hidden = YES;
        
    }
    return self;
}

#pragma mark - changeControler
- (void)changeSelectedVC:(YPTabBarItemButton *)itemBtn
{
    self.selectedIndex = [_tabBarItems indexOfObject:itemBtn];
}

#pragma mark - 重写父类方法
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //取消上次选中item效果
    NSUInteger lastIndex = (self.selectedIndex < [_tabBarItems count] && self.selectedIndex!= NSIntegerMin -1) ? self.selectedIndex : 0;
    YPTabBarItemButton *lastItem = [_tabBarItems objectAtIndex:lastIndex];
    lastItem.selected = NO;
    //选中当前item
    [super setSelectedIndex:selectedIndex];
    //添加当前item选中效果
    if (selectedIndex < [_tabBarItems count]) {
        YPTabBarItemButton *item = [_tabBarItems objectAtIndex:selectedIndex];
        item.selected = YES;
    }
    
}

#pragma mark - show or hide Tabbar
- (void)showTabBarControllerOrHide:(BOOL)show
{
    [self showTabBarControllerOrHide:show WithDuraton:0.2];
}

- (void)showTabBarControllerOrHide:(BOOL)show WithDuraton:(float)duration
{
    if (show) {
        [UIView animateWithDuration:duration animations:^{
            _tabBarView.top = SCREEN_HEIGHT - kTabBarHeight;
        } completion:nil];
    }else{
        [UIView animateWithDuration:duration animations:^{
            _tabBarView.top = SCREEN_HEIGHT;
        } completion:nil];
    }
}

#pragma mark - show or hide blackView
- (void)showBlackView:(BOOL)show
{
    _blackView.hidden = show;
}

#pragma mark - Show badge number View
- (void)showBadgeViewWithNumber:(NSInteger)number atIndex:(NSInteger)index
{
    YPTabBarItemButton *item = [_tabBarItems objectAtIndex:index];
    if (number <= 0) {
        item.badgeNumberLabel.hidden = YES;
        return;
    }
    
    if (!item.badgeNumberLabel) {
        UILabel *badgeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(item.width/2+8, item.top+5, 14, 14)];
        badgeNumberLabel.textColor = [UIColor whiteColor];
        badgeNumberLabel.font = [UIFont systemFontOfSize:10.0f];
        badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        badgeNumberLabel.layer.cornerRadius = 7;
        badgeNumberLabel.layer.masksToBounds = YES;
        badgeNumberLabel.backgroundColor = [UIColor redColor];
        [item addSubview:badgeNumberLabel];
        item.badgeNumberLabel = badgeNumberLabel;
    }
    NSString *numStr = [NSString stringWithFormat:@"%ld",(long)number];
    if (number > 99) {
        numStr = @"99+";
    }
    item.badgeNumberLabel.text = numStr;
    
    if (number >= 10) {
        CGSize size = [item.badgeNumberLabel sizeThatFits:CGSizeZero];
        item.badgeNumberLabel.width = size.width + 5;
    } else if (number == -1) {
        //小圆点
        item.badgeNumberLabel.size = CGSizeMake(6, 6);
        item.badgeNumberLabel.layer.cornerRadius = 3.0f;
        item.badgeNumberLabel.text = @"";
    }
    
    //消息全部都使用小点表示
//    item.badgeNumberLabel.size = CGSizeMake(7, 7);
//    item.badgeNumberLabel.layer.cornerRadius = 3.5f;
//    item.badgeNumberLabel.text = @"";
    
    item.badgeNumberLabel.hidden = NO;
}

- (void)hideBadgeView:(int)index
{
    YPTabBarItemButton *item = [_tabBarItems objectAtIndex:index];
    item.badgeNumberLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end


@implementation YPTabBarItemButton

@end
