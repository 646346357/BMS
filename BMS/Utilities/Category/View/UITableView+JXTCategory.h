//
//  UITableView+JXTEditView.h
//  SplendidGarden
//
//  Created by admin on 2018/1/3.
//  Copyright © 2018年 admin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UITableView (JXTEditView)

- (void)configEditVieWithImage:(UIImage *)image bottomHeight:(CGFloat)bottomHeight;

@end

@interface UITableView (JXTRefresh)

// 下拉刷新
- (void)headerRefreshWithBlock:(MJRefreshComponentRefreshingBlock)block;

// 上拉刷新
- (void)footerRefreshWithBlock:(MJRefreshComponentRefreshingBlock)block;

@end
