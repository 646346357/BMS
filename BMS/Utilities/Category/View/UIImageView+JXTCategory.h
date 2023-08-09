//
//  UIImageView+JXTAnimation.h
//  SplendidGarden
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JXTAnimationCompleted)(void);

@interface UIImageView (JXTAnimation)

+ (void)rotate360DegreeWithImage:(UIImage *)image duration:(float)duration completed:(JXTAnimationCompleted)block;

@end
