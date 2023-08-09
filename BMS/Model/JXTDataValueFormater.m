//
//  JXTDataValueFormater.m
//  BMS
//
//  Created by qinwen on 2019/3/24.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTDataValueFormater.h"

@interface JXTDataValueFormater ()

@property (nonatomic, strong) NSArray* arr;
@property (nonatomic, assign) NSInteger minX;
@property (nonatomic, assign) NSInteger maxX;

@end

@implementation JXTDataValueFormater

- (instancetype)initWithArray:(NSMutableArray *)arr {
    if (self = [super init]) {
        [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            ChartDataEntry * entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry * entry2 =(ChartDataEntry *)obj2;
            if (entry1.y <= entry2.y){
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        _minX = ((ChartDataEntry * )[arr firstObject]).x;
        _maxX = ((ChartDataEntry * )[arr lastObject]).x;
    }
    
    return self;
}

-(NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler {
    if (entry.x==_minX || entry.x == _maxX) {
        return [NSString stringWithFormat:@"%.1f",entry.y];
    }else{
        return @"";
    }
}

@end
