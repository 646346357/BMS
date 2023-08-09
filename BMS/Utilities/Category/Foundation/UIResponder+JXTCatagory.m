//
//  UIResponder+JXTCatagory.m
//  HKRidingClub
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 admin. All rights reserved.
//

#import "UIResponder+JXTCatagory.h"

static __weak id jxt_currentFirstResponder;

@implementation UIResponder (JXTCatagory)

+ (id)jxt_currentFirstResponder {
    jxt_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(jxt_findFirstResponder:) to:nil from:nil forEvent:nil];
    return jxt_currentFirstResponder;
}

+ (void)jxt_resignFirstResponder {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)jxt_findFirstResponder:(id)sender {
    jxt_currentFirstResponder = self;
}

@end
