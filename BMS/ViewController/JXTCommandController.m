//
//  JXTCommandController.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTCommandController.h"
#import "JXTControlButton.h"
#import "JXTFunctionView.h"
#import "JXTLogViewController.h"

typedef NS_ENUM(NSUInteger, JXTBMSOperation) {
    JXTBMSOperationRestar,
    JXTBMSOperationClose,
    JXTBMSOperationScreen,
    JXTBMSOperationBalance,
    JXTBMSOperationZero,
};

@interface JXTCommandController ()<JXTFunctionDelegate>{
    
}

@property (nonatomic, strong) JXTControlButton *chargeBtn;
@property (nonatomic, strong) JXTControlButton *disChargeBtn;

@end

@implementation JXTCommandController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupSubviews];
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[JXTBluetooth sharedInstance] readChargeMOS];
    [[JXTBluetooth sharedInstance] readDischargeMOS];
}

- (void)dealloc {
    [self removeNotification];
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryValueDidWrite:) name:JXT_CHARACTERISTIC_READ_VALUE_NOTIFY object:nil];
    [center addObserver:self selector:@selector(batteryInfoChanged:) name:JXT_BATTERY_INFO_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setupNavigationBar {
    UIButton *logBtn = [UIButton buttonWithTitle:@"系统日志" font:[UIFont fontOfSize_15] titleColor:[UIColor whiteColor] target:self selector:@selector(logBtnDidClicked:)];
    logBtn.frame = CGRectMake(0, 0, 80, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logBtn];
}

- (void)setupSubviews{
    UIImageView *topBg = JXT_IMAGE_VIEW(@"bg_log1");
    topBg.userInteractionEnabled = YES;
    [self.view addSubview:topBg];
    
    UILabel *chargeLabel = [UILabel labelWithText:@"充电开关" font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [topBg addSubview:chargeLabel];
    
    JXTControlButton *chargeBtn = [JXTControlButton buttonWithNormalImage:JXT_IMAGE(@"icon_charge_close") selectedImage:JXT_IMAGE(@"icon_charge_open") normalTitleImage:JXT_IMAGE(@"button_close") selectedTitleImage:JXT_IMAGE(@"button_open") normalTitle:@"已关闭" selectedTitle:@"已打开"];
    [chargeBtn addTarget:self action:@selector(controlBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topBg addSubview:chargeBtn];
    _chargeBtn = chargeBtn;
    
    UIView *line = [UIView lineView];
    [topBg addSubview:line];
    
    UILabel *dischargeLabel = [UILabel labelWithText:@"放电开关" font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [topBg addSubview:dischargeLabel];
    
    JXTControlButton *dischargeBtn = [JXTControlButton buttonWithNormalImage:JXT_IMAGE(@"icon_discharge_close") selectedImage:JXT_IMAGE(@"icon_discharge_open") normalTitleImage:JXT_IMAGE(@"button_close") selectedTitleImage:JXT_IMAGE(@"button_open") normalTitle:@"已关闭" selectedTitle:@"已打开"];
    [dischargeBtn addTarget:self action:@selector(controlBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topBg addSubview:dischargeBtn];
    _disChargeBtn = dischargeBtn;
    
    UIImageView *bottomBg = JXT_IMAGE_VIEW(@"bg_log1");
    bottomBg.userInteractionEnabled = YES;
    [self.view addSubview:bottomBg];
    
    JXTFunctionView *funcView = [[JXTFunctionView alloc] init];
    funcView.delegate = self;
    funcView.imageAndTitles = @[[self dictionaryWithImageName:@"icon_operation1" title:@"重启系统" index:JXTBMSOperationRestar],
                                [self dictionaryWithImageName:@"icon_operation2" title:@"关闭系统" index:JXTBMSOperationClose],
                                [self dictionaryWithImageName:@"icon_operation3" title:@"屏幕切换" index:JXTBMSOperationScreen],
                                [self dictionaryWithImageName:@"icon_operation4" title:@"自动均衡" index:JXTBMSOperationBalance],
                                [self dictionaryWithImageName:@"icon_operation5" title:@"电流归零" index:JXTBMSOperationZero]];
    [bottomBg addSubview:funcView];
    
    [topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.centerX.equalTo(self.view);
        make.height.equalTo(191);
    }];
    
    [chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(26);
        make.left.equalTo(21);
        make.height.equalTo(16);
    }];
    
    [chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chargeLabel.mas_bottom).offset(15);
        make.left.equalTo(topBg);
        make.right.equalTo(line.mas_left);
        make.bottom.equalTo(line);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chargeLabel);
        make.width.equalTo(JXT_LINE_WIDTH);
        make.height.equalTo(140);
        make.centerX.equalTo(topBg);
    }];
    
    [dischargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(chargeLabel);
        make.left.equalTo(line.mas_right).offset(21);
    }];
    
    [dischargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(chargeBtn);
        make.left.equalTo(line.mas_right);
        make.right.equalTo(topBg);
    }];
    
    [bottomBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBg.mas_bottom).offset(5);
        make.left.right.equalTo(topBg);
        make.height.equalTo(231);
    }];
    
    [funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(26, 37, 26, 37));
    }];
}

- (NSDictionary *)dictionaryWithImageName:(NSString *)imageName title:(NSString *)title index:(NSInteger)index {
    return @{@"image": JXT_IMAGE(imageName), @"title": title, @"index": @(index)};
}

#pragma mark - Action Method

- (void)batteryValueDidWrite:(NSNotification *)ntf{
    NSData *data = ntf.object;
    Byte *byte = [BabyToy ConvertDataToByteArray:data];
    JXTBluetoothAddress addr = byte[2];
//    Byte high = byte[3];
    Byte low = byte[4];
    switch (addr) {
        case JXTBluetoothAddressChargeMOS:
            if (0 == low) {
                self.chargeBtn.selected = NO;
                [UIView showHudString:@"\"关闭充电开关\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            } else {
                self.chargeBtn.selected = YES;
                [UIView showHudString:@"\"打开充电开关\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            }
            break;
            
        case JXTBluetoothAddressDischargeMOS:
            if (0 == low) {
                self.disChargeBtn.selected = NO;
                [UIView showHudString:@"\"关闭放电开关\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            } else {
                self.disChargeBtn.selected = YES;
                [UIView showHudString:@"\"打开放电开关\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            }
            break;
            
        case JXTBluetoothAddressRebootBMS:
            [UIView showHudString:@"\"重启系统\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            break;
            
        case JXTBluetoothAddressCloseBMSPower:
            [UIView showHudString:@"\"关闭系统\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            break;
            
        case JXTBluetoothAddressScreenSwitching:  
            [UIView showHudString:@"\"屏幕切换\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            break;
            
        case JXTBluetoothAddressAutoBalance:
            [UIView showHudString:@"\"自动均衡\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            break;
            
        case JXTBluetoothAddressClearBMSCurrent:
            [UIView showHudString:@"\"电流归零\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
            break;
            
        default:
            break;
       
    }
}

- (void)batteryInfoChanged:(NSNotification *)ntf{
    self.chargeBtn.selected = [[JXTBatteryInfoManager sharedInstance].chargeMosState.value isEqualToString:@"开启"];
    self.disChargeBtn.selected = [[JXTBatteryInfoManager sharedInstance].dischargeMosState.value isEqualToString:@"开启"];
}

- (void)logBtnDidClicked:(UIButton *)sender {
    JXTLogViewController *logVc = [[JXTLogViewController alloc] init];
    [self.navigationController pushViewController:logVc animated:YES];
}

- (void)controlBtnDidClicked:(UIButton *)sender{
    if (sender == self.chargeBtn) {
        if (sender.selected) {
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要关闭充电开关吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] closeChargeMOS];
            }];
        } else {
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要打开充电开关吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] openChargeMOS];
            }];
        }
    } else if (sender == self.disChargeBtn) {
        if (sender.selected) {
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要关闭放电开关吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] closeDischargeMOS];
            }];
        } else {
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要打开放电开关吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] openDischargeMOS];
            }];
        }
    }
}

#pragma mark -  JXTFunctionDelegate

- (void)functionViewButtonDidClicked:(NSInteger)index {
    switch (index) {
        case JXTBMSOperationRestar:
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要重启系统吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] rebootBMS];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView showHudString:@"\"重启系统\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
                });
            }];
            break;
            
        case JXTBMSOperationClose:
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要关闭系统吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] closeBMSPower];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView showHudString:@"\"关闭系统\"操作成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
                });
            }];
            break;
            
        case JXTBMSOperationScreen:
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要切换屏幕吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
              [[JXTBluetooth sharedInstance] switchingScreen];
            }];
            break;
            
        case JXTBMSOperationBalance:
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要开启自动均衡吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] configAutoBalance];
            }];
            break;
            
        case JXTBMSOperationZero:
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要电流归零吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] clearBMSCurrent];
            }];
            break;
    }
    
}

@end
