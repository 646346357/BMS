//
//  JXTBluetooth.h
//  BMS
//
//  Created by admin on 2019/2/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JXTBluetoothAddress) {
    JXTBluetoothAddressOverWarningVoltage = 0x01,
    JXTBluetoothAddressUnderWarningVoltage = 0x02,
    JXTBluetoothAddressOverProtectVoltage = 0x03,
    JXTBluetoothAddressUnderProtectVoltage = 0x04,
    JXTBluetoothAddressOverRecoverVoltage = 0x05,
    JXTBluetoothAddressUnderRecoverVoltage = 0x06,
    JXTBluetoothAddressOverProtectOverallVoltage = 0x07,
    JXTBluetoothAddressUnderProtectOverallVoltage = 0x08,
    JXTBluetoothAddressOverProtectChargeCurrent = 0x09,
    JXTBluetoothAddressDelayForOverProtectChargeCurrent = 0x0a,
    JXTBluetoothAddressOverProtectDischargeCurrent = 0x0b,
    JXTBluetoothAddressDelayForOverProtectDischargeCurrent = 0x0c,
    JXTBluetoothAddressLimitBalanceVoltage = 0x0d,
    JXTBluetoothAddressBalanceWorkVoltage = 0x0e,
    JXTBluetoothAddressBalancePressureDifferentials = 0x0f,
    JXTBluetoothAddressBalanceCurrent = 0x10,
    JXTBluetoothAddressBaseVoltage = 0x11,
    JXTBluetoothAddressCurrentSensorRange = 0x12,
    JXTBluetoothAddressLaunchCurrent = 0x13,
    JXTBluetoothAddressShortCircuitProtectionCurrent = 0x14,
    JXTBluetoothAddressDelayForShortCircuitProtection = 0x15,
    JXTBluetoothAddressTimeForStandby = 0x16,
    JXTBluetoothAddressADCData = 0x17,
    JXTBluetoothAddressBatteryBlockCount = 0x18,
    JXTBluetoothAddressHighTemperatureChargeProtection = 0x19,
    JXTBluetoothAddressHighTemperatureChargeRecovery = 0x1a,
    JXTBluetoothAddressHighTemperatureDischargeProtection = 0x1b,
    JXTBluetoothAddressHighTemperatureDischargeRecovery = 0x1c,
    JXTBluetoothAddressHighTemperaturePowertubeProtection = 0x1d,
    JXTBluetoothAddressHighTemperaturePowertubeRecovery = 0x1e,
    JXTBluetoothAddressLowOverallCapacity = 0x1f,
    JXTBluetoothAddressHighOverallCapacity = 0x20,
    JXTBluetoothAddressLowRemainingCapacity = 0x21,
    JXTBluetoothAddressHighRemainingCapacity = 0x22,
    JXTBluetoothAddressLowCycleCapacity = 0x23,
    JXTBluetoothAddressHighCycleCapacity = 0x24,
    JXTBluetoothAddressWheelLength = 0x29,
    JXTBluetoothAddressFrequence = 0x2a,
    JXTBluetoothAddressShutdownVoltage = 0x2b,
    JXTBluetoothAddressProtectVoltage = 0x2c,
    JXTBluetoothAddressModelCounter = 0x2d,
    JXTBluetoothAddressCompensateResistance = 0x2e,
    JXTBluetoothAddressStaticCurrent = 0x2f,
    JXTBluetoothAddressTemperatureSensorShield = 0x30,
    JXTBluetoothAddressBleAddress = 0x31,
    JXTBluetoothAddressInternalResistance0 = 0x33,
    JXTBluetoothAddressInternalResistance1 = 0x34,
    JXTBluetoothAddressInternalResistance2 = 0x35,
    JXTBluetoothAddressInternalResistance3 = 0x36,
    JXTBluetoothAddressInternalResistance4 = 0x37,
    JXTBluetoothAddressInternalResistance5 = 0x38,
    JXTBluetoothAddressInternalResistance6 = 0x39,
    JXTBluetoothAddressInternalResistance7 = 0x3a,
    JXTBluetoothAddressInternalResistance8 = 0x3b,
    JXTBluetoothAddressInternalResistance9 = 0x3c,
    JXTBluetoothAddressInternalResistance10 = 0x3d,
    JXTBluetoothAddressInternalResistance11 = 0x3e,
    JXTBluetoothAddressInternalResistance12 = 0x3f,
    JXTBluetoothAddressInternalResistance13 = 0x40,
    JXTBluetoothAddressInternalResistance14 = 0x41,
    JXTBluetoothAddressInternalResistance15 = 0x42,
    JXTBluetoothAddressInternalResistance16 = 0x43,
    JXTBluetoothAddressInternalResistance17 = 0x44,
    JXTBluetoothAddressInternalResistance18 = 0x45,
    JXTBluetoothAddressInternalResistance19 = 0x46,
    JXTBluetoothAddressInternalResistance20 = 0x47,
    JXTBluetoothAddressInternalResistance21 = 0x48,
    JXTBluetoothAddressInternalResistance22 = 0x49,
    JXTBluetoothAddressInternalResistance23 = 0x4a,
    
    JXTBluetoothAddressBMSVersion = 0x5a,
    JXTBluetoothAddressRunningTime = 0x64,
    
    JXTBluetoothAddressSOCVoltage0 = 0x96,
    JXTBluetoothAddressSOCVoltage1 = 0x97,
    JXTBluetoothAddressSOCVoltage2 = 0x98,
    JXTBluetoothAddressSOCVoltage3 = 0x99,
    JXTBluetoothAddressSOCVoltage4 = 0x9a,
    JXTBluetoothAddressSOCVoltage5 = 0x9b,
    JXTBluetoothAddressSOCVoltage6 = 0x9c,
    JXTBluetoothAddressSOCVoltage7 = 0x9d,
    JXTBluetoothAddressSOCVoltage8 = 0x9e,
    JXTBluetoothAddressSOCVoltage9 = 0x9f,
    JXTBluetoothAddressSOCVoltage10 = 0xa0,
    JXTBluetoothAddressSecondlevelProtectCurrent = 0xa2,
    JXTBluetoothAddressSecondlevelProtectDelay = 0xa3,
    
    JXTBluetoothAddressScreenSwitching =0xe4,
    JXTBluetoothAddressInitialSOC =0xed,
    JXTBluetoothAddressSOCLowWarning =0xee,
    JXTBluetoothAddressSystemUpdate =0xef,
    
    JXTBluetoothAddressTitaniumFerArgument = 0xf0,
    JXTBluetoothAddressChangeBle = 0xf6,
    JXTBluetoothAddressCloseBMSPower = 0xf7,
    JXTBluetoothAddressClearBMSCurrent = 0xf8,
    JXTBluetoothAddressDischargeMOS = 0xf9,
    JXTBluetoothAddressChargeMOS = 0xfa,
    JXTBluetoothAddressLithiumFerArgument = 0xfb,
    JXTBluetoothAddressAutoBalance = 0xfc,
    JXTBluetoothAddressRestoreFactorySettings = 0xfd,
    JXTBluetoothAddressRebootBMS = 0xfe,
};

typedef void(^JXTBluetoothUpdateBlock)(BOOL isSccess);

@interface JXTBluetooth : NSObject

@property (nonatomic, strong, readonly) BabyBluetooth *baby;
@property (nonatomic, strong) CBPeripheral *currentPeripheral;
@property (nonatomic, strong) CBCharacteristic *characteristic;
@property (nonatomic, assign) BOOL peripheralConnnected;

+ (instancetype)sharedInstance;

#pragma mark - 设备连接/断开
//连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral;
//断开连接
- (void)cancelConnect;

#pragma mark - 初始数据
//读BMS初始数据<140Byte>
- (void)readBMSInitialData;

#pragma mark - 设备控制
//屏幕切换
- (void)switchingScreen;
//关闭BMS电源
- (void)closeBMSPower;
//电流归零
- (void)clearBMSCurrent;
//打开放电MOS管开关
- (void)openDischargeMOS;
//关闭放电MOS管开关
- (void)closeDischargeMOS;
//读放电MOS管开关状态
- (void)readDischargeMOS;
//打开充电MOS管开关
- (void)openChargeMOS;
//关闭充电MOS管开关
- (void)closeChargeMOS;
//读充电MOS管开关状态
- (void)readChargeMOS;
//将参数更改成铁锂
- (void)configLithiumFerArgument;
//电池自动均衡
- (void)configAutoBalance;
//出厂设置
- (void)configRestoreFactorySettings;
//重启
- (void)rebootBMS;
//将参数更改成钛锂
- (void)configTitaniumFerArgument;
//更改蓝牙地址
- (void)changeBleAddress:(NSUInteger)address;
//系统升级
- (void)systemUpdateWithData:(NSData *)binData completion:(JXTBluetoothUpdateBlock)block;
//验证密码
- (void)verifyPassword:(NSString *)password;
//修改密码
- (void)modifyPassword:(NSString *)password;

#pragma mark - 设备读写数据
//发送蓝牙指令
- (void)sendWriteOrderWithBytes:(Byte *)b;
//读全部设备数据
- (void)readAllData;
//读取固件版本
- (void)readBMSVersion;
//读单体过压告警电压 0.001V
- (void)readOverWarningVoltage;
//写单体过压告警电压 0.001V
- (void)writeOverWarningVoltage:(double)v;
//读体欠压告警电压 0.001V
- (void)readUnderWarningVoltage;
//写单体欠压告警电压 0.001V
- (void)writeUnderWarningVoltage:(double)v;
//读单体过压保护电压 0.001V
- (void)readOverProtectVoltage;
//写单体过压保护电压 0.001V
- (void)writeOverProtectVoltage:(double)v;
//读体欠压保护电压 0.001V
- (void)readUnderProtectVoltage;
//写单体欠压保护电压 0.001V
- (void)writeUnderProtectVoltage:(double)v;
//读单体过压恢复 0.001V
- (void)readOverRecoverVoltage;
//写单体过压恢复 0.001V
- (void)writeOverRecoverVoltage:(double)v;
//读单体欠压恢复 0.001V
- (void)readUnderRecoverVoltage;
//写单体欠压恢复 0.001V
- (void)writeUnderRecoverVoltage:(double)v;
//读总压过压保护电压  0.1V
- (void)readOverProtectOverallVoltage;
//写总压过压保护电压  0.1V
- (void)writeOverProtectOverallVoltage:(double)v;
//读总压欠压保护电压   0.1V
- (void)readUnderProtectOverallVoltage;
//写总压欠压保护电压   0.1V
- (void)writeUnderProtectOverallVoltage:(double)v;
//读充电过流保护  0.1A
- (void)readOverProtectChargeCurrent;
//写充电过流保护  0.1A
- (void)writeOverProtectChargeCurrent:(double)current;
//读充电过流保护延时  秒
- (void)readDelayForOverProtectChargeCurrent;
//写充电过流保护延时  秒
- (void)writeDelayForOverProtectChargeCurrent:(NSInteger)delay;
//读放电过流保护      0.1A
- (void)readOverProtectDischargeCurrent;
//写放电过流保护      0.1A
- (void)writeOverProtectDischargeCurrent:(double)current;
//读放电过流保护延时    秒
- (void)readDelayForOverProtectDischargeCurrent;
//写放电过流保护延时    秒
- (void)writeDelayForOverProtectDischargeCurrent:(NSInteger)delay;
//读均衡极限电压      0.001V
- (void)readLimitBalanceVoltage;
//写均衡极限电压      0.001V
- (void)writeLimitBalanceVoltage:(double)v;
//读充电时均衡起控电压  0.001V
- (void)readBalanceWorkVoltage;
//写充电时均衡起控电压  0.001V
- (void)writeBalanceWorkVoltage:(double)v;
//读均衡压差 0.001V
- (void)readBalancePressureDifferentials;
//写均衡压差 0.001V
- (void)writeBalancePressureDifferentials:(double)v;
//读均衡电流 取值 +(1-20)*10
- (void)readBalanceCurrent;
//写均衡电流 取值 +(1-20)*10
- (void)writeBalanceCurrent:(double)current;
//读系统基准电压     0.1V
- (void)readBaseVoltage;
//写系统基准电压     0.1V
- (void)writeBaseVoltage:(double)v;
//读电流传感器量程    0.1A
- (void)readCurrentSensorRange;
//写电流传感器量程    0.1A
- (void)writeCurrentSensorRange:(double)current;
//读启动电流 0.1A
- (void)readLaunchCurrent;
//写启动电流 0.1A
- (void)writeLaunchCurrent:(double)current;
//读短路保护电流 0.1A
- (void)readShortCircuitProtectionCurrent;
//写短路保护电流 0.1A
- (void)writeShortCircuitProtectionCurrent:(double)current;
//读短路保护延时 us
- (void)readDelayForShortCircuitProtection;
//写短路保护延时 us
- (void)writeDelayForShortCircuitProtection:(NSInteger)delay;
//读无电流自动待机时间 秒
- (void)readTimeForStandby;
//写无电流自动待机时间 秒
- (void)writeTimeForStandby:(NSInteger)time;
//读总电压AD值转换成实际电压值的参数0000(4位整数)  U16
- (void)readADCData;
//写总电压AD值转换成实际电压值的参数0000(4位整数)  U16
- (void)writeADCData:(uint16_t)data;
//读设置的电池串数   U8
- (void)readBatteryBlockCount;
//写设置的电池串数   U8
- (void)writeBatteryBlockCount:(uint8_t)count;
//读电池高温充电保护   ±0.1 摄氏度
- (void)readHighTemperatureChargeProtection;
//写电池高温充电保护   ±0.1 摄氏度
- (void)writeHighTemperatureChargeProtection:(double)t;
//读电池高温充电恢复   ±0.1 摄氏度
- (void)readHighTemperatureChargeRecovery;
//写电池高温充电恢复   ±0.1 摄氏度
- (void)writeHighTemperatureChargeRecovery:(double)t;
//读电池高温放电保护
- (void)readHighTemperatureDischargeProtection;
//写电池高温放电保护
- (void)writeHighTemperatureDischargeProtection:(double)t;
//读电池高温放电恢复
- (void)readHighTemperatureDischargeRecovery;
//写电池高温放电恢复
- (void)writeHighTemperatureDischargeRecovery:(double)t;
//读功率管高温保护
- (void)readHighTemperaturePowertubeProtection;
//写功率管高温保护
- (void)writeHighTemperaturePowertubeProtection:(double)t;
//读功率管高温恢复
- (void)readHighTemperaturePowertubeRecovery;
//写功率管高温恢复
- (void)writeHighTemperaturePowertubeRecovery:(double)t;
//读电池物理容量<高字节>  .000 000AH (2个空间)(31低，32高)
- (void)readHighOverallCapacity;
//写电池物理容量<高字节>  .000 000AH (2个空间)(31低，32高)
- (void)writeHighOverallCapacity:(double)ah;
//读电池物理容量<低字节>  .000 000AH (2个空间)(31低，32高)
- (void)readLowOverallCapacity;
//写电池物理容量<低字节>  .000 000AH (2个空间)(31低，32高)
- (void)writeLowOverallCapacity:(double)ah;
//读电池剩余容量<高字节>  .000 000AH (2个空间)(33低，34高)
- (void)readHighRemainingCapacity;
//写电池剩余容量<高字节>  .000 000AH (2个空间)(33低，34高)
- (void)writeHighRemainingCapacity:(double)ah;
//读电池剩余容量<低字节>  .000 000AH (2个空间)(33低，34高)
- (void)readLowRemainingCapacity;
//写电池剩余容量<低字节>  .000 000AH (2个空间)(33低，34高)
- (void)writeLowRemainingCapacity:(double)ah;
//读总共循环容量<高字节>  .000 000AH (2个空间)(35低，36高)
- (void)readHighCycleCapacity;
//写总共循环容量<高字节>  .000 000AH (2个空间)(35低，36高)
- (void)writeHighCycleCapacity:(double)ah;
//读总共循环容量<低字节>  .000 000AH (2个空间)(35低，36高)
- (void)readLowCycleCapacity;
//写总共循环容量<低字节>  .000 000AH (2个空间)(35低，36高)
- (void)writeLowCycleCapacity:(double)ah;
//读轮胎长度
- (void)readWheelLength;
//写轮胎长度
- (void)writeWheelLength:(NSInteger)length;
//读一周脉冲次数
- (void)readFrequence;
//写一周脉冲次数 
- (void)writeFrequence:(NSUInteger)frequence;
//读自动关机电压
- (void)readShutdownVoltage;
//写自动关机电压
- (void)writeShutdownVoltage:(double)v;
//读单体压差保护
- (void)readProtectVoltage;
//写单体压差保护
- (void)writeProtectVoltage:(double)v;
//从机模块数
- (void)readModelCounter;
//从机模块数
- (void)writeModelCounter:(NSUInteger)counter;
//读欠压内阻补偿 .1mΩ
- (void)readCompensateResistance;
//写欠压内阻补偿 .1mΩ
- (void)writeCompensateResistance:(double)r;
//读静态消耗电流 .1mA
- (void)readStaticCurrent;
//写静态消耗电流 .1mA
- (void)writeStaticCurrent:(double)a;
//读温度传感器屏蔽
- (void)readTemperatureSensorShield;
//写温度传感器屏蔽
- (void)writeTemperatureSensorShield:(NSUInteger)t;
//读蓝牙地址编码
- (void)readBleAddress;
//写蓝牙地址编码
- (void)writeBleAddress:(NSUInteger)addr;
//读静态电压SOC对应表 (0%-100%)
- (void)readSOCVoltage;
//写静态电压SOC对应表 (0%-100%)
- (void)writeSOCVoltage:(double)v address:(Byte)address;
//读二级放电过流保护
- (void)readSecondlevelProtectCurrent;
//写二级放电过流保护
- (void)writeSecondlevelProtectCurrent:(NSUInteger)a;
//读二级放电过流保护延时
- (void)readSecondlevelProtectDelay;
//写二级放电过流保护延时
- (void)writeSecondlevelProtectDelay:(NSUInteger)t;
//读电池内阻（51-74）0.1mΩ
- (void)readInternalResistance;
//写电池内阻（51-74）0.1mΩ
- (void)writeInternalResistance:(double)r address:(Byte)address;
//读运行时间（70-71两个空间）
- (void)readRunningTime;
//写运行时间（70-71两个空间）
- (void)writeRunningTime:(NSUInteger)sec;
//读出厂序列号
- (void)readSerialNumber;

@end


