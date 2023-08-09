//
//  JXTCharacrerManager.h
//  BMS
//
//  Created by qinwen on 2019/3/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXTCharacter.h"
#import "JXTDoubleCharacter.h"

@interface JXTCharacterManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) NSMutableDictionary *charactDic;

@property (nonatomic, strong) JXTCharacter *overWarningVoltage;
@property (nonatomic, strong) JXTCharacter *underWarningVoltage;
@property (nonatomic, strong) JXTCharacter *overProtectVoltage;
@property (nonatomic, strong) JXTCharacter *underProtectVoltage;
@property (nonatomic, strong) JXTCharacter *overRecoverVoltage;
@property (nonatomic, strong) JXTCharacter *underRecoverVoltage;
@property (nonatomic, strong) JXTCharacter *overProtectOverallVoltage;
@property (nonatomic, strong) JXTCharacter *underProtectOverallVoltage;
@property (nonatomic, strong) JXTCharacter *overProtectChargeCurrent;
@property (nonatomic, strong) JXTCharacter *delayForOverProtectChargeCurrent;
@property (nonatomic, strong) JXTCharacter *overProtectDischargeCurrent;
@property (nonatomic, strong) JXTCharacter *delayForOverProtectDischargeCurrent;
@property (nonatomic, strong) JXTCharacter *limitBalanceVoltage;
@property (nonatomic, strong) JXTCharacter *balanceWorkVoltage;
@property (nonatomic, strong) JXTCharacter *balancePressureDifferentials;
@property (nonatomic, strong) JXTCharacter *balanceCurrent;
@property (nonatomic, strong) JXTCharacter *baseVoltage;
@property (nonatomic, strong) JXTCharacter *currentSensorRange;
@property (nonatomic, strong) JXTCharacter *launchCurrent;
@property (nonatomic, strong) JXTCharacter *shortCircuitProtectionCurrent;
@property (nonatomic, strong) JXTCharacter *delayForShortCircuitProtection;
@property (nonatomic, strong) JXTCharacter *timeForStandby;
@property (nonatomic, strong) JXTCharacter *ADCData;
@property (nonatomic, strong) JXTCharacter *batteryBlockCount;
@property (nonatomic, strong) JXTCharacter *highTemperatureChargeProtection;
@property (nonatomic, strong) JXTCharacter *highTemperatureChargeRecovery;
@property (nonatomic, strong) JXTCharacter *highTemperatureDischargeProtection;
@property (nonatomic, strong) JXTCharacter *highTemperatureDischargeRecovery;
@property (nonatomic, strong) JXTCharacter *highTemperaturePowertubeProtection;
@property (nonatomic, strong) JXTCharacter *highTemperaturePowertubeRecovery;
@property (nonatomic, strong) JXTDoubleCharacter *overallCapacity;
@property (nonatomic, strong) JXTDoubleCharacter *remainingCapacity;
@property (nonatomic, strong) JXTDoubleCharacter *cycleCapacity;
@property (nonatomic, strong) JXTCharacter *wheelLength;
@property (nonatomic, strong) JXTCharacter *frequence;
@property (nonatomic, strong) JXTCharacter *shutdownVoltage;
@property (nonatomic, strong) JXTCharacter *protectVoltage;
@property (nonatomic, strong) JXTCharacter *modelCounter;
@property (nonatomic, strong) JXTCharacter *compensateResistance;
@property (nonatomic, strong) JXTCharacter *staticCurrent;
@property (nonatomic, strong) JXTCharacter *temperatureSensorShield;
@property (nonatomic, strong) JXTCharacter *bleAddress;
@property (nonatomic, strong) JXTCharacter *secondlevelProtectCurrent;
@property (nonatomic, strong) JXTCharacter *secondlevelProtectDelay;
@property (nonatomic, strong) NSMutableArray *internalResistanceArray;
@property (nonatomic, strong) NSMutableArray *socArray;

@property (nonatomic, strong) JXTCharacter *lithiumFer;
@property (nonatomic, strong) JXTCharacter *lithiumTitanate;
@property (nonatomic, strong) JXTCharacter *initialSOC;
@property (nonatomic, strong) JXTCharacter *underWarningSOC;
@property (nonatomic, strong) JXTCharacter *lowTemperatureChargeProtection;
@property (nonatomic, strong) JXTCharacter *lowTemperatureChargeRecovery;
@property (nonatomic, strong) JXTCharacter *lowTemperatureDischargeProtection;
@property (nonatomic, strong) JXTCharacter *lowTemperatureDischargeRecovery;
@property (nonatomic, strong) JXTCharacter *overallVoltageParam;
@property (nonatomic, strong) JXTCharacter *serialNumber;

//返回character，如果无需更新，返回nil
- (JXTCharacter *)updateCharacterWithData:(NSData *)data;

@end

