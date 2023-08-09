//
//  UIColor+JXTCategory.h
//  SplendidGarden
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JXTColor)

+ (instancetype)defaultBackgroundColor;
+ (instancetype)safeColor;
+ (instancetype)defaultBlackColor;
+ (instancetype)defaultGrayColor;
+ (instancetype)defaultItemColor;
+ (instancetype)defaultHighColor;
+ (instancetype)defaultLowColor;
+ (instancetype)lineColor;
+ (instancetype)destructiveColor;
+ (instancetype)randomColor;
+ (instancetype)colorWithHex:(NSUInteger)hex;
+ (instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
