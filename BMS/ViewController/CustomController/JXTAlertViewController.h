//
//  JXTAlertViewController.h
//  BMS
//
//  Created by qinwen on 2019/4/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JXTAlertViewControllerLevel) {
    JXTAlertViewControllerSuccess,
    JXTAlertViewControllerFail,
    JXTAlertViewControllerWarning,
};

typedef void(^JXTAlertViewControllerBlock)(void);

@interface JXTAlertViewController : UIViewController

+ (instancetype)presentAlertControllerWithTitle:(NSString *)title level:(JXTAlertViewControllerLevel)level confirmBlock:(JXTAlertViewControllerBlock)block;

@end


