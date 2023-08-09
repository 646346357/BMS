//
//  JXTLongCharacter.m
//  BMS
//
//  Created by qinwen on 2019/5/5.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTLongCharacter.h"

@implementation JXTLongCharacter

- (NSString *)valueDisplay {
    if (0 == _charcterList.count) {
        return @"";
    }
    NSMutableString *str = [NSMutableString string];
    [_charcterList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(JXTCharacter *c, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendString:[BabyToy ConvertIntToHexString:c.highValue]];
        [str appendString:[BabyToy ConvertIntToHexString:c.lowValue]];
    }];
    
    return [str copy];
}

@end
