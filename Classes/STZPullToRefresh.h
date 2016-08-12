//
//  STZPullToRefresh.h
//
//  Created by Kenji Abe on 2014/04/05.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STZPullToRefreshView.h"

/**
 `STZPullToRefreshDelegate` protocol defines the methods a delegate of a `STZPullToRefresh`.
 */
@protocol STZPullToRefreshDelegate <NSObject>

/**
 Sent to the delegate at the start of refresh animation.
 */
- (void)pullToRefreshDidStart;
@end

/**
 `STZPullToRefresh` is management view and delegate.
 
 UI Component like ActionBar-PullToRefresh of Android for iOS.
 */
@interface STZPullToRefresh : NSObject <UIScrollViewDelegate, UIGestureRecognizerDelegate>

///---------------------
/// @name Setting Properties
///---------------------

/**
 The receiver’s delegate
 */
@property (nonatomic, weak) id<STZPullToRefreshDelegate> delegate;

///---------------------
/// @name Initialization
///---------------------

/**
 Create and return instance of not necessary to UIScrollViewDelegate. Will not be processed for UIScrollViewDelegate.
 
 @param scrollView UIScrollView that should be subject to the pull to refresh.
 @param refreshView View for refresh animation.
 */
- (id)initWithScrollView:(UIScrollView *)scrollView refreshView:(STZPullToRefreshView *)refreshView;

/**
 Create and return instance for processing UIScrollViewDelegate.

 @param scrollView UIScrollView that should be subject to the pull to refresh.
 @param refreshView View for refresh animation.
 @param scrollViewDelegate Receiver for processing UIScrollViewDelegate.
 */
- (id)initWithScrollView:(UIScrollView *)scrollView refreshView:(STZPullToRefreshView *)refreshView scrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate;

///---------------------
/// @name Refresh Animation
///---------------------

/**
 Start refresh animation manually. Send to the delegate after the start.
 */
- (void)startRefresh;

/**
 Stop refresh animation.
 */
- (void)finishRefresh;

@end
