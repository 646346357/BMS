//
//  UIViewController+JXTCatalog.m
//  SplendidGarden
//
//  Created by admin on 2018/8/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIViewController+JXTCategory.h"
#import "JXTTabBarController.h"
#import "JXTNavigationController.h"

@implementation UIViewController (JXTAlert)

+ (void)showDestructiveAlertWithMessage:(NSString *)message DestructiveAction:(void (^) (void))block {
    [self showAlertWithMessage:message style:UIAlertActionStyleDestructive showCancle:YES action:block];
}

+ (void)showCommonAlertWithMessage:(NSString *)message action:(void (^)(void))block {
    [self showAlertWithMessage:message style:UIAlertActionStyleDefault showCancle:YES action:block];
}

+ (void)showSingleActionAlertWithMessage:(NSString *)message action:(void (^)(void))block {
    [self showAlertWithMessage:message style:UIAlertActionStyleDefault showCancle:NO action:block];
}

+ (void)showAlertWithMessage:(NSString *)message style:(UIAlertActionStyle)style showCancle:(BOOL)showCancel action:(void (^)(void))block {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:style handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }];
    [alert addAction:okAction];
    if (showCancel) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)dismissAlertController {
    if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
