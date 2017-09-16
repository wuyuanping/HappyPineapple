//
//  YPRefreshHeader.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshHeader.h"

@implementation YPRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultRefreshHeaderStyle];
    }
    return self;
}

- (void)setDefaultRefreshHeaderStyle
{
    /*
        NSArray *idleImages = @[[UIImage imageNamed:@"refresh01"],
                                [UIImage imageNamed:@"refresh02"]];
        //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshing)];
        //设置普通状态的动画图片
        [self setImages:idleImages duration:1.0f/4.0f forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [self setImages:idleImages duration:1.0f/4.0f forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [self setImages:idleImages duration:1.0f/4.0f forState:MJRefreshStateRefreshing];
    */
    
    // 设置文字
    [self setTitle:@"下拉刷新(^_^)" forState:MJRefreshStateIdle];
    [self setTitle:@"放开人家嘛(＞﹏＜)" forState:MJRefreshStatePulling];
    [self setTitle:@"正在全力刷新中....." forState:MJRefreshStateRefreshing];
    [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_centerX).offset(-100);
        make.bottom.equalTo(@-1);
    }];
    
    [self.lastUpdatedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.leading.equalTo(self.gifView.mas_trailing).offset(10);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lastUpdatedTimeLabel);
        make.bottom.equalTo(self.lastUpdatedTimeLabel.mas_top).offset(-5);
    }];
    
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:11];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    
    // 设置颜色
    self.stateLabel.textColor = HEXACOLOR(0x535353, 0.5);
    self.lastUpdatedTimeLabel.textColor = HEXACOLOR(0x535353, 0.5);

}


@end
