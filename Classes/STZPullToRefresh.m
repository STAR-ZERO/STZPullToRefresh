//
//  STZPullToRefresh.m
//
//  Created by Kenji Abe on 2014/04/05.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import "STZPullToRefresh.h"

@interface STZPullToRefresh ()
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) id scrollViewProxyDelegate;

@property (nonatomic, strong) STZPullToRefreshView *refreshView;

@property (nonatomic, assign) BOOL isScrollTopPosition;
@property (nonatomic, assign) BOOL isScrollDragging;
@property (nonatomic, assign) CGFloat scrollingMax;

@end

@implementation STZPullToRefresh

static CGFloat const kPregoressWeight = 1.2;

- (id)initWithScrollView:(UIScrollView *)scrollView refreshView:(STZPullToRefreshView *)refreshView
{
    return [self initWithScrollView:scrollView refreshView:refreshView scrollViewDelegate:nil];
}

- (id)initWithScrollView:(UIScrollView *)scrollView refreshView:(STZPullToRefreshView *)refreshView scrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate
{
    self = [super init];
    if (self) {
        self.scrollViewProxyDelegate = scrollViewDelegate;

        self.scrollView = scrollView;
        //self.scrollView.bounces = NO;

        self.isScrollTopPosition = YES;
        self.isScrollDragging = NO;

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.delegate = self;
        [self.scrollView addGestureRecognizer:pan];

        self.refreshView = refreshView;
    }

    return self;
}

- (void)startRefresh
{
    if (self.delegate) {
        [self.delegate pullToRefreshDidStart];
    }

    [self.refreshView startRefresh];
}

- (void)finishRefresh
{
    [self.refreshView finishRefresh];
}

#pragma mark UIPanGestureRecognizer
- (void)panAction:(UIPanGestureRecognizer *)sender
{
    CGPoint location = [sender translationInView:self.scrollView];

    if ([self.refreshView isRefreshing]) {
        return;
    }

    if (location.y > 0 && self.isScrollTopPosition && (self.isScrollDragging || self.scrollView.contentSize.height <= self.scrollView.bounds.size.height)) {
        [self.refreshView setRefreshBarProgress:location.y * kPregoressWeight];
        if (self.scrollingMax < location.y) {
            self.scrollingMax = location.y;
        }

        if (self.scrollingMax - 10 > location.y) {
            self.isScrollDragging = NO;
            [self.refreshView setRefreshBarProgress:0];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if ([self.refreshView isProgressFull]) {
            [self startRefresh];
        }
        
        self.isScrollDragging = NO;
        [self.refreshView setRefreshBarProgress:0];
    }
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - UIScrollViewDelegate <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.scrollViewProxyDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewProxyDelegate scrollViewDidScroll:scrollView];
    }

    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;

    if (offset > 0) {
        self.isScrollTopPosition = NO;
        [self.refreshView setRefreshBarProgress:0];

       // scrollView.bounces = YES;

    } else if (offset <= 0) {
        self.isScrollTopPosition = YES;

        //scrollView.bounces = NO;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.scrollViewProxyDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.scrollViewProxyDelegate scrollViewDidScrollToTop:scrollView];
    }

    self.isScrollTopPosition = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.scrollViewProxyDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollViewProxyDelegate scrollViewWillBeginDragging:scrollView];
    }

    self.isScrollDragging = YES;
    self.scrollingMax = 0;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.scrollViewProxyDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewProxyDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }

    return;
    if ([self.refreshView isProgressFull]) {
        [self startRefresh];
    }

    self.isScrollDragging = NO;
    [self.refreshView setRefreshBarProgress:0];

}

#pragma mark - Method Forwarding
- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.scrollViewProxyDelegate respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([self.scrollViewProxyDelegate respondsToSelector:aSelector]) {
        return [(id) self.scrollViewProxyDelegate methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.scrollViewProxyDelegate respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self.scrollViewProxyDelegate];
    }
}

@end
