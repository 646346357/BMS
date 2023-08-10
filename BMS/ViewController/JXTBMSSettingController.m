//
//  JXTBMSSettingController.m
//  BMS
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTBMSSettingController.h"
#import "JXTBMSSettingCell.h"

@interface JXTBMSSettingController ()<UITableViewDataSource, UITableViewDelegate, JXTBMSSettingCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JXTBMSSettingController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self setupNavigationBar];
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([JXTBluetooth sharedInstance].peripheralConnnected) {
        [[JXTBluetooth sharedInstance] readAllData];
    }
}

- (void)dealloc {
    [self removeNotification];
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryValueDidWrite:) name:JXT_CHARACTERISTIC_READ_VALUE_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setupSubViews {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor lineColor];
    [self.view addSubview:header];
    
    UILabel *leftLabel = [UILabel labelWithText:@"项目" font:[UIFont fontOfSize_14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [header addSubview:leftLabel];
    
    UILabel *middleLabel = [UILabel labelWithText:@"机器参数" font:[UIFont fontOfSize_14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [header addSubview:middleLabel];
    
    UILabel *rightLabel = [UILabel labelWithText:@"设定参数" font:[UIFont fontOfSize_14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight];
    [header addSubview:rightLabel];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(15);
        make.centerX.equalTo(self.view);
        make.height.equalTo(34);
    }];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.centerY.equalTo(header);
    }];
    
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(header);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).offset(-5);
        make.centerY.equalTo(header);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_bottom).offset(5);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)setupNavigationBar {
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

- (void)sendOrderWithCharacter:(JXTCharacter *)c {
    if ([c isKindOfClass:[JXTDoubleCharacter class]]) {
        JXTDoubleCharacter *doubleCharacter = (JXTDoubleCharacter *)c;
        BOOL needsSendHigh = NO;
        BOOL needsSendLow = NO;
        Byte bh[] = {0xa5, 0xa5, doubleCharacter.address, doubleCharacter.settingHighValue, doubleCharacter.settingLowValue, 0};
        Byte bl[] = {0xa5, 0xa5, doubleCharacter.next.address, doubleCharacter.next.settingHighValue, doubleCharacter.next.settingLowValue, 0};
        if (doubleCharacter.settingHighValue != doubleCharacter.highValue || doubleCharacter.settingLowValue != doubleCharacter.lowValue) {
            needsSendHigh = YES;
        }
        if (doubleCharacter.next.settingHighValue != doubleCharacter.next.highValue || doubleCharacter.next.settingLowValue != doubleCharacter.next.lowValue) {
            needsSendLow = YES;
        }
        if (needsSendHigh) {
            [[JXTBluetooth sharedInstance] sendWriteOrderWithBytes:bh];
        }
        if (needsSendLow) {
            [[JXTBluetooth sharedInstance] sendWriteOrderWithBytes:bl];
        }
    } else {
        if (c.settingHighValue == c.highValue && c.settingLowValue == c.lowValue) {
            return;
        }
        Byte b[] = {0xa5, 0xa5, c.address, c.settingHighValue, c.settingLowValue,0};
        [[JXTBluetooth sharedInstance] sendWriteOrderWithBytes:b];
    }
}

#pragma mark - Action Method

- (void)batteryValueDidWrite:(NSNotification *)ntf{
    NSData *data = ntf.object;
    Byte *byte = [BabyToy ConvertDataToByteArray:data];
    JXTBluetoothAddress addr = byte[2];
    JXTCharacter *c = [[JXTCharacterManager sharedInstance].charactDic objectForKey:@(addr)];
    if (c) {
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"设置%@成功", c.name]];
        [self.tableView reloadData];
    }
}

-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    [UIResponder jxt_resignFirstResponder];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [UIResponder jxt_resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTBMSSettingCell *settingCell = (JXTBMSSettingCell *)cell;
    settingCell.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTBMSSettingCell";
    JXTBMSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTBMSSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    JXTCharacter *c = self.datasource[indexPath.row];
    [cell configCellWithCharacter:c];

    return cell;
}

#pragma mark - JXTBMSSettingCellDelegate

- (void)BMSSettingCell:(JXTBMSSettingCell *)cell valueChanged:(NSString *)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    JXTCharacter *c = self.datasource[indexPath.row];
    c.settingValueText = [value copy];
}

- (void)BMSSettingCell:(JXTBMSSettingCell *)cell settingValue:(NSString *)value {
    if (0 == value.length) {
        return;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    JXTCharacter *c = self.datasource[indexPath.row];
    NSMutableString *message = [@"确定要设置" mutableCopy];
    [message appendString:c.name];
    if(!c.sendDefaultValueOnly) {
        [message appendString:c.settingValueText];
        if (c.unit.length > 0) {
            [message appendString:c.unit];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    [JXTAlertViewController presentAlertControllerWithTitle:message level:JXTAlertViewControllerWarning confirmBlock:^{
        [weakSelf sendOrderWithCharacter:c];
    }];
}

#pragma mark - Getter Method

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 56;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, JXT_BOTTOM_SAFE_HEIGHT)];
        footer.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = footer;
        _tableView = tableView;
    }
    
    return _tableView;
}

@end

