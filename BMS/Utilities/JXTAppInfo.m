//
//  JXTAppInfo.m
//  SplendidGarden
//
//  Created by admin on 2018/11/26.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JXTAppInfo.h"

@implementation JXTAppInfo

//获取版本号
+ (NSString*)getLocalAppVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取BundleID
+ (NSString*)getBundleID {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

//获取app的名字
+ (NSString*)getAppName {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

@end
