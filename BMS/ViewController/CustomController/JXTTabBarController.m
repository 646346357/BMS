//
//  JXTTabBarController.m
//  锦绣田园
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTTabBarController.h"
#import "JXTRealtimeStatusController.h"
#import "JXTDynamicCurveController.h"
#import "JXTParameterSettingController.h"
#import "JXTCommandController.h"
#import "JXTMarketController.h"
#import "JXTCustomTabBar.h"

@interface JXTTabBarController ()

@end

@implementation JXTTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 利用KVC来使用自定义的tabBar
    [self setValue:[[JXTCustomTabBar alloc] init] forKey:@"tabBar"];
    [self addAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {

}


#pragma mark - Private Methods

- (void)addAllChildViewController {
    JXTRealtimeStatusController *realtimeVc = [[JXTRealtimeStatusController alloc] init];
    [self addChildViewController:realtimeVc title:@"实时状态" imageName:@"icon_tab1" selectedImage:@"icon_tab1_select"];

    JXTDynamicCurveController *curveVc = [[JXTDynamicCurveController alloc] init];
    [self addChildViewController:curveVc title:@"动态曲线" imageName:@"icon_tab2" selectedImage:@"icon_tab2_select"];

    JXTParameterSettingController *paramVc = [[JXTParameterSettingController alloc] init];
    [self addChildViewController:paramVc title:@"参数设置" imageName:@"icon_tab3" selectedImage:@"icon_tab3_select"];

    JXTCommandController *commandVc = [[JXTCommandController alloc] init];
    [self addChildViewController:commandVc title:@"控制" imageName:@"icon_tab4" selectedImage:@"icon_tab4_select"];

    JXTMarketController *marketVc = [[JXTMarketController alloc] init];
    [self addChildViewController:marketVc title:@"商城" imageName:@"icon_tab5" selectedImage:@"icon_tab5_select"];
}

- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage {
    JXTNavigationController *nav = [[JXTNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    vc.navigationItem.title = title;
    nav.tabBarItem.image = [JXT_IMAGE(imageName) imageWithRenderingMode:UIImageRenderingModeAutomatic];
    nav.tabBarItem.selectedImage = [JXT_IMAGE(selectedImage) imageWithRenderingMode:UIImageRenderingModeAutomatic];
    [self addChildViewController:nav];
}

@end
