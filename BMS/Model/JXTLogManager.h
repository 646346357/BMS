//
//  JXTLogManager.h
//  BMS
//
//  Created by qinwen on 2019/4/17.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXTLog.h"

typedef void(^JXTLogManagerBlock)(NSArray *);

@interface JXTLogManager : NSObject

@property (nonatomic, strong, readonly) NSArray *logArray;

+ (instancetype)sharedInstance;
- (void)logDidChangedBlock:(JXTLogManagerBlock)block;
//返回character所在的row，如果无需更新，返回-1
- (void)updateLogWithIndex:(NSUInteger)index number:(NSUInteger)number status:(NSUInteger)status statusDisplay:(NSString *)statusDisplay;

@end

