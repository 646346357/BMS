//
//  NSDictionary+JXTJson.m
//  SplendidGarden
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NSDictionary+JXTCategory.h"

@implementation NSDictionary (JXTJson)

#pragma mark - Public Method

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        JXTLogError(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

@end


@implementation NSDictionary (JXTLog)

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)descriptionWithLocale:(id)locale{
    
    if (![self count]) {
        return @"";
    }
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;
    
}

@end
