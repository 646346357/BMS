//
//  UIImageView+JXTAnimation.m
//  SplendidGarden
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIImageView+JXTCategory.h"

@implementation UIImageView (JXTAnimation)

#pragma mark - Public Method

+ (void)rotate360DegreeWithImage:(UIImage *)image duration:(float)duration completed:(JXTAnimationCompleted)block {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = keyWindow.center;
    [keyWindow addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(-M_PI_2, 0.0, 0.0, 1.0)];

    animation.duration = .2;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    
    [imageView.layer addAnimation:animation forKey:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView.layer removeAllAnimations];
        [imageView removeFromSuperview];
        if (block) {
            block();
        }
    });
}

@end
