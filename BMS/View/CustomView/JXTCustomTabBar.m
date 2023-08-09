//
//  JXTCustomTabBar.m
//  SplendidGarden
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTCustomTabBar.h"

@implementation JXTCustomTabBar

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = JXT_HEX_COLOR(0x008aff);
        self.translucent = NO;
        self.backgroundImage = JXT_IMAGE(@"tabbar_bg");
    }
    
    return self;
}

#pragma mark - Override Method

- (void)layoutSubviews {
    [super layoutSubviews];
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barItemWidth = barWidth / tabBarButtonArray.count + 1;
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        frame.origin.x = idx * barItemWidth;
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
}

@end
