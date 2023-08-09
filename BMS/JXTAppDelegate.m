//
//  AppDelegate.m
//  BMS
//
//  Created by admin on 2018/11/30.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JXTAppDelegate.h"
#import "JXTConnectController.h"
#import "JXTNavigationController.h"

@interface JXTAppDelegate ()

@end

@implementation JXTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    self.window = window;
    //避免多个button同时响应
    [[UIButton appearance] setExclusiveTouch:YES];
    
    //日志初始化
    [JXTDocumentManager sharedInstance];
//    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
//    NSString *logsDirectory = [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject] stringByAppendingPathComponent:@"Logs"];
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:logsDirectory]]; // File Logger
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    [DDLog addLogger:fileLogger];
//
    //设置SVProgressHUD
    [SVProgressHUD setSuccessImage:JXT_IMAGE(@"icon_success")];
    [SVProgressHUD setErrorImage:JXT_IMAGE(@"icon_fail")];
    [SVProgressHUD setInfoImage:JXT_IMAGE(@"icon_warning")];
    [SVProgressHUD setFont:[UIFont fontOfSize_16]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.6]];
    
    JXTNavigationController *nav = [[JXTNavigationController alloc] initWithRootViewController:[[JXTConnectController alloc] init]];
    [window setRootViewController:nav];
    [NSThread sleepForTimeInterval:1];
    
    return YES;
}

//iOS9之后
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"file"] && [[url.absoluteString lowercaseString] hasSuffix:@"bin"]) {
        BOOL isSuccess = [[JXTDocumentManager sharedInstance] saveBinFile:url];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (isSuccess) {
                [UIView showHudString:@"bin文件保存成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            } else {
                [UIView showHudString:@"bin文件保存失败" stayDuration:1 animationDuration:0 hudDidHide:nil];
            }
        });
        
        return isSuccess;
    }
    
    return NO;
}

//iOS9之前
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqualToString:@"file"] && [[url.absoluteString lowercaseString] hasSuffix:@"bin"]) {
        BOOL isSuccess = [[JXTDocumentManager sharedInstance] saveBinFile:url];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (isSuccess) {
                [UIView showHudString:@"bin文件保存成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            } else {
                [UIView showHudString:@"bin文件保存失败" stayDuration:1 animationDuration:0 hudDidHide:nil];
            }
        });
        
        return isSuccess;
    }
    
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[JXTBluetooth sharedInstance] cancelConnect];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(JXTAppDelegate *)shareAppDelegate{
    return (JXTAppDelegate *) [UIApplication sharedApplication].delegate;
}

@end
