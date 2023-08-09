//
//  JXTCharacter.h
//  BMS
//
//  Created by admin on 2019/2/15.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTCharacter : NSObject

@property (nonatomic, assign) BOOL readOnly;
@property (nonatomic, assign) BOOL sendDefaultValueOnly;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) Byte highValue;
@property (nonatomic, assign) Byte lowValue;
@property (nonatomic, copy) NSString *settingValueText;
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, assign, readonly) Byte address;
@property (nonatomic, assign, readonly, getter=isSignaled) BOOL signaled;//是否带符号
@property (nonatomic, assign, readonly) NSInteger coefficient;//换算系数 10的coefficient次幂
@property (nonatomic, copy, readonly) NSString *valueDisplay;
@property (nonatomic, assign, readonly) Byte settingHighValue;
@property (nonatomic, assign, readonly) Byte settingLowValue;
@property (nonatomic, weak) JXTCharacter *header;

- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address;
- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address coefficient:(NSInteger)coefficient;
- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address isSignaled:(BOOL)isSignaled;
- (instancetype)initWithName:(NSString *)name highValue:(Byte)highValue lowValue:(Byte)lowValue unit:(NSString *)unit address:(Byte)address coefficient:(NSInteger)coefficient isSignaled:(BOOL)isSignaled;

@end

