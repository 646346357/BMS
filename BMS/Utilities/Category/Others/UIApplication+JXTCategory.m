//
//  UIApplication+JXTApplication.m
//  SplendidGarden
//
//  Created by admin on 2018/1/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIApplication+JXTCategory.h"

@implementation UIApplication (JXTApplication)

#pragma mark - Public Method

+ (void)callWithWithOutRemindAndNumber:(NSString *)number {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
