//
//  UITableView+JXTEditView.m
//  SplendidGarden
//
//  Created by admin on 2018/1/3.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UITableView+JXTCategory.h"

@implementation UITableView (JXTEditView)

#pragma mark - Public Method

- (void)configEditVieWithImage:(UIImage *)image bottomHeight:(CGFloat)bottomHeight{
    // 获取选项按钮的reference
    if (JXT_iOS11_OR_LATER)
    {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] > 0) {
                subview.backgroundColor = [UIColor whiteColor];
                // 和iOS 10的按钮顺序相反
                UIButton *button = [subview.subviews firstObject];
                [button setBackgroundImage:image forState:UIControlStateNormal];
            }
        }
    }
}

@end

@implementation UITableView (JXTRefresh)

// 下拉刷新
- (void)headerRefreshWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshNormalHeader *mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    mj_header.automaticallyChangeAlpha = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
//    mj_header.stateLabel.textColor = [UIColor whiteColor];
//    mj_header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.mj_header = mj_header;
}

// 上拉刷新
- (void)footerRefreshWithBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    mj_footer.automaticallyHidden = YES;
//    mj_footer.stateLabel.textColor = [UIColor whiteColor];
//    mj_footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.mj_footer = mj_footer;
}

@end
