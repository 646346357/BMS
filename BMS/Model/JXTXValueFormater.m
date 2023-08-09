//
//  JXTXValueFormater.m
//  BMS
//
//  Created by qinwen on 2019/3/24.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTXValueFormater.h"

@implementation JXTXValueFormater

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:value]];

    return currentDateStr;
}

@end
