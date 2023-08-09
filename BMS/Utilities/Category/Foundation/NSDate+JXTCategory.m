//
//  NSDate+JXTDate.m
//  SplendidGarden
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NSDate+JXTCategory.h"

@implementation NSDate (JXTDate)

#pragma mark - Public Method

- (NSString *)year_month_day_weekString {
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *yearString = [dateformatter stringFromDate:self];
    
    return [NSString stringWithFormat:@"%@年%@",yearString, [self month_day_weekString]];
}

- (NSString *)month_day_weekString {
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];

    [dateformatter setDateFormat:@"MM"];
    NSString *monthString = [dateformatter stringFromDate:self];
    
    [dateformatter setDateFormat:@"dd"];
    NSString *dayString = [dateformatter stringFromDate:self];
    
    [dateformatter setDateFormat:@"EEE"];
    NSString *weekString = [dateformatter stringFromDate:self];
    
    return [NSString stringWithFormat:@"%@月%@日 %@",monthString,dayString,weekString];
}

- (NSString *)year_month_dayString {
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *yearString = [dateformatter stringFromDate:self];
    
    [dateformatter setDateFormat:@"MM"];
    NSString *monthString = [dateformatter stringFromDate:self];
    
    [dateformatter setDateFormat:@"dd"];
    NSString *dayString = [dateformatter stringFromDate:self];
    
    return [NSString stringWithFormat:@"%@.%@.%@",yearString, monthString, dayString];
}

+ (NSString *)year_month_dayStringWithString:(NSString *)string {
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateformatter dateFromString:string];
    if (!date) {
        return nil;
    }
    
    return [date year_month_dayString];
}

/** 用来判断时间的大小,FTime是第一个时间是否大于等于STime第二个时间,时间格式仅仅支持HHmmss */
+(BOOL)compareTimeIsGreaterFTime:(NSString*)ftime STime:(NSString*)stime{
    NSString* firstTime = ftime;
    if(ftime.length < 6){
        for(int index = 0; index<6-ftime.length; index++){
            firstTime = [firstTime stringByAppendingString:@"0"];
        }
    }
    NSString* secondTime = stime;
    if(stime.length < 6){
        for(int index = 0; index<6-stime.length; index++){
            secondTime = [secondTime stringByAppendingString:@"0"];
        }
    }
    int ftimeH = [[firstTime substringWithRange:NSMakeRange(0, 2)] intValue];
    int ftimeM = [[firstTime substringWithRange:NSMakeRange(2, 2)] intValue];
    int ftimeS = [[firstTime substringWithRange:NSMakeRange(4, 2)] intValue];
    
    int stimeH = [[secondTime substringWithRange:NSMakeRange(0, 2)] intValue];
    int stimeM = [[secondTime substringWithRange:NSMakeRange(2, 2)] intValue];
    int stimeS = [[secondTime substringWithRange:NSMakeRange(4, 2)] intValue];
    
    if(ftimeH > stimeH){
        return YES;
    }else if(ftimeH < stimeH){
        return NO;
    }else{
        if(ftimeM > stimeM){
            return YES;
        }else if (ftimeM < stimeM){
            return NO;
        }else{
            if(ftimeS > stimeS){
                return YES;
            }else if (ftimeS < stimeS){
                return NO;
            }else{
                return YES;
            }
        }
    }
}

+ (NSString *)getChineseTime:(NSString*)time {
    //yyyyMM
    NSString* year = [time substringWithRange:NSMakeRange(0, 4)];
    NSString* month = [time substringWithRange:NSMakeRange(4, 2)];
    return [NSString stringWithFormat:@"%@年%@月",year,month];
}

+ (NSString *)getCurrentTime {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HHmmss"];
    NSString* currentTime = [formatter stringFromDate:[NSDate date]];
    return currentTime;
}

+ (NSString *)getCurrentMonth {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    NSString* currentTime = [formatter stringFromDate:[NSDate date]];
    return currentTime;
}

+ (NSString *)getCurrentDate {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString* currentTime = [formatter stringFromDate:[NSDate date]];
    return currentTime;
}

+ (NSInteger)getFirstDateInfoMonth:(NSString*)month {
    
    //yyyyMM
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate * date  = [formatter dateFromString:[month stringByAppendingString:@"01"]];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成NSCalendarIdentifierGregorian
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:date];
    return comps.weekday;
}

+ (NSInteger)getNumberOfDaysInMonth:(NSString*)month {
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    NSDate * date  = [formatter dateFromString:month];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit:NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

@end
