//
//  JXTDataValueFormater.h
//  BMS
//
//  Created by qinwen on 2019/3/24.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXTDataValueFormater : NSObject<IChartValueFormatter>

- (instancetype)initWithArray:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
