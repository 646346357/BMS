//
//  JXTBaseResponderController.m
//  HKRidingClub
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JXTBaseResponderController.h"

@interface JXTBaseResponderController ()<UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat originY;

@end

@implementation JXTBaseResponderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self == viewController) {
        self.originY = self.view.frame.origin.y;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self an_subscribeKeyboardShowHideWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            UITextField *currentResponder = [UIResponder jxt_currentFirstResponder];
            if (![currentResponder isKindOfClass:[UITextField class]]) {
                return;
            }
            
            CGRect currentResponderFrame = [weakSelf.view convertRect:currentResponder.frame fromView:currentResponder.superview];
            if (currentResponderFrame.origin.y + currentResponderFrame.size.height > weakSelf.view.jxt_height - keyboardRect.size.height) {
                CGFloat difference = (currentResponderFrame.origin.y + currentResponderFrame.size.height) - (weakSelf.view.jxt_height - keyboardRect.size.height);
                CGRect rect = weakSelf.view.frame;
                rect.origin.y = weakSelf.originY - difference - 10;
                weakSelf.view.frame = rect;
            }
        } else {
            CGRect rect = weakSelf.view.frame;
            rect.origin.y = weakSelf.originY;
            weakSelf.view.frame = rect;
        }
    } completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboardShowHide];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [UIResponder jxt_resignFirstResponder];
}

@end
