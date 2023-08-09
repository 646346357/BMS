//
//  WKWebView+JXTCache.m
//  SplendidGarden
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "WKWebView+JXTCategory.h"

@implementation WKWebView (JXTCache)

#pragma mark - Public Method

+ (void)clearWebCache {
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                        WKWebsiteDataTypeDiskCache,
                                                        
                                                        //WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        
                                                        WKWebsiteDataTypeMemoryCache,
                                                        
                                                        //WKWebsiteDataTypeLocalStorage,
                                                        
                                                        //WKWebsiteDataTypeCookies,
                                                        
                                                        //WKWebsiteDataTypeSessionStorage,
                                                        
                                                        //WKWebsiteDataTypeIndexedDBDatabases,
                                                        
                                                        //WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSError *errors;
        
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

@end
