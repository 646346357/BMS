//
//  JXTCharacrerManager.m
//  BMS
//
//  Created by qinwen on 2019/3/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTCharacterManager.h"

@interface JXTCharacterManager (){
    
}

@property (nonatomic, strong) NSMutableDictionary *charactDic;

+(instancetype) new __attribute__((unavailable("JXTCharacrerManager类只能初始化一次")));
-(instancetype) copy __attribute__((unavailable("JXTCharacrerManager类只能初始化一次")));
-(instancetype) mutableCopy  __attribute__((unavailable("JXTCharacrerManager类只能初始化一次")));

@end

@implementation JXTCharacterManager

#pragma mark - Life Cycle

static JXTCharacterManager *_instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JXTCharacterManager alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _charactDic = [NSMutableDictionary dictionary];
        Byte byte[] = {0,0,0,0,0,0};
        JXTCharacter *overWarningVoltage = [[JXTCharacter alloc] initWithName:@"单体过压告警" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x01 coefficient:-3];
        [_charactDic setObject:overWarningVoltage forKey:@(overWarningVoltage.address)];
        _overWarningVoltage = overWarningVoltage;
        
        JXTCharacter *underWarningVoltage = [[JXTCharacter alloc] initWithName:@"单体欠压告警" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x02 coefficient:-3];
        [_charactDic setObject:underWarningVoltage forKey:@(underWarningVoltage.address)];
        _underWarningVoltage = underWarningVoltage;
        
        JXTCharacter *overProtectVoltage = [[JXTCharacter alloc] initWithName:@"单体过压保护" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x03 coefficient:-3];
        [_charactDic setObject:overProtectVoltage forKey:@(overProtectVoltage.address)];
        _overProtectVoltage = overProtectVoltage;
        
        JXTCharacter *underProtectVoltage = [[JXTCharacter alloc] initWithName:@"单体欠压保护" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x04 coefficient:-3];
        [_charactDic setObject:underProtectVoltage forKey:@(underProtectVoltage.address)];
        _underProtectVoltage = underProtectVoltage;
        
        JXTCharacter *overRecoverVoltage = [[JXTCharacter alloc] initWithName:@"单体过压恢复" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x05 coefficient:-3];
        [_charactDic setObject:overRecoverVoltage forKey:@(overRecoverVoltage.address)];
        _overRecoverVoltage = overRecoverVoltage;
        
        JXTCharacter *underRecoverVoltage = [[JXTCharacter alloc] initWithName:@"单体欠压恢复" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x06 coefficient:-3];
        [_charactDic setObject:underRecoverVoltage forKey:@(underRecoverVoltage.address)];
        _underRecoverVoltage = underRecoverVoltage;
        
        JXTCharacter *overProtectOverallVoltage = [[JXTCharacter alloc] initWithName:@"总压过压保护" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x07 coefficient:-1];
        [_charactDic setObject:overProtectOverallVoltage forKey:@(overProtectOverallVoltage.address)];
        _overProtectOverallVoltage = overProtectOverallVoltage;
        
        JXTCharacter *underProtectOverallVoltage = [[JXTCharacter alloc] initWithName:@"总压欠压保护" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x08 coefficient:-1];
        [_charactDic setObject:underProtectOverallVoltage forKey:@(underProtectOverallVoltage.address)];
        _underProtectOverallVoltage = underProtectOverallVoltage;
        
        JXTCharacter *overProtectChargeCurrent = [[JXTCharacter alloc] initWithName:@"充电过流保护" highValue:byte[3] lowValue:byte[4] unit:@"A" address:0x09 coefficient:-1];
        [_charactDic setObject:overProtectChargeCurrent forKey:@(overProtectChargeCurrent.address)];
        _overProtectChargeCurrent = overProtectChargeCurrent;
        
        JXTCharacter *delayForOverProtectChargeCurrent = [[JXTCharacter alloc] initWithName:@"充电过流延时" highValue:byte[3] lowValue:byte[4] unit:@"s" address:0x0a];
        [_charactDic setObject:delayForOverProtectChargeCurrent forKey:@(delayForOverProtectChargeCurrent.address)];
        _delayForOverProtectChargeCurrent = delayForOverProtectChargeCurrent;
        
        JXTCharacter *overProtectDischargeCurrent = [[JXTCharacter alloc] initWithName:@"放电过流保护" highValue:byte[3] lowValue:byte[4] unit:@"A" address:0x0b coefficient:-1];
        [_charactDic setObject:overProtectDischargeCurrent forKey:@(overProtectDischargeCurrent.address)];
        _overProtectDischargeCurrent = overProtectDischargeCurrent;
        
        JXTCharacter *delayForOverProtectDischargeCurrent = [[JXTCharacter alloc] initWithName:@"放电过流延时" highValue:byte[3] lowValue:byte[4] unit:@"s" address:0x0c];
        [_charactDic setObject:delayForOverProtectDischargeCurrent forKey:@(delayForOverProtectDischargeCurrent.address)];
        _delayForOverProtectDischargeCurrent = delayForOverProtectDischargeCurrent;
        
        JXTCharacter *limitBalanceVoltage = [[JXTCharacter alloc] initWithName:@"均衡极限电压" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x0d coefficient:-3];
        [_charactDic setObject:limitBalanceVoltage forKey:@(limitBalanceVoltage.address)];
        _limitBalanceVoltage = limitBalanceVoltage;
        
        JXTCharacter *balanceWorkVoltage = [[JXTCharacter alloc] initWithName:@"均衡开启电压" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x0e coefficient:-3];
        [_charactDic setObject:balanceWorkVoltage forKey:@(balanceWorkVoltage.address)];
        _balanceWorkVoltage = balanceWorkVoltage;
        
        JXTCharacter *balancePressureDifferentials = [[JXTCharacter alloc] initWithName:@"均衡开启压差" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x0f coefficient:-3];
        [_charactDic setObject:balancePressureDifferentials forKey:@(balancePressureDifferentials.address)];
        _balancePressureDifferentials = balancePressureDifferentials;
        
        JXTCharacter *balanceCurrent = [[JXTCharacter alloc] initWithName:@"均衡电流" highValue:byte[3] lowValue:byte[4] unit:@"mA" address:0x10 coefficient:1];
        [_charactDic setObject:balanceCurrent forKey:@(balanceCurrent.address)];
        _balanceCurrent = balanceCurrent;
        
        JXTCharacter *baseVoltage = [[JXTCharacter alloc] initWithName:@"系统基准电压" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x11 coefficient:-3];
        [_charactDic setObject:baseVoltage forKey:@(baseVoltage.address)];
        _baseVoltage = baseVoltage;
        
        JXTCharacter *currentSensorRange = [[JXTCharacter alloc] initWithName:@"电流传感器量程" highValue:byte[3] lowValue:byte[4] unit:@"A" address:0x12 coefficient:-1];
        [_charactDic setObject:currentSensorRange forKey:@(currentSensorRange.address)];
        _currentSensorRange = currentSensorRange;
        
        JXTCharacter *launchCurrent = [[JXTCharacter alloc] initWithName:@"启动电流" highValue:byte[3] lowValue:byte[4] unit:@"A" address:0x13];
        [_charactDic setObject:launchCurrent forKey:@(launchCurrent.address)];
        _launchCurrent = launchCurrent;
        
        JXTCharacter *shortCircuitProtectionCurrent = [[JXTCharacter alloc] initWithName:@"短路保护电流" highValue:byte[3] lowValue:byte[4] unit:@"A" address:0x14];
        [_charactDic setObject:shortCircuitProtectionCurrent forKey:@(shortCircuitProtectionCurrent.address)];
        _shortCircuitProtectionCurrent = shortCircuitProtectionCurrent;
        
        JXTCharacter *delayForShortCircuitProtection = [[JXTCharacter alloc] initWithName:@"短路保护延时" highValue:byte[3] lowValue:byte[4] unit:@"us" address:0x15];
        [_charactDic setObject:delayForShortCircuitProtection forKey:@(delayForShortCircuitProtection.address)];
        _delayForShortCircuitProtection = delayForShortCircuitProtection;
        
        JXTCharacter *timeForStandby = [[JXTCharacter alloc] initWithName:@"自动待机时间" highValue:byte[3] lowValue:byte[4] unit:@"s" address:0x16];
        [_charactDic setObject:timeForStandby forKey:@(timeForStandby.address)];
        _timeForStandby = timeForStandby;
        
        JXTCharacter *overallVoltageParam = [[JXTCharacter alloc] initWithName:@"总压调节参数" highValue:byte[3] lowValue:byte[4] unit:nil address:0x17];
        [_charactDic setObject:overallVoltageParam forKey:@(overallVoltageParam.address)];
        _overallVoltageParam = overallVoltageParam;
        
        JXTCharacter *ADCData = [[JXTCharacter alloc] initWithName:@"总电压AD转换参数" highValue:byte[3] lowValue:byte[4] unit:nil address:0x17];
        [_charactDic setObject:ADCData forKey:@(ADCData.address)];
        _ADCData = ADCData;
        
        JXTCharacter *batteryBlockCount = [[JXTCharacter alloc] initWithName:@"连接串数" highValue:byte[3] lowValue:byte[4] unit:nil address:0x18];
        [_charactDic setObject:batteryBlockCount forKey:@(batteryBlockCount.address)];
        _batteryBlockCount = batteryBlockCount;
        
        JXTCharacter *highTemperatureChargeProtection = [[JXTCharacter alloc] initWithName:@"充电高温保护" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x19 isSignaled:YES];
        [_charactDic setObject:highTemperatureChargeProtection forKey:@(highTemperatureChargeProtection.address)];
        _highTemperatureChargeProtection = highTemperatureChargeProtection;
        
        JXTCharacter *highTemperatureChargeRecovery = [[JXTCharacter alloc] initWithName:@"充电高温恢复" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x1a isSignaled:YES];
        [_charactDic setObject:highTemperatureChargeRecovery forKey:@(highTemperatureChargeRecovery.address)];
        _highTemperatureChargeRecovery = highTemperatureChargeRecovery;
        
        JXTCharacter *highTemperatureDischargeProtection = [[JXTCharacter alloc] initWithName:@"放电高温保护" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x1b isSignaled:YES];
        [_charactDic setObject:highTemperatureDischargeProtection forKey:@(highTemperatureDischargeProtection.address)];
        _highTemperatureDischargeProtection = highTemperatureDischargeProtection;
        
        JXTCharacter *highTemperatureDischargeRecovery = [[JXTCharacter alloc] initWithName:@"放电高温恢复" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x1c isSignaled:YES];
        [_charactDic setObject:highTemperatureDischargeRecovery forKey:@(highTemperatureDischargeRecovery.address)];
        _highTemperatureDischargeRecovery = highTemperatureDischargeRecovery;
        
        JXTCharacter *highTemperaturePowertubeProtection = [[JXTCharacter alloc] initWithName:@"功率管高温保护" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x1d isSignaled:YES];
        [_charactDic setObject:highTemperaturePowertubeProtection forKey:@(highTemperaturePowertubeProtection.address)];
        _highTemperaturePowertubeProtection = highTemperaturePowertubeProtection;
        
        JXTCharacter *highTemperaturePowertubeRecovery = [[JXTCharacter alloc] initWithName:@"功率管高温恢复" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x1e isSignaled:YES];
        [_charactDic setObject:highTemperaturePowertubeRecovery forKey:@(highTemperaturePowertubeRecovery.address)];
        _highTemperaturePowertubeRecovery = highTemperaturePowertubeRecovery;
        
        JXTDoubleCharacter *overallCapacity = [[JXTDoubleCharacter alloc] initWithName:@"电池物理容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x20 coefficient:-6];
        [_charactDic setObject:overallCapacity forKey:@(overallCapacity.address)];
        overallCapacity.next = [[JXTCharacter alloc] initWithName:@"电池物理容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x1f coefficient:-6];
        [_charactDic setObject:overallCapacity forKey:@(overallCapacity.next.address)];
        _overallCapacity = overallCapacity;
        
        JXTDoubleCharacter *remainingCapacity = [[JXTDoubleCharacter alloc] initWithName:@"剩余容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x22 coefficient:-6];
        [_charactDic setObject:remainingCapacity forKey:@(remainingCapacity.address)];
        remainingCapacity.next = [[JXTCharacter alloc] initWithName:@"剩余容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x21 coefficient:-6];
        [_charactDic setObject:remainingCapacity forKey:@(remainingCapacity.next.address)];
        _remainingCapacity = remainingCapacity;
        
        JXTDoubleCharacter *cycleCapacity = [[JXTDoubleCharacter alloc] initWithName:@"总循环容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x24 coefficient:-3];
        cycleCapacity.readOnly = YES;
        [_charactDic setObject:cycleCapacity forKey:@(cycleCapacity.address)];
        cycleCapacity.next = [[JXTCharacter alloc] initWithName:@"总循环容量" highValue:byte[3] lowValue:byte[4] unit:@"AH" address:0x23 coefficient:-3];
        [_charactDic setObject:cycleCapacity forKey:@(cycleCapacity.next.address)];
        _cycleCapacity = cycleCapacity;
        
        JXTCharacter *lowTemperatureChargeProtection = [[JXTCharacter alloc] initWithName:@"充电低温保护" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x25 isSignaled:YES];
        [_charactDic setObject:lowTemperatureChargeProtection forKey:@(lowTemperatureChargeProtection.address)];
        _lowTemperatureChargeProtection = lowTemperatureChargeProtection;
        
        JXTCharacter *lowTemperatureChargeRecovery = [[JXTCharacter alloc] initWithName:@"充电低温恢复" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x26 isSignaled:YES];
        [_charactDic setObject:lowTemperatureChargeRecovery forKey:@(lowTemperatureChargeRecovery.address)];
        _lowTemperatureChargeRecovery = lowTemperatureChargeRecovery;
        
        JXTCharacter *lowTemperatureDischargeProtection = [[JXTCharacter alloc] initWithName:@"放电低温保护" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x27 isSignaled:YES];
        [_charactDic setObject:lowTemperatureDischargeProtection forKey:@(lowTemperatureDischargeProtection.address)];
        _lowTemperatureDischargeProtection = lowTemperatureDischargeProtection;
        
        JXTCharacter *lowTemperatureDischargeRecovery = [[JXTCharacter alloc] initWithName:@"放电低温恢复" highValue:byte[3] lowValue:byte[4] unit:@"℃" address:0x28 isSignaled:YES];
        [_charactDic setObject:lowTemperatureDischargeRecovery forKey:@(lowTemperatureDischargeRecovery.address)];
        _lowTemperatureDischargeRecovery = lowTemperatureDischargeRecovery;
        
        JXTCharacter *wheelLength = [[JXTCharacter alloc] initWithName:@"一周轮胎长度" highValue:byte[3] lowValue:byte[4] unit:@"mm" address:0x29];
        [_charactDic setObject:wheelLength forKey:@(wheelLength.address)];
        _wheelLength = wheelLength;
        
        JXTCharacter *frequence = [[JXTCharacter alloc] initWithName:@"一周脉冲次数" highValue:byte[3] lowValue:byte[4] unit:nil address:0x2a];
        [_charactDic setObject:frequence forKey:@(frequence.address)];
        _frequence = frequence;
        
        JXTCharacter *shutdownVoltage = [[JXTCharacter alloc] initWithName:@"自动关机电压" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x2b coefficient:-3];
        [_charactDic setObject:shutdownVoltage forKey:@(shutdownVoltage.address)];
        _shutdownVoltage = shutdownVoltage;
        
        JXTCharacter *protectVoltage = [[JXTCharacter alloc] initWithName:@"单体压差保护" highValue:byte[3] lowValue:byte[4] unit:@"V" address:0x2c coefficient:-3];
        [_charactDic setObject:protectVoltage forKey:@(protectVoltage.address)];
        _protectVoltage = protectVoltage;
        
        JXTCharacter *modelCounter = [[JXTCharacter alloc] initWithName:@"从机模块数" highValue:byte[3] lowValue:byte[4] unit:nil address:0x2d];
        [_charactDic setObject:modelCounter forKey:@(modelCounter.address)];
        _modelCounter = modelCounter;
        
        JXTCharacter *compensateResistance = [[JXTCharacter alloc] initWithName:@"欠压内阻补偿" highValue:byte[3] lowValue:byte[4] unit:@"mΩ" address:0x2e];
        [_charactDic setObject:compensateResistance forKey:@(compensateResistance.address)];
        _compensateResistance = compensateResistance;
        
        JXTCharacter *staticCurrent = [[JXTCharacter alloc] initWithName:@"静态消耗电流" highValue:byte[3] lowValue:byte[4] unit:@"mA" address:0x2F];
        [_charactDic setObject:staticCurrent forKey:@(staticCurrent.address)];
        _staticCurrent = staticCurrent;
        
        JXTCharacter *temperatureSensorShield = [[JXTCharacter alloc] initWithName:@"温度传感器屏蔽" highValue:byte[3] lowValue:byte[4] unit:nil address:0x30];
        [_charactDic setObject:temperatureSensorShield forKey:@(temperatureSensorShield.address)];
        _temperatureSensorShield = temperatureSensorShield;
        
        JXTCharacter *bleAddress = [[JXTCharacter alloc] initWithName:@"蓝牙地址编码" highValue:byte[3] lowValue:byte[4] unit:nil address:0x31];
        [_charactDic setObject:bleAddress forKey:@(bleAddress.address)];
        _bleAddress = bleAddress;
        
        JXTCharacter *version = [[JXTCharacter alloc] initWithName:@"固件版本" highValue:byte[3] lowValue:byte[4] unit:nil address:0x5a];
        [_charactDic setObject:version forKey:@(version.address)];
        version.readOnly = YES;
        _version = version;
        
        JXTCharacter *secondlevelProtectCurrent = [[JXTCharacter alloc] initWithName:@"二级过流保护" highValue:byte[3] lowValue:byte[4] unit:@"mA" address:0xa2];
        [_charactDic setObject:secondlevelProtectCurrent forKey:@(secondlevelProtectCurrent.address)];
        _secondlevelProtectCurrent = secondlevelProtectCurrent;
        
        JXTCharacter *secondlevelProtectDelay = [[JXTCharacter alloc] initWithName:@"二级过流延时" highValue:byte[3] lowValue:byte[4] unit:@"ms" address:0xa3];
        [_charactDic setObject:secondlevelProtectDelay forKey:@(secondlevelProtectDelay.address)];
        _secondlevelProtectDelay = secondlevelProtectDelay;
        
        _internalResistanceArray = [NSMutableArray array];
        for (Byte addr = 0x33; addr <= 0x4a; addr++) {
            JXTCharacter *c = [[JXTCharacter alloc] initWithName:[NSString stringWithFormat:@"连接内阻%d", addr-50] highValue:byte[3] lowValue:byte[4] unit:@"mΩ" address:addr coefficient:-1];
            [_charactDic setObject:c forKey:@(c.address)];
            [_internalResistanceArray addObject:c];
        }
        
        NSUInteger soc = 100;
        _socArray = [NSMutableArray array];
        for (Byte addr = 0x96; addr <= 0xa0; addr++) {
            JXTCharacter *c = [[JXTCharacter alloc] initWithName:[NSString stringWithFormat:@"%lu%% SOC", (unsigned long)soc] highValue:byte[3] lowValue:byte[4] unit:@"V" address:addr coefficient:-3];
            [_charactDic setObject:c forKey:@(c.address)];
            [_socArray addObject:c];
            soc -= 10;
        }
        
        JXTCharacter * initialSOC = [[JXTCharacter alloc] initWithName:@"初始SOC" highValue:byte[3] lowValue:byte[4] unit:nil address:0xed];
        [_charactDic setObject:initialSOC forKey:@(initialSOC.address)];
        _initialSOC = initialSOC;
        
        JXTCharacter *underWarningSOC = [[JXTCharacter alloc] initWithName:@"SOC过低告警" highValue:byte[3] lowValue:byte[4] unit:nil address:0xee];
        [_charactDic setObject:underWarningSOC forKey:@(underWarningSOC.address)];
        _underWarningSOC = underWarningSOC;
        
        JXTCharacter * lithiumTitanate = [[JXTCharacter alloc] initWithName:@"钛酸锂参数" highValue:byte[3] lowValue:byte[4] unit:nil address:0xf0];
        lithiumTitanate.sendDefaultValueOnly = YES;
        [_charactDic setObject:lithiumTitanate forKey:@(lithiumTitanate.address)];
        _lithiumTitanate = lithiumTitanate;
        
        JXTCharacter *lithiumFer = [[JXTCharacter alloc] initWithName:@"铁锂参数" highValue:byte[3] lowValue:byte[4] unit:nil address:0xfb];
        lithiumFer.sendDefaultValueOnly = YES;
        [_charactDic setObject:lithiumFer forKey:@(lithiumFer.address)];
        _lithiumFer = lithiumFer;
        
        JXTLongCharacter * serialNumber = [[JXTLongCharacter alloc] initWithName:@"出厂序列号" highValue:byte[3] lowValue:byte[4] unit:nil address:0xe5];
        serialNumber.readOnly = YES;
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSInteger i = 229; i <= 236; i++) {
            JXTCharacter *subSerial = [[JXTCharacter alloc] initWithName:@"出厂序列号" highValue:byte[3] lowValue:byte[4] unit:nil address:i];
            [tmpArr addObject:subSerial];
            [_charactDic setObject:subSerial forKey:@(subSerial.address)];
        }
        serialNumber.charcterList = [tmpArr copy];
        _serialNumber = serialNumber;
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

- (JXTCharacter *)updateCharacterWithData:(NSData *)data {
    Byte *b = [BabyToy ConvertDataToByteArray:data];
    Byte address = b[2];
    Byte high = b[3];
    Byte low = b[4];
    id obj = _charactDic[@(address)];
    if ([obj isKindOfClass:[JXTDoubleCharacter class]]) {
        JXTDoubleCharacter *doubleCharacter = (JXTDoubleCharacter *)obj;
        if (doubleCharacter.address == address ) {
            if (high == doubleCharacter.highValue && low == doubleCharacter.lowValue && 0 == doubleCharacter.settingValueText.length) {
                return nil;
            }
            doubleCharacter.highValue = high;
            doubleCharacter.lowValue = low;
            doubleCharacter.settingValueText = nil;
            return doubleCharacter;
        } else if (doubleCharacter.next.address == address) {
            if (high == doubleCharacter.next.highValue && low == doubleCharacter.next.lowValue && 0 == doubleCharacter.settingValueText.length) {
                return nil;
            }
            doubleCharacter.next.highValue = high;
            doubleCharacter.next.lowValue = low;
            doubleCharacter.settingValueText = nil;
            return doubleCharacter;
        }
    } else {
        JXTCharacter *character = (JXTCharacter *)obj;
        if (character.address == address ) {
            if (high == character.highValue && low == character.lowValue && 0 == character.settingValueText.length) {
                return nil;
            }
            character.highValue = high;
            character.lowValue = low;
            character.settingValueText = nil;
            return character;
        }
    }
    
    return nil;
}


@end
