//
//  JXTSystemController.m
//  BMS
//
//  Created by qinwen on 2019/4/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTSystemController.h"
#import "JXTAboutUsController.h"
#import "JXTPasswordController.h"
#import "JXTFolderController.h"
#import "JXTFileViewController.h"
#import "JXTSystemCell.h"

@interface JXTSystemController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JXTSystemController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubViews];
    [self setupNavigationBar];
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    if (addr == 0xfd) {
        [SVProgressHUD showSuccessWithStatus:@"恢复出厂设置成功"];
        [self.tableView reloadData];
    }
}


-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
            if (![JXTBluetooth sharedInstance].peripheralConnnected) {
                [UIView showHudString:@"您尚未连接任何BMS设备" stayDuration:1 animationDuration:0 hudDidHide:nil];
                return;
            }
            [JXTAlertViewController presentAlertControllerWithTitle:@"确定要恢复出厂设置？" level:JXTAlertViewControllerWarning confirmBlock:^{
                [[JXTBluetooth sharedInstance] configRestoreFactorySettings];
            }];
            break;
        }
            
        case 1:{
            JXTFileViewController *fileVc = [[JXTFileViewController alloc] initWithPath:[JXTDocumentManager sharedInstance].binPath type:JXTFileViewControllerTypeBin];
            [self.navigationController pushViewController:fileVc animated:YES];
            break;
        }
            
        case 2:{
            JXTAboutUsController *aboutUsVc = [[JXTAboutUsController alloc] init];
            [self.navigationController pushViewController:aboutUsVc animated:YES];
            break;
        }
            
        case 3:{
            JXTPasswordController *passwordVc = [[JXTPasswordController alloc] init];
            [self.navigationController pushViewController:passwordVc animated:YES];
            break;
        }
            
        case 4:{
            JXTFolderController *folderVc = [[JXTFolderController alloc] initWithPath:[JXTDocumentManager sharedInstance].logPath];
            [self.navigationController pushViewController:folderVc animated:YES];
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTSystemCell";
    JXTSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTSystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *title = self.datasource[indexPath.row];
    BOOL hideArrow = (0 == indexPath.row);
    [cell configCellWithTitle:title hideArrow:hideArrow];
    
    return cell;
}


#pragma mark - Getter Method

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
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

