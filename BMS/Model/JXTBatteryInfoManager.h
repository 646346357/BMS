//
//  JXTBatteryinfo.h
//  BMS
//
//  Created by admin on 2019/2/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXTInfoDetails.h"

@interface JXTBatteryInfoManager : NSObject

/**
 总压(4-5) 0.0V
 */
 @property (nonatomic, strong, readonly) JXTInfoDetails *overallVoltage;

/**
 单串电池包电压数组(6-69) 0.000V
 */
 @property (nonatomic, strong, readonly) NSMutableArray *voltageArray;

/**
 电流(70-73) ±0.0A
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *current;

/**
 剩余电量百分比(74) 0
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *batteryRate;

/**
 电池物理容量(75-78) 0.000000AH
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *overallCapacity;

/**
 电池剩余容量(79-82) 0.000000AH
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *remainingCapacity;

/**
 电池总循环容量(83-86) 0.000AH
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *cycleCapacity;

/**
 从开机进行累加(87-90) 0s
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *timeinterval;
@property (nonatomic, assign) uint32_t time;

/**
 实际温度<均衡温度 MOS温度 T1 T2 T3 T4>(91-102)  ±0℃
 */
 @property (nonatomic, strong, readonly) NSMutableArray *temperatureArray;

/**
 充电mos管状态标志(103)
 //值：0 关闭
 //值：1    开启
 //值：2    过压保护
 //值：3 过流保护
 //值：4    电池充满
 //值：5    总压过压
 //值：6 电池过温
 //值：7 功率过温
 //值：8 电流异常
 //值：9 均衡线掉串
 //值：10 主板过温
 //值：13 放电管异常
 //值：15 手动关闭
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *chargeMosState;

/**
 放电mos管状态标志(104)
 //值：0 关闭
 //值：1    开启
 //值：2    过放保护
 //值：3 过流保护
 //值：5    总压欠压
 //值：6 电池过温
 //值：7 功率过温
 //值：8 电流异常
 //值：9 均衡线掉串
 //值：10 主板过温
 //值：11 充电开启
 //值：12 短路保护
 //值：13 放电管异常
 //值：14 启动异常
 //值：15 手动关闭
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *dischargeMosState;

/**
 均衡状态标志(105)
 //值：0 关闭
 //值：1    超过极限均衡
 //值：2    充电压差均衡
 //值：3 均衡过温
 //值：4 自动均衡
 //值：10 主板过温
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *balanceState;

/**
 轮胎长度(106-107) 0mm  不显示
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *wheelLength;

/**
 一周脉冲次数(108-109) 0Hz  不显示
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *pulseFrequency;

/**
 继电器开关(110) 不显示
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *relaySwitch;

/**
 当前功率(111-114) ±0W
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *power;

/**
 最高单体串数(115) 无
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *highestIndex;

/**
 最高单体电压(116-117) 0.000V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *highestVoltage;

/**
 最低单体串数(118) 0无
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *lowestIndex;

/**
 最低单体电压(119-120) 0.000V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *lowestVoltage;

/**
 平均值(121-122) 0.000V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *averageVoltage;

/**
 有效电池数量(123) 0无
 */
 @property (nonatomic, strong, readonly) JXTInfoDetails *validCount;

/**
 检测的放电管 D-S极之间的电压(124-125) 0.0V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *DSVoltage;

/**
放电MOS管驱动电压(126-127) 0.0V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *dischargeMosVoltage;


/**
 充电MOS管驱动电压(128-129) 0.0V
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *chargeMosVoltage;

/**
 检测到的电流为0时比较器初值(130-131) 不用显示
 */
 @property (nonatomic, strong, readonly) JXTInfoDetails *ComparatorValue;

/**
 控制均衡对应位 为1 则均衡(1-32位 对应1-32串均衡)(132-135) 对应位为1  在对应的电压上显示颜色
 */
 @property (nonatomic, strong, readonly) JXTInfoDetails *balanceBit;

/**
 系统日志发送给串口数据， 状态 ：0-4  电池编号：5-9  先后顺序：10-14  充电放电：15（1放电，0充电）(136-137)
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *systemLog;

/**
 固件版本
 */
@property (nonatomic, strong, readonly) JXTInfoDetails *version;

/**
 和校验（138-139）
 */
@property (nonatomic, assign) int16_t sumCheck;

+ (instancetype)sharedInstance;
- (void)updateWithData:(NSData *)data;
- (void)updateWithTime:(uint32_t)time;

@end


