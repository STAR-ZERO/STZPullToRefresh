//
//  ViewController.h
//  Example
//
//  Created by Kenji Abe on 2014/04/06.
//  Copyright (c) 2014年 Kenji Abe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <STZPullToRefresh/STZPullToRefresh.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, STZPullToRefreshDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
