//
//  UIView+YP.h
//  HLBLPay
//
//  Created by 吴园平 on 15/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YP)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property CGSize size;

- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action;
- (void)removeAllSubviews;
//动画效果
+ (void)showTheApplauseInView:(UIView *)view image:(UIImage *)image;



@end
