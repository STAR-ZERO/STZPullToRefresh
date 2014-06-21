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
@interface STZPullToRefresh : NSObject <UITableViewDelegate, UIGestureRecognizerDelegate>

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
 Create and return instance of not necessary to UITableViewDelegate. Will not be processed for UITableViewDelegate.
 
 @param tableView UITableView that should be subject to the pull to refresh.
 @param refreshView View for refresh animation.
 */
- (id)initWithTableView:(UITableView *)tableView refreshView:(STZPullToRefreshView *)refreshView;

/**
 Create and return instance for processing UITableViewDelegate.

 @param tableView UITableView that should be subject to the pull to refresh.
 @param refreshView View for refresh animation.
 @param tableViewDelegate Receiver for processing UITableViewDelegate.
 */
- (id)initWithTableView:(UITableView *)tableView refreshView:(STZPullToRefreshView *)refreshView tableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate;

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
