//
//  JXTOverCurrentViewController.m
//  SplendidGarden
//
//  Created by qinwen on 2017/11/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTOverCurrentViewController.h"

@interface JXTOverCurrentViewController ()<UIGestureRecognizerDelegate>

@end

@implementation JXTOverCurrentViewController

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        _viewBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        _viewBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        _viewBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:.2 animations:^{
        self.view.backgroundColor = self->_viewBackgroundColor;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Override Method

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    __weak typeof(self) weakSelf = self;
    [super dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf.overCurrentDelegate respondsToSelector:@selector(overCurrentViewControllerDidDissmiss)]) {
            [strongSelf.overCurrentDelegate overCurrentViewControllerDidDissmiss];
        }
    }];
}

#pragma mark - Action Method

- (void)tap:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self.view) {
        return YES;
    }
    
    return NO;
}

@end
