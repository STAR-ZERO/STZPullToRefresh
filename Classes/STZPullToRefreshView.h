//
//  STZPullToRefreshView.h
//
//  Created by Kenji Abe on 2014/04/05.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STZPullToRefreshView : UIView

@property (nonatomic, assign, readonly) BOOL isRefreshing;

@property (nonatomic, strong) UIColor *progressColor;

- (void)setRefreshBarProgress:(CGFloat)progress;

- (BOOL)isProgressFull;

- (void)startRefresh;

- (void)finishRefresh;

@end
