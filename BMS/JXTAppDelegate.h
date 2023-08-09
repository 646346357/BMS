//
//  AppDelegate.h
//  BMS
//
//  Created by admin on 2018/11/30.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(JXTAppDelegate *)shareAppDelegate;

@end

