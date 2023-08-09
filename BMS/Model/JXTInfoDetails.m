//
//  JXTInfoDetails.m
//  BMS
//
//  Created by qinwen on 2019/3/4.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTInfoDetails.h"

@implementation JXTInfoDetails

#pragma mark - Life Cycle

- (instancetype)initWithName:(NSString *)name value:(NSString *)value unit:(NSString *)unit {
    if (self = [super init]) {
        _name = [name copy];
        _value = [value copy];
        _unit = [unit copy];
    }
    
    return  self;
}

#pragma mark - Getter & Setter

- (NSString *)display {
    NSMutableString *display = [@"" mutableCopy];
    if (self.value.length > 0) {
        [display appendString:self.value];
    }
    if (self.unit.length > 0) {
        [display appendString:self.unit];
    }
    
    return [display copy];
}

- (NSString *)value {
    if (!_value) {
        _value = @"";
    }
    
    return _value;
}

- (NSString *)unit {
    if (!_unit) {
        _unit = @"";
    }
    
    return _unit;
}

- (NSString *)name {
    if (!_name) {
        _name = @"";
    }
        
    return _name;
}

@end
