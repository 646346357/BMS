//
//  JXTBluetooth.m
//  BMS
//
//  Created by admin on 2019/2/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTBluetooth.h"

//CRC校验
uint16_t GetCRC16(unsigned char *ptr,  unsigned char len) {
    uint16_t index;
    unsigned char crch = 0xFF;  //高CRC字节
    unsigned char crcl = 0xFF;  //低CRC字节
    const unsigned char  TabH[] = {  //CRC高位字节值表
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
        0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
        0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
        0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
        0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
        0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
        0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
        0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
        0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
        0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
        0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
        0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
        0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
        0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
        0x80, 0x41, 0x00, 0xC1, 0x81, 0x40
    } ;
    const unsigned char  TabL[] = {  //CRC低位字节值表
        0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06,
        0x07, 0xC7, 0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD,
        0x0F, 0xCF, 0xCE, 0x0E, 0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09,
        0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9, 0x1B, 0xDB, 0xDA, 0x1A,
        0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC, 0x14, 0xD4,
        0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
        0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3,
        0xF2, 0x32, 0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4,
        0x3C, 0xFC, 0xFD, 0x3D, 0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A,
        0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38, 0x28, 0xE8, 0xE9, 0x29,
        0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF, 0x2D, 0xED,
        0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
        0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60,
        0x61, 0xA1, 0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67,
        0xA5, 0x65, 0x64, 0xA4, 0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F,
        0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB, 0x69, 0xA9, 0xA8, 0x68,
        0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA, 0xBE, 0x7E,
        0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
        0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71,
        0x70, 0xB0, 0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92,
        0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C,
        0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E, 0x5A, 0x9A, 0x9B, 0x5B,
        0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89, 0x4B, 0x8B,
        0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
        0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42,
        0x43, 0x83, 0x41, 0x81, 0x80, 0x40
    } ;
    while (len--)  //计算指定长度的CRC
    {
        index = crch ^ *ptr++;
        crch = crcl ^ TabH[ index];
        crcl = TabL[ index];
    }
    
    return ((crch<<8) | crcl);
}

static const NSTimeInterval kupdateTimeout = 90;

@interface JXTBluetooth() {
    
}

@property (nonatomic, strong) NSMutableData *infoData;
@property (nonatomic, strong) NSTimer *refreshTimer;
@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) NSData *binFileData;
@property (nonatomic, copy) JXTBluetoothUpdateBlock updateBlock;
@property (nonatomic, assign) BOOL isUpdate;

+(instancetype) new __attribute__((unavailable("JXTBluetooth类只能初始化一次")));
-(instancetype) copy __attribute__((unavailable("JXTBluetooth类只能初始化一次")));
-(instancetype) mutableCopy  __attribute__((unavailable("JXTBluetooth类只能初始化一次")));

@end

@implementation JXTBluetooth

#pragma mark - Life Cycle

static JXTBluetooth *_instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JXTBluetooth alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _baby = [BabyBluetooth shareBabyBluetooth];
        [self setupBabyBlock];
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

#pragma mark - Public Method<设备连接/断开>
//连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral {
    self.currentPeripheral = peripheral;
    [self.baby AutoReconnect:peripheral];
    self.baby.having(peripheral).connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

//断开连接
- (void)cancelConnect {
    if (self.currentPeripheral) {
        [self.baby AutoReconnectCancel:self.currentPeripheral];
        [self.baby cancelPeripheralConnection:self.currentPeripheral];
    }
    
    [self.baby cancelAllPeripheralsConnection];
    self.currentPeripheral = nil;
}

#pragma mark - Public Method<初始数据>

//读BMS初始数据<140Byte>
- (void)readBMSInitialData {
    [self private_sendOperateOrderWithFrameHeadHigh:0xdb frameLowHead:0xdb ddress:0 highByte:0 lowByte:0];
}

#pragma mark - Public Method<设备控制>

//屏幕切换
- (void)switchingScreen {//228
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressScreenSwitching];
}

//关闭BMS电源
- (void)closeBMSPower {//247
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressCloseBMSPower];
}

//打开放电MOS管开关
- (void)clearBMSCurrent {//248
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressClearBMSCurrent];
}

//打开放电MOS管开关
- (void)openDischargeMOS; {//249
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressDischargeMOS highByte:0 lowByte:0x01];
}

//关闭放电MOS管开关
- (void)closeDischargeMOS {//249 数据为0 强制关闭
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressDischargeMOS];
}

//读放电MOS管开关状态
- (void)readDischargeMOS {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressDischargeMOS];
}

//打开充电MOS管开关
- (void)openChargeMOS {//250
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressChargeMOS highByte:0 lowByte:0x01];
}

//关闭充电MOS管开关
- (void)closeChargeMOS {//250 数据为0 强制关闭
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressChargeMOS];
}

//读充电MOS管开关状态
- (void)readChargeMOS {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressChargeMOS];
}

//将参数更改成铁锂
- (void)configLithiumFerArgument {//251
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLithiumFerArgument];
}

//电池自动均衡
- (void)configAutoBalance {//252
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressAutoBalance];
}

//出厂设置
- (void)configRestoreFactorySettings {//253
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressRestoreFactorySettings];
}

//重启
- (void)rebootBMS {//254
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressRebootBMS];
}

//将参数更改成钛锂
- (void)configTitaniumFerArgument {
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressTitaniumFerArgument];
}

//更改蓝牙地址
- (void)changeBleAddress:(NSUInteger)address {
    uint16_t v_16 = address;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressChangeBle highByte:high lowByte:low];
}

//系统升级
- (void)systemUpdateWithData:(NSData *)binData completion:(JXTBluetoothUpdateBlock)block {
    self.updateBlock = [block copy];
    self.binFileData = binData;
    self.isUpdate = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    });
    
    [self performSelector:@selector(systemUpdateTimeout) withObject:nil afterDelay:kupdateTimeout];
}

//验证密码
- (void)verifyPassword:(NSString *)password {
    [self private_settingPassword:password beginAddr:241];
}

//修改密码
- (void)modifyPassword:(NSString *)password {
    [self private_settingPassword:password beginAddr:102];
}

#pragma mark - Public Method<设备读写数据>

//发送蓝牙指令
- (void)sendWriteOrderWithBytes:(Byte *)b {
    [self private_sendWriteOrderWithAddress:b[2] highByte:b[3] lowByte:b[4]];
}

//读全部设备数据
- (void)readAllData {
    [self readBMSVersion];
    [self readOverWarningVoltage];
    [self readUnderWarningVoltage];
    [self readOverProtectVoltage];
    [self readUnderProtectVoltage];
    [self readOverRecoverVoltage];
    [self readUnderRecoverVoltage];
    [self readOverProtectOverallVoltage];
    [self readUnderProtectOverallVoltage];
    [self readOverProtectChargeCurrent];
    [self readDelayForOverProtectChargeCurrent];
    [self readOverProtectDischargeCurrent];
    [self readDelayForOverProtectDischargeCurrent];
    [self readLimitBalanceVoltage];
    [self readBalanceWorkVoltage];
    [self readBalancePressureDifferentials];
    [self readBalanceCurrent];
    [self readBaseVoltage];
    [self readCurrentSensorRange];
    [self readLaunchCurrent];
    [self readShortCircuitProtectionCurrent];
    [self readDelayForShortCircuitProtection];
    [self readTimeForStandby];
    [self readADCData];
    [self readBatteryBlockCount];
    [self readHighTemperatureChargeProtection];
    [self readHighTemperatureChargeRecovery];
    [self readHighTemperatureDischargeProtection];
    [self readHighTemperatureDischargeRecovery];
    [self readHighTemperaturePowertubeProtection];
    [self readHighTemperaturePowertubeRecovery];
    [self readInternalResistance];
    [self readHighOverallCapacity];
    [self readLowOverallCapacity];
    [self readHighRemainingCapacity];
    [self readLowRemainingCapacity];
    [self readHighCycleCapacity];
    [self readLowCycleCapacity];
    [self readWheelLength];
    [self readFrequence];
    [self readShutdownVoltage];
    [self readProtectVoltage];
    [self readModelCounter];
    [self readCompensateResistance];
    [self readStaticCurrent];
    [self readTemperatureSensorShield];
    [self readBleAddress];
    [self readSOCVoltage];
    [self readSecondlevelProtectCurrent];
    [self readSecondlevelProtectDelay];
    [self readInitialSOC];
    [self readSOCLowWarning];
    [self readSerialNumber];
}

//读取固件版本
- (void)readBMSVersion {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBMSVersion];
}

//读单体过压告警电压 0.001V
- (void)readOverWarningVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverWarningVoltage];
}

//写单体过压告警电压 0.001V
- (void)writeOverWarningVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverWarningVoltage highByte:high lowByte:low];
}

//读体欠压告警电压 0.001V
- (void)readUnderWarningVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressUnderWarningVoltage];
}

//写单体欠压告警电压 0.001V
- (void)writeUnderWarningVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressUnderWarningVoltage highByte:high lowByte:low];
}

//读单体过压保护电压 0.001V
- (void)readOverProtectVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverProtectVoltage];
}

//写单体过压保护电压 0.001V
- (void)writeOverProtectVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverProtectVoltage highByte:high lowByte:low];
}

//读体欠压保护电压 0.001V
- (void)readUnderProtectVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressUnderProtectVoltage];
}

//写单体欠压保护电压 0.001V
- (void)writeUnderProtectVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressUnderProtectVoltage highByte:high lowByte:low];
}

//读单体过压恢复 0.001V
- (void)readOverRecoverVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverRecoverVoltage];
}

//写单体过压恢复 0.001V
- (void)writeOverRecoverVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverRecoverVoltage highByte:high lowByte:low];
}

//读单体欠压恢复 0.001V
- (void)readUnderRecoverVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressUnderRecoverVoltage];
}

//写单体欠压恢复 0.001V
- (void)writeUnderRecoverVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressUnderRecoverVoltage highByte:high lowByte:low];
}

//读总压过压保护电压  0.1V
- (void)readOverProtectOverallVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverProtectOverallVoltage];
}

//写总压过压保护电压  0.1V
- (void)writeOverProtectOverallVoltage:(double)v {
    uint16_t v_16 = 10 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverProtectOverallVoltage highByte:high lowByte:low];
}

//读总压欠压保护电压   0.1V
- (void)readUnderProtectOverallVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressUnderProtectOverallVoltage];
}

//写总压欠压保护电压   0.1V
- (void)writeUnderProtectOverallVoltage:(double)v {
    uint16_t v_16 = 10 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressUnderProtectOverallVoltage highByte:high lowByte:low];
}

//读充电过流保护  0.1A
- (void)readOverProtectChargeCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverProtectChargeCurrent];
}

//写充电过流保护  0.1A
- (void)writeOverProtectChargeCurrent:(double)current {
    uint16_t v_16 = 10 * current;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverProtectChargeCurrent highByte:high lowByte:low];
}

//读充电过流保护延时  秒
- (void)readDelayForOverProtectChargeCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressDelayForOverProtectChargeCurrent];
}

//写充电过流保护延时  秒
- (void)writeDelayForOverProtectChargeCurrent:(NSInteger)delay {
    uint16_t v_16 = delay;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressDelayForOverProtectChargeCurrent highByte:high lowByte:low];
}

//读放电过流保护      0.1A
- (void)readOverProtectDischargeCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressOverProtectDischargeCurrent];
}

//写放电过流保护      0.1A
- (void)writeOverProtectDischargeCurrent:(double)current {
    uint16_t v_16 = 10 * current;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressOverProtectDischargeCurrent highByte:high lowByte:low];
}

//读放电过流保护延时    秒
- (void)readDelayForOverProtectDischargeCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressDelayForOverProtectDischargeCurrent];
}

//写放电过流保护延时    秒
- (void)writeDelayForOverProtectDischargeCurrent:(NSInteger)delay {
    uint16_t v_16 = delay;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressDelayForOverProtectDischargeCurrent highByte:high lowByte:low];
}

//读均衡极限电压      0.001V
- (void)readLimitBalanceVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressLimitBalanceVoltage];
}

//写均衡极限电压      0.001V
- (void)writeLimitBalanceVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLimitBalanceVoltage highByte:high lowByte:low];
}

//读充电时均衡起控电压  0.001V
- (void)readBalanceWorkVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBalanceWorkVoltage];
}

//写充电时均衡起控电压  0.001V
- (void)writeBalanceWorkVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBalanceWorkVoltage highByte:high lowByte:low];
}

//读均衡压差 0.001V
- (void)readBalancePressureDifferentials {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBalancePressureDifferentials];
}

//写均衡压差 0.001V
- (void)writeBalancePressureDifferentials:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBalancePressureDifferentials highByte:high lowByte:low];
}

//读均衡电流 取值 +(1-20)*10
- (void)readBalanceCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBalanceCurrent];
}

//写均衡电流 取值 +(1-20)*10
- (void)writeBalanceCurrent:(double)current {
    uint16_t v_16 = current/10.0;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBalanceCurrent highByte:high lowByte:low];
}

//读系统基准电压     0.1V
- (void)readBaseVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBaseVoltage];
}

//写系统基准电压     0.1V
- (void)writeBaseVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBaseVoltage highByte:high lowByte:low];
}

//读电流传感器量程    0.1A
- (void)readCurrentSensorRange {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressCurrentSensorRange];
}

//写电流传感器量程    0.1A
- (void)writeCurrentSensorRange:(double)current {
    uint16_t v_16 = 10 * current;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressCurrentSensorRange highByte:high lowByte:low];
}

//读启动电流 0.1A
- (void)readLaunchCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressLaunchCurrent];
}

//写启动电流 0.1A
- (void)writeLaunchCurrent:(double)current {
    uint16_t v_16 = 10 * current;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLaunchCurrent highByte:high lowByte:low];
}

//读短路保护电流 0.1A
- (void)readShortCircuitProtectionCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressShortCircuitProtectionCurrent];
}

//写短路保护电流 0.1A
- (void)writeShortCircuitProtectionCurrent:(double)current {
    uint16_t v_16 = 10 * current;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressShortCircuitProtectionCurrent highByte:high lowByte:low];
}

//读短路保护延时 us
- (void)readDelayForShortCircuitProtection {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressDelayForShortCircuitProtection];
}

//写短路保护延时 us
- (void)writeDelayForShortCircuitProtection:(NSInteger)delay {
    uint16_t v_16 = delay;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressDelayForShortCircuitProtection highByte:high lowByte:low];
}

//读无电流自动待机时间 秒
- (void)readTimeForStandby {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressTimeForStandby];
}

//写无电流自动待机时间 秒
- (void)writeTimeForStandby:(NSInteger)time {
    uint16_t v_16 = time;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressTimeForStandby highByte:high lowByte:low];
}

//读总电压AD值转换成实际电压值的参数0000(4位整数)  U16
- (void)readADCData {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressADCData];
}

//写总电压AD值转换成实际电压值的参数0000(4位整数)  U16
- (void)writeADCData:(uint16_t)data {
    uint16_t v_16 = data;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressADCData highByte:high lowByte:low];
}

//读设置的电池串数   U8
- (void)readBatteryBlockCount {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBatteryBlockCount];
}

//写设置的电池串数   U8
- (void)writeBatteryBlockCount:(uint8_t)count {
    uint16_t v_16 = count;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBatteryBlockCount highByte:high lowByte:low];
}

//读电池高温充电保护   ±0.1 摄氏度
- (void)readHighTemperatureChargeProtection {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperatureChargeProtection];
}

//写电池高温充电保护   ±0.1 摄氏度
- (void)writeHighTemperatureChargeProtection:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperatureChargeProtection highByte:high lowByte:low];
}

//读电池高温充电恢复   ±0.1 摄氏度
- (void)readHighTemperatureChargeRecovery {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperatureChargeRecovery];
}

//写电池高温充电恢复   ±0.1 摄氏度
- (void)writeHighTemperatureChargeRecovery:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperatureChargeRecovery highByte:high lowByte:low];
}

//读电池高温放电保护
- (void)readHighTemperatureDischargeProtection {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperatureDischargeProtection];
}

//写电池高温放电保护
- (void)writeHighTemperatureDischargeProtection:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperatureDischargeProtection highByte:high lowByte:low];
}

//读电池高温放电恢复
- (void)readHighTemperatureDischargeRecovery {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperatureDischargeRecovery];
}

//写电池高温放电恢复
- (void)writeHighTemperatureDischargeRecovery:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperatureDischargeRecovery highByte:high lowByte:low];
}

//读功率管高温保护
- (void)readHighTemperaturePowertubeProtection {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperaturePowertubeProtection];
}

//写功率管高温保护
- (void)writeHighTemperaturePowertubeProtection:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperaturePowertubeProtection highByte:high lowByte:low];
}

//读功率管高温恢复
- (void)readHighTemperaturePowertubeRecovery {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighTemperaturePowertubeRecovery];
}

//写功率管高温恢复
- (void)writeHighTemperaturePowertubeRecovery:(double)t {
    int16_t v_16 = 10 * t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighTemperaturePowertubeRecovery highByte:high lowByte:low];
}

//读电池物理容量<高字节>  .000 000AH (2个空间)(31低，32高)
- (void)readHighOverallCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighOverallCapacity];
}

//写电池物理容量<高字节>  .000 000AH (2个空间)(31低，32高)
- (void)writeHighOverallCapacity:(double)ah {
    int32_t v_32 = 1000000 * ah;
    Byte high = ((v_32 >> 24) & 0xff);
    Byte low = ((v_32 >> 16) & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighOverallCapacity highByte:high lowByte:low];
}

//读电池物理容量<低字节>  .000 000AH (2个空间)(31低，32高)
- (void)readLowOverallCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressLowOverallCapacity];
}

//写电池物理容量<低字节>  .000 000AH (2个空间)(31低，32高)
- (void)writeLowOverallCapacity:(double)ah {
    int32_t v_32 = 1000000 * ah;
    Byte high = ((v_32 >> 8) & 0xff);
    Byte low = (v_32 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLowOverallCapacity highByte:high lowByte:low];
}

//读电池剩余容量<高字节>  .000 000AH (2个空间)(33低，34高)
- (void)readHighRemainingCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighRemainingCapacity];
}

//写电池剩余容量<高字节>  .000 000AH (2个空间)(33低，34高)
- (void)writeHighRemainingCapacity:(double)ah {
    int32_t v_32 = 1000000 * ah;
    Byte high = ((v_32 >> 24) & 0xff);
    Byte low = ((v_32 >> 16) & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighRemainingCapacity highByte:high lowByte:low];
}

//读电池剩余容量<低字节>  .000 000AH (2个空间)(33低，34高)
- (void)readLowRemainingCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressLowRemainingCapacity];
}

//写电池剩余容量<低字节>  .000 000AH (2个空间)(33低，34高)
- (void)writeLowRemainingCapacity:(double)ah{
    int32_t v_32 = 1000000 * ah;
    Byte high = ((v_32 >> 8) & 0xff);
    Byte low = (v_32 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLowRemainingCapacity highByte:high lowByte:low];
}

//读总共循环容量<高字节>  .000 000AH (2个空间)(35低，36高)
- (void)readHighCycleCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressHighCycleCapacity];
}

//写总共循环容量<高字节>  .000 000AH (2个空间)(35低，36高)
- (void)writeHighCycleCapacity:(double)ah {
    int32_t v_32 = 1000 * ah;
    Byte high = ((v_32 >> 24) & 0xff);
    Byte low = ((v_32 >> 16) & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressHighCycleCapacity highByte:high lowByte:low];
}

//读总共循环容量<低字节>  .000 000AH (2个空间)(35低，36高)
- (void)readLowCycleCapacity {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressLowCycleCapacity];
}

//写总共循环容量<低字节>  .000 000AH (2个空间)(35低，36高)
- (void)writeLowCycleCapacity:(double)ah {
    int32_t v_32 = 1000 * ah;
    Byte high = ((v_32 >> 8) & 0xff);
    Byte low = (v_32 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressLowCycleCapacity highByte:high lowByte:low];
}

//读轮胎长度  1mm 不显示
- (void)readWheelLength {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressWheelLength];
}

//写轮胎长度  1mm 不显示
- (void)writeWheelLength:(NSInteger)length {
    uint16_t v_16 = length;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressWheelLength highByte:high lowByte:low];
}

//读一周脉冲次数 不显示
- (void)readFrequence {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressFrequence];
}

//写一周脉冲次数 不显示
- (void)writeFrequence:(NSUInteger)frequenc {
    uint16_t v_16 = frequenc;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressFrequence highByte:high lowByte:low];
}

//读自动关机电压
- (void)readShutdownVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressShutdownVoltage];
}

//写自动关机电压
- (void)writeShutdownVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressShutdownVoltage highByte:high lowByte:low];
}

//读单体压差保护
- (void)readProtectVoltage {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressProtectVoltage];
}

//写单体压差保护
- (void)writeProtectVoltage:(double)v {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressProtectVoltage highByte:high lowByte:low];
}

//从机模块数
- (void)readModelCounter {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressModelCounter];
}
//从机模块数
- (void)writeModelCounter:(NSUInteger)counter {
    uint16_t v_16 = counter;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressModelCounter highByte:high lowByte:low];
}

//读欠压内阻补偿 .1mΩ
- (void)readCompensateResistance {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressCompensateResistance];
}

//写欠压内阻补偿 .1mΩ
- (void)writeCompensateResistance:(double)r {
    uint16_t v_16 = 10 * r;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressCompensateResistance highByte:high lowByte:low];
}

//读静态消耗电流 .1mA
- (void)readStaticCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressStaticCurrent];
}

//写静态消耗电流 .1mA
- (void)writeStaticCurrent:(double)a {
    uint16_t v_16 = 10 * a;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressStaticCurrent highByte:high lowByte:low];
}

//读温度传感器屏蔽
- (void)readTemperatureSensorShield {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressTemperatureSensorShield];
}
//写温度传感器屏蔽
- (void)writeTemperatureSensorShield:(NSUInteger)t {
    uint16_t v_16 = t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressTemperatureSensorShield highByte:high lowByte:low];
}

//读蓝牙地址编码
- (void)readBleAddress {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressBleAddress];
}
//写蓝牙地址编码
- (void)writeBleAddress:(NSUInteger)addr {
    uint16_t v_16 = addr;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressBleAddress highByte:high lowByte:low];
}

//读静态电压SOC对应表 (0%-100%)
- (void)readSOCVoltage {
    for (Byte addr = JXTBluetoothAddressSOCVoltage0; addr <=JXTBluetoothAddressSOCVoltage10 ; addr++) {
        [self private_sendReadOrderWithAddress:addr];
    }
}

//写静态电压SOC对应表 (0%-100%)
- (void)writeSOCVoltage:(double)v address:(Byte)address {
    uint16_t v_16 = 1000 * v;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:address highByte:high lowByte:low];
}

//读二级放电过流保护
- (void)readSecondlevelProtectCurrent {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressSecondlevelProtectCurrent];
}

//写二级放电过流保护
- (void)writeSecondlevelProtectCurrent:(NSUInteger)a {
    uint16_t v_16 = a;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressSecondlevelProtectCurrent highByte:high lowByte:low];
}
//读二级放电过流保护延时
- (void)readSecondlevelProtectDelay {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressSecondlevelProtectDelay];
}
//写二级放电过流保护延时
- (void)writeSecondlevelProtectDelay:(NSUInteger)t {
    uint16_t v_16 = t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressSecondlevelProtectDelay highByte:high lowByte:low];
}

//读电池内阻（51-74）0.1mΩ
- (void)readInternalResistance {
    for (Byte addr = JXTBluetoothAddressInternalResistance0; addr <=JXTBluetoothAddressInternalResistance23 ; addr++) {
        [self private_sendReadOrderWithAddress:addr];
    }
}

//写电池内阻（51-74）0.1mΩ
- (void)writeInternalResistance:(double)r address:(Byte)address{
    uint16_t v_16 = 10 * r;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:address highByte:high lowByte:low];
}

//读运行时间（70-71两个空间）
- (void)readRunningTime {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressRunningTime];
}

//写运行时间（70-71两个空间）
- (void)writeRunningTime:(NSUInteger)sec {
    uint16_t v_16 = sec;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressRunningTime highByte:high lowByte:low];
}

//读初始SOC
- (void)readInitialSOC {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressInitialSOC];
}

//写初始SOC
- (void)writeInitialSOC:(NSUInteger)t {
    uint16_t v_16 = t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressInitialSOC highByte:high lowByte:low];
}

//读SOC过低告警
- (void)readSOCLowWarning {
    [self private_sendReadOrderWithAddress:JXTBluetoothAddressSOCLowWarning];
}

//写SOC过低告警
- (void)writeSOCLowWarning:(NSUInteger)t {
    uint16_t v_16 = t;
    Byte high = ((v_16 >> 8) & 0xff);
    Byte low = (v_16 & 0xff);
    [self private_sendWriteOrderWithAddress:JXTBluetoothAddressSOCLowWarning highByte:high lowByte:low];
}

//读出厂序列号229-236
- (void)readSerialNumber{
    for (Byte i = 229; i <= 236; i++){
        [self private_sendReadOrderWithAddress:i];
    }
}

#pragma mark - Private Method

- (void)refreshTime:(NSTimer *)timer {
    if (!self.peripheralConnnected || self.isUpdate) {
        return;
    }
    
    [self readBMSInitialData];
}

- (void)updateTime:(NSTimer *)timer {
    if (!self.peripheralConnnected || !self.isUpdate) {
        return;
    }
//    NSLog(@"1111111");
    [self private_sendOperateOrderWithFrameHeadHigh:0xa5 frameLowHead:0xa5 ddress:JXTBluetoothAddressSystemUpdate highByte:0x1a lowByte:0x01];
    //测试数据
//    Byte b[] = {0xA5, 0xA5, 0x00, 0x01, 0x30, 0};
//    NSData *d = [NSData dataWithBytes:b length:sizeof(b)];
//    b[5] = [BabyToy getCheckSum:d headerLength:2];
//    d = [NSData dataWithBytes:b length:sizeof(b)];
//    [self readValueForCharacteristic:d];
}

- (void)systemUpdateTimeout{
    [self cleanSystemUpdateStatus:NO];
}

- (void)cleanSystemUpdateStatus:(BOOL)isSuccess{
    if (self.updateBlock) {
        self.updateBlock(isSuccess);
    }
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    self.isUpdate = NO;
    self.binFileData = nil;
    self.updateBlock = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(systemUpdateTimeout) object:nil];
}

- (void)private_settingPassword:(NSString *)password beginAddr:(Byte)beginAddr {
    //提取第1个字符
    Byte password0= [[password substringWithRange:NSMakeRange(0, 1)] integerValue] & 0xff;
    //提取第2个字符
    Byte password1= [[password substringWithRange:NSMakeRange(1, 1)] integerValue] & 0xff;
    //提取第3个字符
    Byte password2= [[password substringWithRange:NSMakeRange(2, 1)] integerValue] & 0xff;
    //提取第4个字符
    Byte password3= [[password substringWithRange:NSMakeRange(3, 1)] integerValue] & 0xff;
    //提取第5个字符
    Byte password4= [[password substringWithRange:NSMakeRange(4, 1)] integerValue] & 0xff;
    //提取第6个字符
    Byte password5= [[password substringWithRange:NSMakeRange(5, 1)] integerValue] & 0xff;
    //提取第7个字符
    Byte password6= [[password substringWithRange:NSMakeRange(6, 1)] integerValue] & 0xff;
    //提取第8个字符
    Byte password7= [[password substringWithRange:NSMakeRange(7, 1)] integerValue] & 0xff;
    
    [self private_sendWriteOrderWithAddress:beginAddr highByte:password0 lowByte:password1];
    [self private_sendWriteOrderWithAddress:beginAddr+1 highByte:password2 lowByte:password3];
    [self private_sendWriteOrderWithAddress:beginAddr+2 highByte:password4 lowByte:password5];
    [self private_sendWriteOrderWithAddress:beginAddr+3 highByte:password6 lowByte:password7];
}

- (void)private_sendWriteOrderWithAddress:(Byte)address {
    [self private_sendWriteOrderWithAddress:address highByte:0 lowByte:0];
}

- (void)private_sendReadOrderWithAddress:(Byte)address {
    [self private_sendReadOrderWithAddress:address highByte:0 lowByte:0];
}

- (void)private_sendWriteOrderWithAddress:(Byte)address highByte:(Byte)highByte lowByte:(Byte)lowByte{
    if (![JXTBluetooth sharedInstance].peripheralConnnected) {
        [UIView showHudString:@"您尚未连接任何BMS设备" stayDuration:1 animationDuration:0 hudDidHide:nil];
        return;
    }
    [self private_sendOperateOrderWithFrameHeadHigh:0xa5 frameLowHead:0xa5 ddress:address highByte:highByte lowByte:lowByte];
    //应用
    [self private_sendOperateOrderWithFrameHeadHigh:0xa5 frameLowHead:0xa5 ddress:0xff highByte:0 lowByte:0];
}

- (void)private_sendReadOrderWithAddress:(Byte)address highByte:(Byte)highByte lowByte:(Byte)lowByte {
    [self private_sendOperateOrderWithFrameHeadHigh:0x5a frameLowHead:0x5a ddress:address highByte:highByte lowByte:lowByte];
}

- (void)private_sendOperateOrderWithFrameHeadHigh:(Byte)highHead frameLowHead:(Byte)lowHead ddress:(Byte)address highByte:(Byte)highByte lowByte:(Byte)lowByte {
    if (!self.peripheralConnnected){
        return;
    }
    if (!self.characteristic) {
        return;
    }
    Byte b[] = {highHead, lowHead, address, highByte, lowByte, 0x00};
    NSInteger length = sizeof(b)/sizeof(Byte);
    NSData *data = [NSData dataWithBytes:b length:length];
    Byte sum = [BabyToy getCheckSum:data headerLength:2];
    b[length-1] = sum;
    data = [NSData dataWithBytes:b length:length];
    [self.currentPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];

}

- (void)private_sendSystemUpdateWithData:(NSData *)data {
    if (!self.peripheralConnnected){
        [self cleanSystemUpdateStatus:NO];
        return;
    }
    if (!self.characteristic) {
        [self cleanSystemUpdateStatus:NO];
        return;
    }

    [self.currentPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

- (void)setupBabyBlock {
    __weak typeof(self) weakSelf = self;
    //设置设备状态改变的委托
    [self.baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        [[NSNotificationCenter defaultCenter] postNotificationName:JXT_CENTRAL_STATE_NOTIFY object:central];
        if (central.state == CBCentralManagerStatePoweredOn) {
            [UIViewController dismissAlertController];
        } else if (central.state == CBCentralManagerStatePoweredOff) {
            weakSelf.currentPeripheral = nil;
            [UIViewController showCommonAlertWithMessage:@"蓝牙设备未打开，请前往->[设置-蓝牙]打开蓝牙设备" action:^{
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                    } else {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }
            }];
        }
    }];
    
    //设置扫描到设备的委托
    [self.baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        //        NSLog(@"搜索到了设备:%@ advertisementData:%@ RSSI: %ld",peripheral.name, advertisementData, (long)[RSSI integerValue]);
        [[NSNotificationCenter defaultCenter] postNotificationName:JXT_PERIPHERAL_DISCOVER_NOTIFY object:@{@"peripheral":peripheral, @"advertisementData":advertisementData, @"RSSI":RSSI}];
    }];
    
    //设置设备连接成功的委托
    [self.baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        if(!weakSelf.peripheralConnnected) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@连接成功", peripheral.name]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:JXT_PERIPHERAL_CONNECTED_NOTIFY object:peripheral];
    }];
    
    //设置设备连接失败的委托
    [self.baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@连接失败",peripheral.name]];
        [weakSelf cancelConnect];
        [[NSNotificationCenter defaultCenter] postNotificationName:JXT_PERIPHERAL_CONNECTE_FAIL_NOTIFY object:peripheral];
    }];
    
    //设置读取RSSI的委托
    [self.baby setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
    }];
    
    //设置设备断开连接成功的委托
    [self.baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@断开连接", peripheral.name]];
        [[NSNotificationCenter defaultCenter] postNotificationName:JXT_PERIPHERAL_DISCONNECTED_NOTIFY object:peripheral];
    }];
    
    //设置发现设service的Characteristics的委托
    [self.baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        //                NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            [peripheral setNotifyValue:YES forCharacteristic:c];
            if ([c.UUID.UUIDString isEqualToString:JXT_CHARACTERISTIC_UUID]) {
                weakSelf.characteristic = c;
                [weakSelf readAllData];
                [[NSNotificationCenter defaultCenter] postNotificationName:JXT_CHARACTERISTIC_DISCOVER_NOTIFY object:c];
            }
        }
    }];
    
    [self.baby setBlockOnDidWriteValueForCharacteristic:^(CBCharacteristic *characteristic, NSError *error) {
        
    }];
    
    //设置读取characteristics的委托
    [self.baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        //                NSLog(@"characteristic name:%@ error:%@ value is:%@",characteristics.UUID,error.description, characteristics.value.description);
        if (error) {
            return ;
        }
        if ([characteristics.UUID.UUIDString isEqualToString:JXT_CHARACTERISTIC_UUID]) {
            NSData *data = characteristics.value;
            [weakSelf readValueForCharacteristic:data];
        }
    }];
    
    //设置发现characteristics的descriptors的委托
    [self.baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        //        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        //        for (CBDescriptor *d in characteristic.descriptors) {
        //            NSLog(@"CBDescriptor name is :%@",d.UUID);
        //        }
    }];
    
    //设置读取Descriptor的委托
    [self.baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        //        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置查找设备的过滤器
    [self.baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备
        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //            return YES;
        //        }
        //        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length > 0) {
            return YES;
        }
        return NO;
    }];
    
    //设置取消连接的委托
    [self.baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    //设置停止扫描的委托
    [self.baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    
    /*CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
    [self.baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    //心跳
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(refreshTime:) userInfo:nil repeats:YES];
}

- (void)readValueForCharacteristic:(NSData *)data {
    /**
     *  系统升级
     */
    if (self.isUpdate) {
        if (6 == data.length) {
            Byte *b = [BabyToy ConvertDataToByteArray:data];
            Byte sum = [BabyToy getCheckSum:data headerLength:2];
            Byte *binFileByte = [BabyToy ConvertDataToByteArray:self.binFileData];
            if (sum == b[5]) {
                ushort number = 0;
                number = b[2];
                number <<= 8;
                number += b[3];// BMS Needs Bin File Frame ID      // bin file 是从第1帧开始的，不是第0帧
                if (b[4] == 0x30 || b[4] == 0x31)// need next frame需要下一帧数据，上一次发送数据接收成功. 超时后从 0 开始允许
                {
                    [self.updateTimer invalidate];
                    self.updateTimer = nil;
                    if (b[4] == 0x31){
                        NSLog(@"序号：%d发送失败", number);
                    }
                    //发送下一帧数据
                    Byte send[135] = {0x0};
                    NSUInteger begin = (number-1) * 128;
                    NSUInteger length = 0;
                    send[0] = 0xaa;
                    send[1] = 0x55;
                    send[2] = (number>>8) & 0xff;
                    send[3] = number & 0xff;
                    NSUInteger binLength = self.binFileData.length;
                    NSLog(@"bin文件大小: %lu", (unsigned long)binLength);
                    while (length < 128 && begin < binLength) {
                        send[5 + length] = binFileByte[begin];
                        length++;
                        begin++;
                    }
                    NSLog(@"发送有效数据大小: %lu", (unsigned long)length);
                    send[4] = length;
                    
                    //如果不够128位 用0xff补齐
                    if (length < 128) {
                        NSUInteger remaining = 128 - length;
                        for (NSUInteger i = 0; i < remaining; i++) {
                            send[5 + length + i] = 0xff;
                        }
                    }
                    
                    //CRC 校验获取
                    uint16_t crc = GetCRC16(send, 133);
                    send[133]= (crc>>8) & 0xff;
                    send[134] = crc & 0xff;
                    
                    //数据已经整合好，现在开始发送。
                    
                    //1.不分包
//                     [self private_sendSystemUpdateWithData:[NSData dataWithBytes:send length:sizeof(send)/sizeof(Byte)]];
                    
                    //2.分包
                    NSInteger totalLength = sizeof(send)/sizeof(Byte);
                    NSInteger offSet = totalLength / 2 + ((totalLength % 2) > 0 ? 1 : 0);
                    Byte *s1 = send;
                    Byte *s2 = s1 + offSet;
                    NSData *package1 = [NSData dataWithBytes:s1 length:offSet];
                    NSData *package2 = [NSData dataWithBytes:s2 length:totalLength-offSet];
                    [self private_sendSystemUpdateWithData:package1];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self private_sendSystemUpdateWithData:package2];
                    });
                    
                    
                    CGFloat schedule = 100.0 * begin / binLength;
                    [UIView updateActivityIndicatorViewWithString:[NSString stringWithFormat:@"正在升级，已完成%.1f%%", schedule]];
                } else if(b[4] == 0x55) {// 升级成功标识
                    [self cleanSystemUpdateStatus:YES];
                }
            }
        }
        return;
    }
    
    /**
     *  0XDBDB00000000返回140字节数据解析
     *  分两种情况
     *  场景1： 一次性读完140字节
     */
    if (data.length >= 140) {
        Byte b[] = {0xaa, 0x55, 0xaa, 0xff};
        NSData *find = [NSData dataWithBytes:b length:sizeof(b)/sizeof(Byte)];
        NSRange range = [data rangeOfData:find options:NSDataSearchAnchored range:NSMakeRange(0, 4)];
        if (range.location != NSNotFound) {
            Byte *a = [BabyToy ConvertDataToByteArray:data];
            int sum =0;
            for (int i = 0; i < 138; i++) {
                sum += a[i] & 0xff;
            }
            [[JXTBatteryInfoManager sharedInstance] updateWithData:data];
            [[NSNotificationCenter defaultCenter] postNotificationName:JXT_BATTERY_INFO_NOTIFY object:data];
            return;
        }
    } else {
        /**
         *  0XDBDB00000000返回140字节数据解析
         *  分两种情况
         *  场景2： 分多次读完140字节
         */
        if (self.infoData) {
            [self.infoData appendData:data];
            if (self.infoData.length >= 140) {
                Byte *a = [BabyToy ConvertDataToByteArray:self.infoData];
                int sum =0;
                for (int i = 0; i < 138; i++) {
                    sum += a[i] & 0xff;
                }
                [[JXTBatteryInfoManager sharedInstance] updateWithData:self.infoData];
                [[NSNotificationCenter defaultCenter] postNotificationName:JXT_BATTERY_INFO_NOTIFY object:data];
                self.infoData = nil;
            }
            return;
        } else {
            Byte b[] = {0xaa, 0x55, 0xaa, 0xff};
            if (data.length >= 4) {
                NSData *find = [NSData dataWithBytes:b length:sizeof(b)/sizeof(Byte)];
                NSRange range = [data rangeOfData:find options:NSDataSearchAnchored range:NSMakeRange(0, 4)];
                if (range.location != NSNotFound) {
                    self.infoData = [NSMutableData dataWithData:data];
                    return;
                }
            }
        }
    }
    
    /**
     *  处理帧头0xA5-0xA5向BMS写入数据 或者 0x5A-0x5A从BMS读出数据
     */
    if (data.length >= 6) {
        data = [data subdataWithRange:NSMakeRange(data.length-6, 6)];
        Byte read[] = {0xa5, 0xa5,};
        Byte write[] = {0x5a, 0x5a,};
        NSData *findRead = [NSData dataWithBytes:read length:sizeof(read)/sizeof(Byte)];
        NSRange rangeRead = [data rangeOfData:findRead options:NSDataSearchAnchored range:NSMakeRange(0, 2)];
        NSData *findWrite = [NSData dataWithBytes:write length:sizeof(write)/sizeof(Byte)];
        NSRange rangeWrite = [data rangeOfData:findWrite options:NSDataSearchAnchored range:NSMakeRange(0, 2)];
        if (rangeRead.location != NSNotFound || rangeWrite.location != NSNotFound) {
            [[JXTCharacterManager sharedInstance] updateCharacterWithData:data];
            if (rangeRead.location != NSNotFound) {
                [[NSNotificationCenter defaultCenter] postNotificationName:JXT_CHARACTERISTIC_READ_VALUE_NOTIFY object:data];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:JXT_CHARACTERISTIC_WRITE_VALUE_NOTIFY object:data];
            }
            return;
        }
    }
}



#pragma mark - Getter & Setter

- (BOOL)peripheralConnnected {
    if (!_currentPeripheral) {
        return NO;
    }
    
    return CBPeripheralStateConnected == _currentPeripheral.state;
}

@end


