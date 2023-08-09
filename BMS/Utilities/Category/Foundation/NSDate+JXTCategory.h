//
//  NSDate+JXTDate.h
//  SplendidGarden
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JXTDate)

- (NSString *)year_month_day_weekString;
- (NSString *)month_day_weekString;
- (NSString *)year_month_dayString;

+ (NSString *)year_month_dayStringWithString:(NSString *)string;

/** 用来判断时间的大小,FTime是第一个时间是否大于STime第二个时间,时间格式仅仅支持HHmmss */
+(BOOL)compareTimeIsGreaterFTime:(NSString*)ftime STime:(NSString*)stime;

+ (NSString *)getChineseTime:(NSString*)time;
+ (NSString *)getCurrentTime;
+ (NSString *)getCurrentMonth;
+ (NSString *)getCurrentDate;
+ (NSInteger)getFirstDateInfoMonth:(NSString*)month;
+ (NSInteger)getNumberOfDaysInMonth:(NSString*)month;

@end
