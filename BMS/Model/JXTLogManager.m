//
//  JXTLogManager.m
//  BMS
//
//  Created by qinwen on 2019/4/17.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTLogManager.h"

@interface JXTLogManager ()

@property (nonatomic, strong) NSMutableArray *innerArray;
@property (nonatomic, copy) JXTLogManagerBlock block;

+(instancetype) new __attribute__((unavailable("JXTLogManager类只能初始化一次")));
-(instancetype) copy __attribute__((unavailable("JXTLogManager类只能初始化一次")));
-(instancetype) mutableCopy  __attribute__((unavailable("JXTLogManager类只能初始化一次")));

@end

@implementation JXTLogManager

#pragma mark - Life Cycle

static JXTLogManager *_instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JXTLogManager alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        for (NSInteger i = 0; i <= 31; i++) {
            JXTLog *log = [[JXTLog alloc] init];
            log.index = i;
            [self.innerArray addObject:log];
        }
    }
    
    return self;
}

+ (instancetype)alloc
{
    if(_instance)
    {
        return  _instance;
    }
    return [super alloc];
}


#pragma mark - Public Method

- (void)logDidChangedBlock:(JXTLogManagerBlock)block {
    self.block = [block copy];
}

- (void)updateLogWithIndex:(NSUInteger)index number:(NSUInteger)number status:(NSUInteger)status statusDisplay:(NSString *)statusDisplay {
    JXTLog *log = self.innerArray[index];
    log.number = number;
    log.status = status;
    log.statusDisplay = statusDisplay;
    if (self.block) {
        self.block(self.logArray);
    }
}

#pragma mark - Getter & Setter

- (NSMutableArray *)innerArray {
    if (!_innerArray) {
        _innerArray = [NSMutableArray array];
    }
    
    return _innerArray;
}

- (NSArray *)logArray {
    NSMutableArray *arr = [NSMutableArray array];
    for (JXTLog *log in self.innerArray) {
        if (log.statusDisplay.length > 0) {
            [arr addObject:log];
        }
    }
    return [arr copy];
}

@end
