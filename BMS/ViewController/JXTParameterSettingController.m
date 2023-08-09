//
//  JXTParameterSettingController.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

static NSString * const KTitleKey = @"KTitleKey";
static NSString * const KImageKey = @"KImageKey";
static NSString * const KViewControllerKey = @"KViewControllerKey";
static NSString * const KDatasourceKey = @"KDatasourceKey";

#import "JXTParameterSettingController.h"
#import "JXTBMSSettingController.h"
#import "JXTSystemController.h"
#import "JXTParamCell.h"

@interface JXTParameterSettingController ()<UITableViewDelegate, UITableViewDataSource>{

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *datasource;
//电芯特性
@property (nonatomic, copy) NSArray *batteryCellsDatasource;
//保护参数
@property (nonatomic, copy) NSArray *protectDatasource;
//告警参数
@property (nonatomic, copy) NSArray *warningDatasource;
//温度保护
@property (nonatomic, copy) NSArray *tempratureDatasource;
//BMS硬件参数
@property (nonatomic, copy) NSArray *hardwareDatasource;
//均衡控制
@property (nonatomic, copy) NSArray *balanceDatasource;
//SOC静态表
@property (nonatomic, copy) NSArray *SOCDatasource;
//连接内阻
@property (nonatomic, copy) NSArray * internalResistanceDatasource;
//霍尔测速
@property (nonatomic, copy) NSArray *hoareDatasource;
//系统
@property (nonatomic, copy) NSArray *systemDatasource;

@end

@implementation JXTParameterSettingController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - Private method

- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Class vcClass = NSClassFromString(self.datasource[indexPath.row][KViewControllerKey]) ;
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = self.datasource[indexPath.row][KTitleKey];
    vc.hidesBottomBarWhenPushed = YES;
    if ([vc respondsToSelector:@selector(setDatasource:)]) {
        [vc performSelector:@selector(setDatasource:) withObject:self.datasource[indexPath.row][KDatasourceKey]];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTParamCell";
    NSDictionary *dic = self.datasource[indexPath.row];
    JXTParamCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTParamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell configCellWithImage:dic[KImageKey] title:dic[KTitleKey]];
    
    return cell;
}

#pragma mark - Getter & Setter

- (NSArray *)datasource{
    if (!_datasource) {
        _datasource = @[@{KImageKey: JXT_IMAGE(@"setting_icon1"), KTitleKey: @"电芯特性", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.batteryCellsDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon2"), KTitleKey: @"保护参数", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.protectDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon3"), KTitleKey: @"告警参数", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.warningDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon4"), KTitleKey: @"温度保护", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.tempratureDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon5"), KTitleKey: @"BMS硬件参数", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.hardwareDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon6"), KTitleKey: @"均衡控制", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.balanceDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon7"), KTitleKey: @"SOC静态表", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.SOCDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon8"), KTitleKey: @"连接内阻", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.internalResistanceDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon9"), KTitleKey: @"霍尔测速", KViewControllerKey: NSStringFromClass([JXTBMSSettingController class]), KDatasourceKey: self.hoareDatasource},
                        @{KImageKey: JXT_IMAGE(@"setting_icon10"), KTitleKey: @"系统", KViewControllerKey: NSStringFromClass([JXTSystemController class]), KDatasourceKey: self.systemDatasource},
                        ];
    }
    
    return _datasource;
}

- (NSArray *)batteryCellsDatasource {
    if (!_batteryCellsDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _batteryCellsDatasource = @[manager.lithiumFer,
                                    manager.lithiumTitanate,
                                    manager.overallCapacity,
                                    manager.initialSOC,
                                    manager.batteryBlockCount,
                                    manager.cycleCapacity];
    }
  
    return _batteryCellsDatasource;
}

- (NSArray *)protectDatasource {
    if (!_protectDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _protectDatasource = @[manager.overProtectVoltage,
                               manager.overRecoverVoltage,
                               manager.underRecoverVoltage,
                               manager.underProtectVoltage,
                               manager.protectVoltage,
                               manager.overProtectOverallVoltage,
                               manager.underProtectOverallVoltage,
                               manager.overProtectChargeCurrent,
                               manager.delayForOverProtectChargeCurrent,
                               manager.overProtectDischargeCurrent,
                               manager.delayForOverProtectDischargeCurrent,
                               manager.secondlevelProtectCurrent,
                               manager.secondlevelProtectDelay,
                               manager.shortCircuitProtectionCurrent,
                               manager.delayForShortCircuitProtection,
                             ];
    }
    
    return _protectDatasource;
}

- (NSArray *)warningDatasource {
    if (!_warningDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _warningDatasource = @[manager.overWarningVoltage,
                               manager.underWarningVoltage,
                               manager.underWarningSOC,];
    }
    
    return _warningDatasource;
}

- (NSArray *)tempratureDatasource {
    if (!_tempratureDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _tempratureDatasource = @[manager.highTemperatureChargeProtection,
                                  manager.highTemperatureChargeRecovery,
                                  manager.highTemperatureDischargeProtection,
                                  manager.highTemperatureDischargeRecovery,
                                  manager.highTemperaturePowertubeProtection,
                                  manager.highTemperaturePowertubeRecovery,
                                  manager.lowTemperatureChargeProtection,
                                  manager.lowTemperatureChargeRecovery,
                                  manager.lowTemperatureDischargeProtection,
                                  manager.lowTemperatureDischargeRecovery,];
    }
    
    return _tempratureDatasource;
}

- (NSArray *)hardwareDatasource {
    if (!_hardwareDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _hardwareDatasource = @[manager.bleAddress,
                                manager.shutdownVoltage,
                                manager.currentSensorRange,
                                manager.baseVoltage,
                                manager.launchCurrent,
                                manager.timeForStandby,
                                manager.overallVoltageParam,
                                manager.staticCurrent,
                                manager.compensateResistance,
                                manager.temperatureSensorShield,
                                manager.version,
                                manager.serialNumber,];
    }
    
    return _hardwareDatasource;
}


- (NSArray *)balanceDatasource {
    if (!_balanceDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _balanceDatasource = @[manager.balanceWorkVoltage,
                               manager.balanceCurrent,
                               manager.limitBalanceVoltage,
                               manager.balancePressureDifferentials,];
    }
    
    return _balanceDatasource;
}

- (NSArray *)SOCDatasource {
    if (!_SOCDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _SOCDatasource = manager.socArray;
    }
    
    return _SOCDatasource;
}

- (NSArray *)internalResistanceDatasource {
    if (!_internalResistanceDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _internalResistanceDatasource = manager.internalResistanceArray;
    }
    
    return _internalResistanceDatasource;
}

- (NSArray *)hoareDatasource {
    if (!_hoareDatasource) {
        JXTCharacterManager *manager = [JXTCharacterManager sharedInstance];
        _hoareDatasource = @[manager.frequence,
                             manager.wheelLength,];
    }
    
    return _hoareDatasource;
}

- (NSArray *)systemDatasource {
    if (!_systemDatasource) {
        _systemDatasource = @[@"恢复出厂设置",
                              @"升级固件",
                              @"关于我们",
                              @"验证密码和修改密码",
                              @"运行日志"];
    }
    
    return _systemDatasource;
}

@end
