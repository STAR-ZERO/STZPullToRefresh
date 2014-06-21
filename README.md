# STZPullToRefresh

[![Version](http://cocoapod-badges.herokuapp.com/v/STZPullToRefresh/badge.png)](http://cocoadocs.org/docsets/STZPullToRefresh)
[![Platform](http://cocoapod-badges.herokuapp.com/p/STZPullToRefresh/badge.png)](http://cocoadocs.org/docsets/STZPullToRefresh)

UI Component like ActionBar-PullToRefresh of Android for iOS.

![Screenshot](https://raw.github.com/STAR-ZERO/STZPullToRefresh/master/screenshot.gif)

## Requirements

* iOS6.0 or later
* ARC

## Installation

STZPullToRefresh is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "STZPullToRefresh"

## Usage

```objc
#import <STZPullToRefresh/STZPullToRefresh.h>
```

```objc
// Create refresh view
STZPullToRefreshView *refreshView = [[STZPullToRefreshView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 3)];
[self.view addSubview:refreshView];

// Setup PullToRefresh
self.pullToRefresh = [[STZPullToRefresh alloc] initWithTableView:self.tableView
                                                     refreshView:refreshView
                                               tableViewDelegate:self];
self.tableView.delegate = self.pullToRefresh;
self.pullToRefresh.delegate = self;   // STZPullToRefreshDelegate
```

see Example directory project.

## Author

Kenji Abe, kenji@star-zero.com

## License

STZPullToRefresh is available under the MIT license. See the LICENSE file for more info.

