//
//  JXTCharacter.m
//  BMS
//
//  Created by admin on 2019/2/15.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTCharacter.h"

@implementation JXTCharacter

#pragma mark - Life Cycle

- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address {
    return [self initWithName:name highValue:highValue lowValue:lowValue unit:unit address:address coefficient:0 isSignaled:NO];
}

- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address coefficient:(NSInteger)coefficient {
    return [self initWithName:name highValue:highValue lowValue:lowValue unit:unit address:address coefficient:coefficient isSignaled:NO];
}

- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address isSignaled:(BOOL)isSignaled {
    return  [self initWithName:name highValue:highValue lowValue:lowValue unit:unit address:address coefficient:0 isSignaled:isSignaled];
}

- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address coefficient:(NSInteger)coefficient isSignaled:(BOOL)isSignaled {
    if (self = [super init]) {
        _name = [name copy];
        _highValue = highValue;
        _lowValue = lowValue;
        _unit = [unit copy];
        _valueColor = [UIColor defaultBlackColor];
        _address = address;
        _coefficient = coefficient;
        _signaled = isSignaled;
    }
    
    return  self;
}

#pragma mark - Override Method

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    if (self.address == ((JXTCharacter *)object).address) {
        return YES;
    }
    
    return NO;
}

- (NSUInteger)hash {
    return [self.name hash];
}

#pragma mark - Getter & Setter

- (NSString *)valueDisplay {
    NSString *display = @"0";
    if (!self.signaled) {//不带符号
        uint16_t uv = ((self.highValue << 8) & 0xff00) + (self.lowValue & 0xff);
        double ud = (double)uv * pow(10, self.coefficient);
        if (self.coefficient >= 0) {
            display = [NSString stringWithFormat:@"%u", (uint16_t)ud];
        } else if (-1 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.1lf",ud];
        } else if (-2 == self.coefficient) {
            display = [NSString stringWithFormat:@"%.2lf",ud];
        } else {
            display = [NSString stringWithFormat:@"%.3lf",ud];
        }
    } else {//带符号
        int16_t v = ((self.highValue << 8) & 0xff00) + (self.lowValue & 0xff);
        double d = (double)v * pow(10, self.coefficient);
        if (self.coefficient >= 0) {
            display = [NSString stringWithFormat:@"%d", (int16_t)d];
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
        if (!self.header) {
            uint16_t uv = (uint16_t)d;
            return ((uv >> 8) & 0xff);
        } else {
            uint32_t uv = (uint32_t)d;
            return ((uv >> 8) & 0xff);
        }
        
    } else {//带符号
        if (!self.header) {
            int16_t v= (int16_t)d;
            return ((v >> 8)& 0xff);
        } else {
            int32_t v= (int32_t)d;
            return ((v >> 8)& 0xff);
        }
    }
}

- (Byte)settingLowValue {
    if (0 == self.settingValueText.length) {
        return 0;
    }
    
    double d = [self.settingValueText doubleValue];
    d = d * pow(10, -self.coefficient);
    if (!self.signaled) {//不带符号
        uint16_t uv = (uint16_t)d;
        return (uv & 0xff);
    } else {//带符号
        int16_t v= (int16_t)d;
        return (v & 0xff);
    }
}

- (NSString *)name {
    if (!_name) {
        _name = @"";
    }
    
    return _name;
}
         
- (NSString *)unit {
    if (!_unit) {
        _unit = @"";
    }
    
    return _unit;
}

- (NSString *)settingValueText {
    if (self.header) {
        return self.header.settingValueText;
    }
    
    if (!_settingValueText) {
        _settingValueText = @"";
    }
    
    return _settingValueText;
}

@end


