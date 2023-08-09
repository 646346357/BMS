//
//  JXTLog.h
//  BMS
//
//  Created by qinwen on 2019/4/17.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTLog : NSObject

@property (nonatomic, assign) NSUInteger index; //0~31
@property (nonatomic, assign) NSUInteger  number; //1~32
@property (nonatomic, assign) NSUInteger status; //0充电  1放电
@property (nonatomic, copy) NSString *statusDisplay;

@end

