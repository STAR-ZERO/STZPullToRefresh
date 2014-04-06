//
//  STZPullToRefreshView.m
//
//  Created by Kenji Abe on 2014/04/05.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import "STZPullToRefreshView.h"

@interface STZPullToRefreshView ()
@property (nonatomic, assign, readwrite) BOOL isRefreshing;
@property (nonatomic, strong) UIView *refreshBarView;
@property (nonatomic, strong) NSMutableArray *refreshIndicators;
@end

@implementation STZPullToRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.refreshBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        self.progressColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];
        [self addSubview:self.refreshBarView];
    }
    return self;
}

- (void)setRefreshBarProgress:(CGFloat)progress
{
    self.refreshBarView.backgroundColor = self.progressColor;
    CGRect frame = self.refreshBarView.frame;
    CGFloat x = (self.frame.size.width / 2) - (progress / 2);
    frame.size.width = progress;
    frame.origin.x = x;
    self.refreshBarView.frame = frame;
}

- (BOOL)isProgressFull
{
    CGFloat width = self.refreshBarView.frame.size.width;
    return width > self.frame.size.width;
}

- (void)startRefresh
{
    self.isRefreshing = YES;

    [self setRefreshBarProgress:0];

    self.refreshIndicators = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < 3; i++) {
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        indicator.backgroundColor = [UIColor whiteColor];

        float delay = 0.4 * i;

        [UIView animateWithDuration:1.2 delay:delay options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionRepeat animations:^{
            CGRect frame = indicator.frame;
            frame.origin.x = self.frame.size.width;
            indicator.frame = frame;
        } completion:^(BOOL finished) {
        }];

        [self addSubview:indicator];

        [self.refreshIndicators addObject:indicator];
    }

    self.backgroundColor = self.progressColor;
}

- (void)finishRefresh
{
    self.isRefreshing = NO;

    self.backgroundColor = [UIColor clearColor];
    [self.refreshIndicators enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj removeFromSuperview];
    }];
    [self.refreshIndicators removeAllObjects];
}

@end
