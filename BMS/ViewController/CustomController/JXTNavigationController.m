//
//  JXTNavigationController.m
//  SplendidGarden
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTNavigationController.h"

@interface JXTNavigationController () {
    
}

@end

@implementation JXTNavigationController

#pragma mark - Life Cycle

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
        UIImage *image = [UIImage imageWithColor:[UIColor defaultItemColor]];
        [self.navigationBar setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor lineColor]]];
        
        if (@available(iOS 15.0, *)) {
            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
            appearance.titleTextAttributes = self.navigationBar.titleTextAttributes;
            [appearance setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch]];
            [appearance setShadowImage:[UIImage imageWithColor:[UIColor lineColor]]];
            appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            self.navigationBar.standardAppearance = appearance;
            self.navigationBar.scrollEdgeAppearance = appearance;
        }
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
