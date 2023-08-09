//
//  JXTDoubleCharacter.m
//  BMS
//
//  Created by admin on 2019/3/6.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTDoubleCharacter.h"

@implementation JXTDoubleCharacter

#pragma mark - Getter & Setter

- (NSString *)valueDisplay {
    NSString *display = @"0";
    if (!self.signaled) {//不带符号
        uint32_t uv = ((self.highValue << 24) & 0xff000000) + ((self.lowValue << 16) & 0xff0000) + ((self.next.highValue << 8) & 0xff00) + (self.next.lowValue & 0xff);
        double ud = (double)uv * pow(10, self.coefficient);
        if (self.coefficient >= 0) {
            display = [NSString stringWithFormat:@"%u", (uint32_t)ud];
        } else if (-1 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.1lf",ud];
        } else if (-2 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.2lf",ud];
        } else {
            display = [NSString stringWithFormat:@"%.3lf",ud];
        }
    } else {//带符号
        int32_t v = ((self.highValue << 24) & 0xff000000) + ((self.lowValue << 16) & 0xff0000) + ((self.next.highValue << 8) & 0xff00) + (self.next.lowValue & 0xff);
        double d = (double)v * pow(10, self.coefficient);
        if (self.coefficient >= 0) {
            display = [NSString stringWithFormat:@"%d", (int32_t)d];
        } else if (-1 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.1lf",d];
        } else if (-2 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.2lf",d];
        } else {
            display = [NSString stringWithFormat:@"%.3lf",d];
        }
    }
    
    return display;
}

- (Byte)settingHighValue {
    if (0 == self.settingValueText.length) {
        return 0;
    }
    
    double d = [self.settingValueText doubleValue];
    d = d * pow(10, -self.coefficient);
    if (!self.signaled) {//不带符号
        uint32_t uv = (uint32_t)d;
        return ((uv >> 24) & 0xff);
    } else {//带符号
        int32_t v= (int32_t)d;
        return ((v >> 24)& 0xff);
    }
}

- (Byte)settingLowValue {
    if (0 == self.settingValueText.length) {
        return 0;
    }
    
    double d = [self.settingValueText doubleValue];
    d = d * pow(10, -self.coefficient);
    if (!self.signaled) {//不带符号
        uint32_t uv = (uint32_t)d;
        return ((uv >> 16) & 0xff);
    } else {//带符号
        int32_t v= (int32_t)d;
        return ((v >> 16) & 0xff);
    }
}

- (void)setNext:(JXTCharacter *)next {
    _next = next;
    _next.header = self;
}

@end
