//
//  UIViewController+JXTCatalog.h
//  SplendidGarden
//
//  Created by admin on 2018/8/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JXTAlert)

+(void)showDestructiveAlertWithMessage:(NSString *)message DestructiveAction:(void (^) (void))block ;
+ (void)showCommonAlertWithMessage:(NSString *)message action:(void (^) (void))block ;
+ (void)showSingleActionAlertWithMessage:(NSString *)message action:(void (^) (void))block ;
+ (void)dismissAlertController;

@end
