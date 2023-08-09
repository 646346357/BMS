//
//  NSArray+JXTLog.m
//  SplendidGarden
//
//  Created by admin on 2018/5/4.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NSArray+JXTCategory.h"

@implementation NSArray (JXTLog)

-(NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
