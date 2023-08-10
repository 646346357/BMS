//
//  JXTConnectController.m
//  BMS
//
//  Created by qinwen on 2019/4/10.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTConnectController.h"
#import "JXTTabBarController.h"

static const NSTimeInterval kCountDown = 60;

@interface JXTConnectController (){
    
}

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIImageView *circle;

@end

@implementation JXTConnectController

#pragma mark - LifeCycle Method

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSubviews];
    [self addNotification];
    [JXTBluetooth sharedInstance];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:kCountDown target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
    [self addAniamation];
    
    //test
    [self skipBtnDidClicked:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (CBCentralManagerStatePoweredOn == [JXTBluetooth sharedInstance].baby.centralManager.state) {
        [[JXTBluetooth sharedInstance].baby scanPeriphrals];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[JXTBluetooth sharedInstance].baby cancelScan];
}

- (void)dealloc{
    NSLog(@"%s", __func__);
    [self removeNotification];
    [self disconnectBMSIfNeeded];
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(centralStateDidChanged:) name:JXT_CENTRAL_STATE_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidDiscover:) name:JXT_PERIPHERAL_DISCOVER_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidConnected:) name:JXT_PERIPHERAL_CONNECTED_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidConnecteFail:) name:JXT_PERIPHERAL_CONNECTE_FAIL_NOTIFY object:nil];
    [center addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)disconnectBMSIfNeeded {
    if (![JXTBluetooth sharedInstance].peripheralConnnected) {
        [[JXTBluetooth sharedInstance] cancelConnect];
    }
}

- (void)setupNavigationBar {
    self.navigationItem.titleView = JXT_IMAGE_VIEW(@"logo");
    
    UIButton *skipBtn = [UIButton buttonWithTitle:@"跳过" font:[UIFont fontOfSize_15] titleColor:[UIColor whiteColor] target:self selector:@selector(skipBtnDidClicked:)];
    skipBtn.frame = CGRectMake(0, 0, 40, 32);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:skipBtn];
}

- (void)setupSubviews {
    UILabel *label1 = [UILabel labelWithText:@"正在扫描设备..." font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label1];
    self.label1 = label1;
    
    UILabel *label2 = [UILabel labelWithText:@"正在连接...静稍候" font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label2];
    label2.hidden = YES;
    self.label2 = label2;
    
    UIImageView *bottomBg = JXT_IMAGE_VIEW(@"bg_connect");
    [self.view addSubview:bottomBg];
    
    UIImageView *circle = JXT_IMAGE_VIEW(@"bluetooth_circle");
    [self.view addSubview:circle];
    self.circle = circle;
    
    UIImageView *icon = JXT_IMAGE_VIEW(@"icon_bluetooth");
    [self.view addSubview:icon];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(120);
        make.centerX.equalTo(self.view);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(24);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(214, 214));
    }];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(circle);
    }];
    
    [bottomBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)addAniamation{
    [self removeAnimation];
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(-M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = .3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [self.circle.layer addAnimation:animation forKey:@"key"];
}

- (void)removeAnimation{
    [self.circle.layer removeAnimationForKey:@"key"];
}


#pragma mark - Action Method

- (void)timeout:(NSTimer *)timer {
    __weak typeof(self) weakSelf = self;
    [JXTAlertViewController presentAlertControllerWithTitle:@"附近没有可连接设备了，请检查" level:JXTAlertViewControllerWarning confirmBlock:^{
        [weakSelf skipBtnDidClicked:nil];
    }];
}

- (void)skipBtnDidClicked:(UIButton *)sender{
    JXTTabBarController *tabbar = [[JXTTabBarController alloc] init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabbar];
    [self.countdownTimer invalidate];
}

- (void)centralStateDidChanged:(NSNotification *)ntf {
    CBCentralManager *central = ntf.object;
    if (CBCentralManagerStatePoweredOn == central.state) {
        [[JXTBluetooth sharedInstance].baby scanPeriphrals];
    } else {
        [[JXTBluetooth sharedInstance] cancelConnect];
    }
}

- (void)peripheralDidDiscover:(NSNotification *)ntf {
    NSDictionary *dic = ntf.object;
    NSNumber *RSSI = dic[@"RSSI"];
//    NSDictionary *advertisementData = dic[@"advertisementData"];
    CBPeripheral *peripheral = dic[@"peripheral"];
    if ([RSSI integerValue] > 0) {
        return;
    }
    if([JXTBluetooth sharedInstance].peripheralConnnected){
        return;
    }
    if (![peripheral.name.lowercaseString containsString:@"bms"]) {
        return;
    }
    //正在连接的设备。。。
    if ([JXTBluetooth sharedInstance].currentPeripheral && [peripheral.identifier.UUIDString isEqual:[JXTBluetooth sharedInstance].currentPeripheral.identifier.UUIDString]) {
        return;
    }
    
    self.label1.text = [NSString stringWithFormat:@"发现设备%@",peripheral.name];
    self.label2.hidden = NO;
    [[JXTBluetooth sharedInstance] cancelConnect];
    [[JXTBluetooth sharedInstance] connectPeripheral:peripheral];
}

- (void)peripheralDidConnected:(NSNotification *)ntf {
    [self skipBtnDidClicked:nil];
}

- (void)peripheralDidConnecteFail:(NSNotification *)ntf {
    CBPeripheral *p = ntf.object;
    [JXTAlertViewController presentAlertControllerWithTitle:[NSString stringWithFormat:@"%@连接失败",p.name] level:JXTAlertViewControllerFail confirmBlock:^{
        [SVProgressHUD showInfoWithStatus:@"正在尝试重连，请稍候..."];
    }];
}

- (void)applicationDidBecomeActive:(NSNotification *)ntf {
    [self addAniamation];
}

@end
