//
//  JXTLogViewController.m
//  BMS
//
//  Created by qinwen on 2019/4/17.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTLogViewController.h"
#import "JXTLogCell.h"

@interface JXTLogViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *chargeLabel;
@property (nonatomic, strong) UILabel *dischargeLabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@end

@implementation JXTLogViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupSubViews];
    [self addNotification];
    [self.tableView reloadData];
    
    __weak typeof(self) weakSelf = self;
    [[JXTLogManager sharedInstance] logDidChangedBlock:^(NSArray *logs) {
        [weakSelf.tableView reloadData];
    }];
}

- (void)dealloc{
    [self removeNotification];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - Private method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryInfoDidChanged:) name:JXT_BATTERY_INFO_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setupNavigationBar {
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setupTableHeaderView];
}

- (void)setupTableHeaderView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, 143)];
    self.tableView.tableHeaderView = bgView;
    [self.tableView layoutIfNeeded];
    
    UIImageView *bg = JXT_IMAGE_VIEW(@"bg_log1");
    [bgView addSubview:bg];
    
    UILabel *timeDescLabel = [UILabel labelWithText:@"运行时间：" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:timeDescLabel];
    
    UILabel *timeLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIView *line = [UIView lineView];
    [bg addSubview:line];
    
    UILabel *chargeDescLabel = [UILabel labelWithText:@"充电MOS：" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:chargeDescLabel];
    
    UILabel *chargeLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:chargeLabel];
    self.chargeLabel = chargeLabel;
    
    UILabel *dischargeDescLabel = [UILabel labelWithText:@"放电MOS：" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:dischargeDescLabel];
    
    UILabel *dischargeLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:dischargeLabel];
    self.dischargeLabel = dischargeLabel;
    
    UILabel *balanceDescLabel = [UILabel labelWithText:@"均衡：" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:balanceDescLabel];
    
    UILabel *balanceLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:balanceLabel];
    self.balanceLabel = balanceLabel;
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(14);
        make.bottom.equalTo(bgView.mas_bottom).offset(-9);
        make.left.equalTo(10);
    }];
    
    [timeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(17);
        make.left.equalTo(21);
        make.height.equalTo(15);
        make.right.equalTo(chargeDescLabel);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(timeDescLabel);
        make.left.equalTo(timeDescLabel.mas_right);
        make.right.equalTo(bgView.mas_right).offset(-21);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeDescLabel);
        make.right.equalTo(timeLabel);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.top.equalTo(timeDescLabel.mas_bottom).offset(12);
    }];
    
    [chargeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(15);
        make.left.equalTo(line);
        make.height.equalTo(timeDescLabel);
        make.width.equalTo([chargeDescLabel widthOfLabelWithFixedHeight:MAXFLOAT]);
    }];
    
    [chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(chargeDescLabel);
        make.left.equalTo(chargeDescLabel.mas_right);
        make.right.equalTo(line);
    }];
    
    [dischargeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(chargeDescLabel);
        make.left.equalTo(line.mas_centerX);
    }];
    
    [dischargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(dischargeDescLabel);
        make.left.equalTo(dischargeDescLabel.mas_right);
        make.right.equalTo(line);
    }];
    
    [balanceDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chargeDescLabel.mas_bottom).offset(12);
        make.left.equalTo(line);
        make.height.right.equalTo(chargeDescLabel);
    }];
    
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(balanceDescLabel);
        make.left.equalTo(balanceDescLabel.mas_right);
        make.right.equalTo(line);
    }];
}

#pragma mark - Action Method

-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)batteryInfoDidChanged:(NSNotification *)ntf{
    JXTBatteryInfoManager *manager = [JXTBatteryInfoManager sharedInstance];
    self.timeLabel.text = manager.timeinterval.display;
    self.chargeLabel.text = manager.chargeMosState.display;
    self.dischargeLabel.text = manager.dischargeMosState.display;
    self.balanceLabel.text = manager.balanceState.display;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *datasource = [JXTLogManager sharedInstance].logArray;
    return datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTLogCell";
    JXTLogCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    [cell configCellWithLog:[JXTLogManager sharedInstance].logArray[indexPath.row]];
    
    return cell;
}

@end
