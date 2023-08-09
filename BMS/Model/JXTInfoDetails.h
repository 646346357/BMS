//
//  JXTInfoDetails.h
//  BMS
//
//  Created by qinwen on 2019/3/4.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTInfoDetails : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, strong, readonly)NSString *display;

//针对电池包
@property (nonatomic, assign) BOOL isBalance;//是否正在均衡
@property (nonatomic, assign) BOOL isHighest;//是否为最高单体
@property (nonatomic, assign) BOOL isLowest;//是否为最低单体

- (instancetype)initWithName:(NSString *)name value:(NSString *)value unit:(NSString *)unit;

@end


