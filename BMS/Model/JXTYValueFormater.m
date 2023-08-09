//
//  JXTYValueFormater.m
//  BMS
//
//  Created by qinwen on 2019/3/24.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTYValueFormater.h"

@implementation JXTYValueFormater

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return [NSString stringWithFormat:@"%.0f", value];
}

@end
