//
//  STZPullToRefresh.h
//
//  Created by Kenji Abe on 2014/04/05.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STZPullToRefreshView.h"

@protocol STZPullToRefreshDelegate <NSObject>
- (void)pullToRefreshDidStart;
@end

@interface STZPullToRefresh : NSObject <UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<STZPullToRefreshDelegate> delegate;

- (id)initWithTableView:(UITableView *)tableView refreshView:(STZPullToRefreshView *)refreshView;
- (id)initWithTableView:(UITableView *)tableView refreshView:(STZPullToRefreshView *)refreshView tableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate;

- (void)startRefresh;

- (void)finishRefresh;

@end
