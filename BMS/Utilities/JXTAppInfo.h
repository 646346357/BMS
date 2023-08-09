//
//  JXTAppInfo.h
//  SplendidGarden
//
//  Created by admin on 2018/11/26.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTAppInfo : NSObject

//获取版本号
+ (NSString*)getLocalAppVersion;

//获取BundleID
+ (NSString*)getBundleID;

//获取app的名字
+ (NSString*)getAppName;

@end


