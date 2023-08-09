//
//  JXTBatteryinfo.m
//  BMS
//
//  Created by admin on 2019/2/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTBatteryInfoManager.h"

@interface JXTBatteryInfoManager ()

+(instancetype) new __attribute__((unavailable("JXTBatteryInfoManager类只能初始化一次")));
-(instancetype) copy __attribute__((unavailable("JXTBatteryInfoManager类只能初始化一次")));
-(instancetype) mutableCopy  __attribute__((unavailable("JXTBatteryInfoManager类只能初始化一次")));

@end

@implementation JXTBatteryInfoManager

#pragma mark - Life Cycle

static JXTBatteryInfoManager *_instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JXTBatteryInfoManager alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        JXTInfoDetails *runingTime = [[JXTInfoDetails alloc] initWithName:@"运行时间：" value:@"" unit:nil];
        _timeinterval = runingTime;
        _time =0;
        
        JXTInfoDetails *chargeMosVoltage = [[JXTInfoDetails alloc] initWithName:@"充电MOS管驱动电压：" value:@"0.0" unit:@"V"];
        _chargeMosVoltage = chargeMosVoltage;
        
        JXTInfoDetails *dischargeMosVoltage = [[JXTInfoDetails alloc] initWithName:@"放电MOS管驱动电压：" value:@"0.0" unit:@"V"];
        _dischargeMosVoltage = dischargeMosVoltage;
        
        JXTInfoDetails *rv = [[JXTInfoDetails alloc] initWithName:@"RV：" value:@"" unit:nil];
        _version = rv;
        
        JXTInfoDetails *balanceDisplay = [[JXTInfoDetails alloc] initWithName:@"均衡状态：" value:@"关闭" unit:nil];
        _balanceState = balanceDisplay;
        
        JXTInfoDetails *current = [[JXTInfoDetails alloc] initWithName:@"电流：" value:@"0.0" unit:@"A"];
        _current = current;
        
        JXTInfoDetails *batteryRate = [[JXTInfoDetails alloc] initWithName:@"剩余电量：" value:@"0" unit:@"%"];
        _batteryRate = batteryRate;
        
        JXTInfoDetails *power = [[JXTInfoDetails alloc] initWithName:@"当前功率：" value:@"0" unit:@"W"];
        _power = power;
        
        JXTInfoDetails *cycleCapacity = [[JXTInfoDetails alloc] initWithName:@"总容量：" value:@"0.0" unit:@"AH"];
        _cycleCapacity = cycleCapacity;
        
        JXTInfoDetails *overallCapacity = [[JXTInfoDetails alloc] initWithName:@"物理容量：" value:@"0.0" unit:@"AH"];
        _overallCapacity = overallCapacity;
        
        JXTInfoDetails *remainingCapacity = [[JXTInfoDetails alloc] initWithName:@"剩余容量：" value:@"0.0" unit:@"AH"];
        _remainingCapacity = remainingCapacity;
        
        JXTInfoDetails *chargeMosDisplay = [[JXTInfoDetails alloc] initWithName:@"充电mos：" value:@"关闭" unit:nil];
        _chargeMosState = chargeMosDisplay;
        
        JXTInfoDetails *dischargeMosDisplay = [[JXTInfoDetails alloc] initWithName:@"放电mos：" value:@"关闭" unit:nil];
        _dischargeMosState = dischargeMosDisplay;
        
        JXTInfoDetails *overallVoltage = [[JXTInfoDetails alloc] initWithName:@"总电压：" value:@"0.0" unit:@"V"];
        _overallVoltage = overallVoltage;
        
        JXTInfoDetails *averageVoltage = [[JXTInfoDetails alloc] initWithName:@"平均电压：" value:@"0.0" unit:@"V"];
        _averageVoltage = averageVoltage;
        
        JXTInfoDetails *highestIndex = [[JXTInfoDetails alloc] initWithName:@"最高单体串数：" value:@"0" unit:nil];
        _highestIndex = highestIndex;
        
        JXTInfoDetails *highestVoltage = [[JXTInfoDetails alloc] initWithName:@"最高单体电压：" value:@"0.0" unit:@"V"];
        _highestVoltage = highestVoltage;
        
        JXTInfoDetails *lowestIndex = [[JXTInfoDetails alloc] initWithName:@"最低单体串数：" value:@"0" unit:nil];
        _lowestIndex = lowestIndex;
        
        JXTInfoDetails *lowestVoltage = [[JXTInfoDetails alloc] initWithName:@"最低单体电压：" value:@"0.0" unit:@"V"];
        _lowestVoltage = lowestVoltage;
        
        JXTInfoDetails *validCount = [[JXTInfoDetails alloc] initWithName:@"有效电池数量：" value:@"0" unit:nil];
        _validCount = validCount;
        
        JXTInfoDetails *DSVoltage = [[JXTInfoDetails alloc] initWithName:@"DS极间电压：" value:@"0.0" unit:@"V"];
        _DSVoltage = DSVoltage;
        
        _voltageArray = [NSMutableArray array];
        
        _temperatureArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 6; i++) {
            NSString *name;
            if (0 == i) {
                name = @"均衡温度：";
            } else if (1 == i) {
                name = @"MOS温度：";
            } else {
                name = [NSString stringWithFormat:@"T%ld：",(long)i-1];
            }
            JXTInfoDetails *temperature = [[JXTInfoDetails alloc] initWithName:name value:@"0.0" unit:@"℃"];
            [_temperatureArray addObject:temperature];
        }
        _sumCheck = 0;
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

#pragma Public Method

- (void)updateWithData:(NSData *)data {
    if (data.length < 140) {
        return ;
    }
    
    for (JXTInfoDetails *info in _voltageArray) {
        info.isBalance = NO;
        info.isHighest = NO;
        info.isLowest = NO;
    }
    
    //    int8_t tmp_8 = 0;
    uint8_t tmp_u8 = 0;
    int16_t tmp_16 = 0;
    uint16_t tmp_u16 = 0;
    int32_t tmp_32 = 0;
    uint32_t tmp_u32 = 0;
    Byte *b = [BabyToy ConvertDataToByteArray:data];
    
    //有效电池数量
    tmp_u8 = b[123] & 0xff;
    _validCount.value = [NSString stringWithFormat:@"%d", tmp_u8];
    if (_voltageArray.count != tmp_u8) {
        [_voltageArray removeAllObjects];
        for (NSInteger i = 0; i < tmp_u8; i++) {
            NSString *format = @"%ld";
            if (i+1<10) {
                format = @"0%ld";
            }
            JXTInfoDetails *voltage = [[JXTInfoDetails alloc] initWithName:[NSString stringWithFormat:format,(long)i+1] value:@"0.0" unit:@"V"];
            [_voltageArray addObject:voltage];
        }
    }
    
    //总电压
    tmp_u16 = (((b[4] << 8) & 0xff00) + (b[5] & 0xff));
    _overallVoltage.value = [NSString stringWithFormat:@"%.1lf", tmp_u16/10.0];
    
    //总电流
    tmp_32 = ((b[70] << 24) & 0xff000000) + ((b[71] << 16) & 0xff0000) + ((b[72] << 8) & 0xff00) + (b[73] & 0xff);
    _current.value = [NSString stringWithFormat:@"%.1lf", tmp_32/10.0]; ;
    
    //剩余容量
    tmp_u32 = (((b[79] << 24) & 0xff000000) + ((b[80] << 16) & 0xff0000) + ((b[81] << 8) & 0xff00) + (b[82] & 0xff));
    _remainingCapacity.value = [NSString stringWithFormat:@"%.3lf", tmp_u32/1000000.0];
    
    //剩余百分比
    tmp_u8 = b[74] & 0xff;
    _batteryRate.value = [NSString stringWithFormat:@"%d", tmp_u8];;
    
    //总容量
    tmp_u32 = (((b[83] << 24) & 0xff000000) + ((b[84] << 16) & 0xff0000) + ((b[85] << 8) & 0xff00) + (b[86] & 0xff));
    _cycleCapacity.value = [NSString stringWithFormat:@"%.3lf", tmp_u32/1000.0];
    
    //功率
    tmp_32 = (((b[111] << 24) & 0xff000000) + ((b[112] << 16) & 0xff0000) + ((b[113] << 8) & 0xff00) + (b[114] & 0xff));
    _power.value = [NSString stringWithFormat:@"%d", tmp_32];
    
    //最高单体电压
    tmp_u16 = (((b[116] << 8) & 0xff00) + (b[117] & 0xff));
    _highestVoltage.value = [NSString stringWithFormat:@"%.3lf", tmp_u16/1000.0];
    
    //最高串数
    tmp_u8 = b[115] & 0xff;
    _highestIndex.value = [NSString stringWithFormat:@"%d", tmp_u8];
    if (tmp_u8 > 0 && tmp_u8 <= _voltageArray.count) {
        JXTInfoDetails *tmp_high = _voltageArray[tmp_u8-1];
        tmp_high.isHighest = YES;
    }
    
    //最低单体电压
    tmp_u16 = (((b[119] << 8) & 0xff00) + (b[120] & 0xff));
    _lowestVoltage.value = [NSString stringWithFormat:@"%.3lf", tmp_u16/1000.0];
    
    //最低串数
    tmp_u8 = b[118] & 0xff;
    _lowestIndex.value = [NSString stringWithFormat:@"%d", tmp_u8];
    if (tmp_u8 > 0 && tmp_u8 <= _voltageArray.count) {
        JXTInfoDetails *tmp_low = _voltageArray[tmp_u8-1];
        tmp_low.isLowest = YES;
    }
    
    
    //平均值
    tmp_u16 = (((b[121] << 8) & 0xff00) + (b[122] & 0xff));
    _averageVoltage.value = [NSString stringWithFormat:@"%.3lf", tmp_u16/1000.0];
    
    //温度 <均衡温度 MOS温度 T1 T2 T3 T4>
    for (NSInteger i = 91; i <= 102; i++) {
        tmp_16 = (((b[i] << 8) & 0xff00) + (b[i+1] & 0xff));
        JXTInfoDetails *t = _temperatureArray[(i-91)/2];
        t.value = [NSString stringWithFormat:@"%d", tmp_16];
        i+=1;
    }
    
    //单体电压
    for (NSInteger i = 6; i <= 69; i++) {
        tmp_u16 = (((b[i] << 8) & 0xff00) + (b[i+1] & 0xff));
        NSUInteger index = (i-6)/2;
        if (index < _voltageArray.count) {
            JXTInfoDetails *v = _voltageArray[index];
            v.value = [NSString stringWithFormat:@"%.3lf", tmp_u16/1000.0];
        }
        i+=1;
    }
    
    //充电管标志
    tmp_u8 = b[103] & 0xff;
    _chargeMosState.value = [self chargeMosDisplay:tmp_u8];
    
    //放电管标志
    tmp_u8 = b[104] & 0xff;
    _dischargeMosState.value = [self dischargeMosDisplay:tmp_u8];
    
    //均衡标志
    tmp_u8 = b[105] & 0xff;
    _balanceState.value = [self balanceDisplay:tmp_u8];
    
    //均衡标志
    tmp_u32 = (((b[132] << 24) & 0xff000000) + ((b[133] << 16) & 0xff0000) + ((b[134] << 8) & 0xff00) + (b[135] & 0xff));
    for (NSInteger i = 0; i < _voltageArray.count; i++) {
        NSInteger bit = 1 << i;
        JXTInfoDetails *voltage = _voltageArray[i];
        if ((bit & tmp_u32) != 0) {
            voltage.isBalance = YES;
        }
    }
    
    //系统运行时间
    tmp_u32 = (((b[87] << 24) & 0xff000000) + ((b[88] << 16) & 0xff0000) + ((b[89] << 8) & 0xff00) + (b[90] & 0xff));
    _time =tmp_u32;
    _timeinterval.value = [self runingTime:_time];
    
    //电池物理容量
    tmp_u32 = (((b[75] << 24) & 0xff000000) + ((b[76] << 16) & 0xff0000) + ((b[77] << 8) & 0xff00) + (b[78] & 0xff));
    _overallCapacity.value = [NSString stringWithFormat:@"%.3lf", tmp_u32/1000000.0];
    
    //轮胎长度
    tmp_u16 = (((b[106] << 8) & 0xff00) + (b[107] & 0xff));
    
    
    //一周脉冲次数
    tmp_u16 = (((b[108] << 8) & 0xff00) + (b[109] & 0xff));
    
    
    //继电器开关
    tmp_u8 = b[110] & 0xff;
    
    
    //D-S极之间的电压
    tmp_u16 = (((b[124] << 8) & 0xff00) + (b[125] & 0xff));
    _DSVoltage.value = [NSString stringWithFormat:@"%.1lf", tmp_u16/10.0];
    
    //放电MOS管驱动电压
    tmp_u16 = (((b[126] << 8) & 0xff00) + (b[127] & 0xff));
    _dischargeMosVoltage.value = [NSString stringWithFormat:@"%.1lf", tmp_u16/10.0];
    
    //充电MOS管驱动电压
    tmp_u16 = (((b[128] << 8) & 0xff00) + (b[129] & 0xff));
    _chargeMosVoltage.value = [NSString stringWithFormat:@"%.1lf", tmp_u16/10.0];
    
    //检测到的电流为0时比较器初值
    tmp_u16 = (((b[130] << 8) & 0xff00) + (b[131] & 0xff));
    
    //系统日志发送给串口数据
    tmp_u16 = (((b[136] << 8) & 0xff00) + (b[137] & 0xff));
    //所在顺序
    NSUInteger index = (tmp_u16>>10)&0x1f;
    //状态
    NSUInteger status = tmp_u16&0x1f;
    //电池编号
    NSUInteger number = (tmp_u16>>5)&0x1f;
    //充放电 1放电 0充电
    NSUInteger chargeOrDischarge = (tmp_u16>>5)&0x1f;
   
    //描述
    NSString *display = nil;
    if(status<25 && index < 32 && tmp_u16 !=0){
        if(1 == chargeOrDischarge) {//放电
            display = [self dischargeMosDisplay:status];
        } else {
            display = [self chargeMosDisplay:status];
        }
        [[JXTLogManager sharedInstance] updateLogWithIndex:index number:number status:chargeOrDischarge statusDisplay:display];
    }
    
    //和校验
    tmp_u16 = (((b[138] << 8) & 0xff00) + (b[139] & 0xff));
    _sumCheck = tmp_u16;
}

- (void)updateWithTime:(uint32_t)time {
    _timeinterval.value = [self runingTime:time];
}

#pragma mark - Private Method

- (NSString *)runingTime:(uint32_t)timeinterval {
    NSMutableString *time = [NSMutableString string];
    NSInteger s = timeinterval % 60;
    NSInteger m = timeinterval / 60 % 60;
    NSInteger h = timeinterval / 60 / 60 % 24;
    NSInteger d = timeinterval / 60 /60 / 24;
    if (d > 0) {
        [time appendString:[NSString stringWithFormat:@"%ld天",(long)d]];
    }
    if (h > 0) {
        [time appendString:[NSString stringWithFormat:@"%ld小时",(long)h]];
    }
    if (m > 0) {
        [time appendString:[NSString stringWithFormat:@"%ld分钟",(long)m]];
    }
    [time appendString:[NSString stringWithFormat:@"%ld秒",(long)s]];
    
    return time;
}

- (NSString *)chargeMosDisplay:(uint8_t)chargeMosState {
    NSString *display;
    switch (chargeMosState) {
        case 0:
            display = @"关闭";
            break;
        case 1:
            display = @"开启";
            break;
        case 2:
            display = @"单体过压";
            break;
        case 3:
            display = @"过流保护";
            break;
        case 4:
            display = @"电池充满";
            break;
        case 5:
            display = @"总压过压";
            break;
        case 6:
            display = @"电池过温";
            break;
        case 7:
            display = @"功率过温";
            break;
        case 8:
            display = @"电流异常";
            break;
        case 9:
            display = @"均衡线掉串";
            break;
        case 10:
            display = @"主板过温";
            break;
        case 12:
            display = @"开启失败";
            break;
        case 13:
            display = @"放电管异常";
            break;
        case 14:
            display = @"等待";
            break;
        case 15:
            display = @"手动关闭";
            break;
        case 16:
            display = @"二级过压";
            break;
        case 17:
            display = @"低温保护";
            break;
        case 18:
            display = @"压差超限";
            break;
        case 20:
            display = @"单体校验异常";
            break;
        case 21:
            display = @"电流异常";
            break;
        case 22:
            display = @"总压单体异常";
            break;
        default:
            display = @"未知状态";
            break;
    }
    
    return display;
}

- (NSString *)dischargeMosDisplay:(uint8_t)dischargeMosState {
    NSString *display;
    switch (dischargeMosState) {
        case 0:
            display = @"关闭";
            break;
        case 1:
            display = @"开启";
            break;
        case 2:
            display = @"单体欠压";
            break;
        case 3:
            display = @"过流保护";
            break;
        case 4:
            display = @"二级过流";
            break;
        case 5:
            display = @"总压欠压";
            break;
        case 6:
            display = @"电池过温";
            break;
        case 7:
            display = @"功率过温";
            break;
        case 8:
            display = @"电流异常";
            break;
        case 9:
            display = @"均衡线掉串";
            break;
        case 10:
            display = @"主板过温";
            break;
        case 11:
            display = @"充电开启";
            break;
        case 12:
            display = @"短路保护";
            break;
        case 13:
            display = @"放电管异常";
            break;
        case 14:
            display = @"开启失败";
            break;
        case 15:
            display = @"手动关闭";
            break;
        case 16:
            display = @"二级欠压";
            break;
        case 17:
            display = @"低温保护";
            break;
        case 18:
            display = @"压差超限";
            break;
        case 20:
            display = @"单体校验异常";
            break;
        case 21:
            display = @"电流异常";
            break;
        case 22:
            display = @"总压单体异常";
            break;
        default:
            display = @"未知状态";
            break;
    }
    
    return display;
}

- (NSString *)balanceDisplay:(uint8_t)balanceState {
    NSString *display;
    switch (balanceState) {
        case 0:
            display = @"关闭";
            break;
        case 1:
            display = @"超过极限均衡";
            break;
        case 2:
            display = @"充电压差均衡";
            break;
        case 3:
            display = @"均衡过温";
            break;
        case 4:
            display = @"自动均衡";
            break;
        case 10:
            display = @"主板过温";
            break;
        default:
            display = @"未知状态";
            break;
    }
    
    return display;
}

@end
