//
//  UIColor+JXTCategory.m
//  SplendidGarden
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIColor+JXTCategory.h"

@implementation UIColor (JXTColor)

#pragma mark - Public Method

+ (instancetype)defaultBackgroundColor {
    return [UIColor colorWithHex:0xf6f6f6];
}

+ (instancetype)safeColor {
    return [UIColor colorWithHex:0x58e520];
}

+ (instancetype)defaultBlackColor {
    return [UIColor colorWithHex:0x222222];
}

+ (instancetype)defaultGrayColor {
    return [UIColor colorWithHex:0x666666];
}

+ (instancetype)defaultItemColor {
    return [UIColor colorWithHex:0x008aff];
}

+ (instancetype)defaultHighColor {
    return JXT_HEX_COLOR(0x3d1515);
}

+ (instancetype)defaultLowColor {
    return [UIColor defaultItemColor];
}

+ (instancetype)lineColor {
    return [UIColor colorWithHex:0xcbcbcb];
}

+ (instancetype)destructiveColor {
    return [UIColor redColor];
}

+ (instancetype)randomColor {
    return [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
}

+ (instancetype)colorWithHex:(NSUInteger)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    CGFloat redColor = hex / 256 / 256 /255.0;
    CGFloat greenColor = hex / 256 % 256 /255.0;
    CGFloat blueColor = hex % 256 % 256 /255.0;
    return [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:alpha];
}

@end

