//
//  JXTRealtimeStatusController.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTRealtimeStatusController.h"
#import "JXTRealtimeHeaderView.h"
#import "JXTDeviceListController.h"
#import "JXTBatteryCell.h"

@interface JXTRealtimeStatusController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXTRealtimeHeaderView *headerView;

@end

@implementation JXTRealtimeStatusController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavigationBar];
    [self setupSubViews];
    if(![JXTBluetooth sharedInstance].peripheralConnnected){
        [self deviceBtnDidClicked:nil];
    }
    [self addNotification];
}

- (void)dealloc{
    [self removeNotification];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerView updateStates];
}

#pragma mark - Private method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryInfoDidChanged:) name:JXT_BATTERY_INFO_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDisconnect:) name:JXT_PERIPHERAL_DISCONNECTED_NOTIFY object:nil];
    [center addObserver:self selector:@selector(centralStateChanged:) name:JXT_CENTRAL_STATE_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setupNavigationBar {
    self.navigationItem.titleView = JXT_IMAGE_VIEW(@"logo");
    UIButton *deviceBtn = [UIButton buttonWithTitle:NSLocalizedString(@"device_list", nil) font:[UIFont fontOfSize_15] titleColor:[UIColor whiteColor] target:self selector:@selector(deviceBtnDidClicked:)];
    deviceBtn.frame = CGRectMake(0, 0, 80, 32);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deviceBtn];
}

- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 35;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    JXTRealtimeHeaderView *header = [[JXTRealtimeHeaderView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, 500)];
    tableView.tableHeaderView = header;
    self.headerView = header;
    [tableView layoutIfNeeded];
    [header setupSubviews];
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    header.frame = CGRectMake(0, 0, JXT_SCREEN_WIDTH, height);
}

#pragma mark - Action Method

- (void)deviceBtnDidClicked:(UIButton *)sender {
    JXTDeviceListController *deviceVc = [[JXTDeviceListController alloc] init];
    deviceVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:deviceVc animated:YES];
}

- (void)batteryInfoDidChanged:(NSNotification *)ntf{
    [self.headerView updateStates];
    [self.tableView reloadData];
}

- (void)peripheralDisconnect:(NSNotification *)ntf{
    [self.headerView updateStates];
    [self.tableView reloadData];
}

- (void)centralStateChanged:(NSNotification *)ntf{
    [self.headerView updateStates];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *datasource = [JXTBatteryInfoManager sharedInstance].voltageArray;
    return datasource.count/2 + datasource.count % 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTBatteryCell";
    NSArray *datasource = [JXTBatteryInfoManager sharedInstance].voltageArray;
    JXTBatteryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTBatteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    JXTInfoDetails *left = datasource[indexPath.row*2];
    JXTInfoDetails *right = nil;
    if (datasource.count > indexPath.row*2+1) {
        right = datasource[indexPath.row*2+1];
    }
    [cell configCellWithLeftInfo:left rightInfo:right];
    
    return cell;
}

@end
