//
//  UIView+JXTViewController.h
//  SplendidGarden
//
//  Created by admin on 2017/10/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXTView)

@property (nonatomic, assign) CGFloat jxt_x;
@property (nonatomic, assign) CGFloat jxt_y;
@property (nonatomic, assign) CGFloat jxt_centerX;
@property (nonatomic, assign) CGFloat jxt_centerY;
@property (nonatomic, assign) CGFloat jxt_width;
@property (nonatomic, assign) CGFloat jxt_height;
@property (nonatomic, assign) CGSize  jxt_size;
@property (nonatomic, assign) CGPoint jxt_origin;

+(instancetype)lineView;

/***************************** Jamfer Add ***************************************************/
-(CGFloat)jxt_bottom;
-(CGFloat)jxt_right;

@end

@interface UIView (JXTViewController)

- (UIViewController *)controller;

@end

typedef void(^JXTHudDidHideBlock)(void);

@interface UIView (JXTHUDView)

+ (void)showActivityIndicatorViewWithString:(NSString *)tip;
+ (void)updateActivityIndicatorViewWithString:(NSString *)tip;
+ (void)dismissActivityIndicatorView;

+ (void)showHudString:(NSString *)string stayDuration:(CGFloat)stayDuration animationDuration:(CGFloat)animationDuration hudDidHide:(JXTHudDidHideBlock)block;

// --jamfer add
+ (UIViewController *)presentingVC;

@end

