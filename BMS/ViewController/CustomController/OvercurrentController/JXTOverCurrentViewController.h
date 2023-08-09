//
//  JXTOverCurrentViewController.h
//  SplendidGarden
//
//  Created by qinwen on 2017/11/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXTOverCurrentViewControllerDelegate <NSObject>

- (void)overCurrentViewControllerDidDissmiss;

@end

@interface JXTOverCurrentViewController : UIViewController

@property (nonatomic, strong) UIColor *viewBackgroundColor;
@property (nonatomic, weak) id<JXTOverCurrentViewControllerDelegate> overCurrentDelegate;

@end
