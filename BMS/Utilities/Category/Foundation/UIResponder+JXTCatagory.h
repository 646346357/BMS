//
//  UIResponder+JXTCatagory.h
//  HKRidingClub
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (JXTCatagory)

+ (id)jxt_currentFirstResponder;
+ (void)jxt_resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
