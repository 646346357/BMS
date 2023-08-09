//
//  UISearchBar+Category.m
//  SplendidGarden
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UISearchBar+JXTCategory.h"

#define IS_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9

@implementation UISearchBar (FMAdd)

#pragma mark - Public Method

- (void)fm_setTextFont:(UIFont *)font {
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)fm_setTextColor:(UIColor *)textColor {
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)fm_setCancelButtonTitle:(NSString *)title {
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

- (void)fm_setCancelButtonFont:(UIFont *)font {
    NSDictionary *textAttr = @{NSFontAttributeName : font};
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }
}

@end

