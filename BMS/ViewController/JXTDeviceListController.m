//
//  JXTDeviceListController.m
//  BMS
//
//  Created by qinwen on 2019/4/10.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTDeviceListController.h"
#import "JXTPeripheralCell.h"

@interface JXTDeviceListController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *peripheralDataArray;
@property (nonatomic, strong) CBPeripheral *currentPeripheral;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation JXTDeviceListController

#pragma mark - LifeCycle Method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.peripheralDataArray = [[NSMutableArray alloc]init];
    if ([JXTBluetooth sharedInstance].currentPeripheral) {
        [self.peripheralDataArray addObject:[JXTBluetooth sharedInstance].currentPeripheral];
        self.currentPeripheral = [JXTBluetooth sharedInstance].currentPeripheral;
    }
    [self setupNavigationBar];
    [self setupSubviews];
    [self updateCountLabel];
    [self addNotification];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    if (CBCentralManagerStatePoweredOn == [JXTBluetooth sharedInstance].baby.centralManager.state) {
        [[JXTBluetooth sharedInstance].baby scanPeriphrals];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止扫描
    [[JXTBluetooth sharedInstance].baby cancelScan];
    [self disconnectBMSIfNeeded];
}

- (void)dealloc {
    [self removeNotification];
    NSLog(@"%s", __func__);
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(centralStateDidChanged:) name:JXT_CENTRAL_STATE_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidDiscover:) name:JXT_PERIPHERAL_DISCOVER_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidConnected:) name:JXT_PERIPHERAL_CONNECTED_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidConnecteFail:) name:JXT_PERIPHERAL_CONNECTE_FAIL_NOTIFY object:nil];
    [center addObserver:self selector:@selector(discoverCharacteristics:) name:JXT_CHARACTERISTIC_DISCOVER_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if ([RSSI integerValue] > 0) {
        return;
    }
    
    if(![self.peripheralDataArray containsObject:peripheral]) {
        BOOL isBMS = [[peripheral.name lowercaseString] containsString:@"bms"];
        NSInteger index = isBMS ? 0 : self.peripheralDataArray.count;
        [self.peripheralDataArray insertObject:peripheral atIndex:index];
        [self.tableView reloadData];
        [self updateCountLabel];
    }
}

- (void)disconnectBMSIfNeeded {
    if (![JXTBluetooth sharedInstance].peripheralConnnected) {
        [[JXTBluetooth sharedInstance] cancelConnect];
    }
}

- (void)setupNavigationBar {
    self.title = @"设备列表";
    
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

- (void)setupSubviews {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.rowHeight = 54;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, 54)];
    header.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = header;
    
    UILabel *counteLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    counteLabel.frame = CGRectMake(24, 0, JXT_SCREEN_WIDTH-48, 54);
    [header addSubview:counteLabel];
    self.countLabel = counteLabel;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(24, 54-JXT_LINE_WIDTH, JXT_SCREEN_WIDTH-48, JXT_LINE_WIDTH)];
    line.backgroundColor = [UIColor defaultGrayColor];
    [header addSubview:line];
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (JXT_IPHONE_X) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, JXT_BOTTOM_SAFE_HEIGHT)];
        footerView.backgroundColor = tableView.backgroundColor;
        tableView.tableFooterView = footerView;
    }
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)updateCountLabel{
    self.countLabel.text = [NSString stringWithFormat:@"附近的蓝牙设备（%lu）",(unsigned long)self.peripheralDataArray.count];
}

#pragma mark - Action Method

-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)centralStateDidChanged:(NSNotification *)ntf {
    CBCentralManager *central = ntf.object;
    if (CBCentralManagerStatePoweredOn == central.state) {
        [[JXTBluetooth sharedInstance].baby scanPeriphrals];
    } else {
        [[JXTBluetooth sharedInstance] cancelConnect];
        self.currentPeripheral = nil;
        [self.peripheralDataArray removeAllObjects];
        [self.tableView reloadData];
        [self updateCountLabel];
    }
}

- (void)peripheralDidDiscover:(NSNotification *)ntf {
    NSDictionary *dic = ntf.object;
    [self insertTableView:dic[@"peripheral"] advertisementData:dic[@"advertisementData"] RSSI:dic[@"RSSI"]];
}

- (void)peripheralDidConnected:(NSNotification *)ntf {
    self.currentPeripheral = nil;
    [self.tableView reloadData];
}

- (void)peripheralDidConnecteFail:(NSNotification *)ntf {
    self.currentPeripheral = nil;
    [self.tableView reloadData];
}

- (void)discoverCharacteristics:(NSNotification *)ntf {
    self.currentPeripheral = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    CBPeripheral *selectPeripheral = [self.peripheralDataArray objectAtIndex:indexPath.row];
    if (self.currentPeripheral && [self.currentPeripheral isEqual:selectPeripheral]) {
        return;
    }
    
    self.currentPeripheral = selectPeripheral;
    [[JXTBluetooth sharedInstance] cancelConnect];
    [[JXTBluetooth sharedInstance] connectPeripheral:selectPeripheral];
    [tableView reloadData];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peripheralDataArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTPeripheralCell";
    JXTPeripheralCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTPeripheralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell configCellWithPeripheral:self.peripheralDataArray[indexPath.row]];
    return cell;
}

@end
