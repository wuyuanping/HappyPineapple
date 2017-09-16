//
//  BaseNavigationBarView.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseNavigationBarView.h"

@interface BaseNavigationBarView ()
{
    UIView *_statusBarView;     //状态栏背景View
    UILabel *_statusMessageLabel;    //显示状态栏消息
    UIView *_bottomLine;
}
//成员变量，系统不提供setter和getter，效率高

@end


@implementation BaseNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame
{
   //  默认导航条背景为红色
   return  [self initWithFrame:frame style:YPNavigationBarStyleRed];
}

- (instancetype)initWithFrame:(CGRect)frame style:(YPNavigationBarStyle)style
{
    if (frame.size.height <= 20) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, kNAVIGATION_BAR_HIGHT);
    }
    _barHeight = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        self.style = style;
    }
    return self;
}

#pragma mark - 创建子View
- (void)createSubViews
{
    //默认navigationBar背景
    self.backgroundColor = HEXCOLOR(0xFF498C);
    //创建状态栏
    [self createStatusBar];
    //创建标题
    [self createTitleLabel];
    //创建左侧按钮
    [self createLeftButton];
    //创建右侧按钮
    [self createRightButton];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _barHeight-1, SCREEN_WIDTH, 1)];
    _bottomLine.backgroundColor = HEXCOLOR(0xEAEAEA);
    [self addSubview:_bottomLine];
}

- (void)createStatusBar
{
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectZero];
        _statusBarView.backgroundColor = HEXCOLOR(0xFF498C);
        [self addSubview:_statusBarView];
    }
    [_statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(@(kSTATUS_BAR_HIGHT));
        make.width.equalTo(@(self.frame.size.width));
    }];
}

- (void)createTitleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
    }
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18.0];
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusBarView.mas_bottom);
        make.centerX.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH - 80));
        make.height.equalTo(@(_barHeight - kSTATUS_BAR_HIGHT));
    }];
}

- (void)createLeftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectZero;
       [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       _rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
       _rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
       [self addSubview:_leftButton];
    }
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.centerY.equalTo(_titleLabel);
        make.width.and.height.equalTo(@44);
    }];
}

- (void)createRightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectZero;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightButton];
    }
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-5);
        make.centerY.equalTo(_titleLabel);
        make.width.and.height.equalTo(@44);
    }];
}

#pragma mark - Setter
- (void)setStyle:(YPNavigationBarStyle)style
{
    _style = style;
    if (YPNavigationBarStyleRed == style) {
        //do nothing,Becase The view init with red style
        //设置状态栏风格为白色文字
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _bottomLine.backgroundColor = HEXCOLOR(0xFF498C);
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    }else{ //白色导航条
        _bottomLine.backgroundColor = HEXCOLOR(0xFF498C);
        self.backgroundColor = [UIColor whiteColor];
        _statusBarView.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = HEXCOLOR(0x898989);
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        // 设置状态栏风格为黑色文字
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setLeftButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state
{
    [_leftButton setImage:bgImage forState:state];
}

- (void)setRightButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state
{
    [_rightButton setImage:bgImage forState:state];
}

- (void)setBottomLineColor:(UIColor *)color
{
    _bottomLine.backgroundColor = color;
}

- (void)setBottomLineHidden:(BOOL)hidden
{
    _bottomLine.hidden = hidden;
}

// 是否隐藏右侧按钮
- (void)setRightButtonHidden:(BOOL)hidden
{
    if (hidden) {
        _rightButton.hidden = hidden;
        _rightButton = nil;
    }else{
        [self createRightButton];
        _rightButton.hidden = hidden;
    }
}

// 是否隐藏左侧按钮
- (void)setLeftButtonHidden:(BOOL)hidden
{
    if (hidden) {
        _leftButton.hidden = hidden;
        _leftButton  = nil;
    }else{
        [self createLeftButton];
        _leftButton.hidden = hidden;
    }
}

//显示状态栏消息(此时不显示状态栏)
-(void)showStatusMessage:(NSString *)message
{
    if (!_statusMessageLabel) {
        _statusMessageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusMessageLabel.font = [UIFont systemFontOfSize:11.0f];
        UIColor *textColor = _style == YPNavigationBarStyleRed ? HEXCOLOR(0xffffff) : HEXCOLOR(0xff498c);
        _statusMessageLabel.textColor = textColor;
        [_statusBarView addSubview:_statusMessageLabel];
    }
    //显示状态栏消息
    [self hideStatusMessage:NO];
}

- (void)hideStatusMessage:(BOOL)hidden
{
    if (hidden) {
        //显示系统状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:!hidden withAnimation:YES];
    }else{
        //隐藏系统状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:!hidden withAnimation:YES];
    }
    //状态栏消息是否隐藏
    _statusMessageLabel.hidden = hidden;
}


@end
