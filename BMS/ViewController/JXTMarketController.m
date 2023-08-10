//
//  JXTMarketController.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTMarketController.h"
#import "JXTMarketCell.h"

static NSString *const kImageKey = @"kImageKey";
static NSString *const kContentKey = @"kContentKey";
static NSString *const kUrlKey = @"kUrlKey";

@interface JXTMarketController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation JXTMarketController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

#pragma mark - Private method

- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 159;
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JXT_SCREEN_WIDTH, 10)];
    header.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = header;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.datasource[indexPath.row];
    // 构建淘宝客户端协议的 URL
    NSURL *url = [NSURL URLWithString:dic[kUrlKey]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 判断当前系统是否有安装淘宝客户端
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            // 如果已经安装淘宝客户端，就使用客户端打开链接
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        } else {
            [UIAlertController showCommonAlertWithMessage:@"您尚未安装淘宝APP，请先前往App Store下载安装" action:^{
                NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/tao-bao-sui-shi-sui-xiang/id387682726?mt=8"];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTMarketCell";
    JXTMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTMarketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = self.datasource[indexPath.row];
    [cell configCellWithImage:dic[kImageKey] content:dic[kContentKey]];
    
    return cell;
}

#pragma mark - Getter & Setter

- (NSArray *)datasource{
    if (!_datasource) {
        _datasource = @[@{kImageKey: JXT_IMAGE(@"pic1"), kContentKey: @"蚂蚁保护板单体显示铁锂钛酸三元锂电池组均衡BMS管理系统库伦计", kUrlKey:@"taobao://item.taobao.com/item.htm?id=548548418029"},
                        @{kImageKey: JXT_IMAGE(@"pic2"), kContentKey: @"蚂蚁48V72V锂电池保护板bms聚合物18650磷酸铁锂钛酸锂同口带均衡", kUrlKey:@"taobao://item.taobao.com/item.htm?id=570909559482"},
                        @{kImageKey: JXT_IMAGE(@"pic3"), kContentKey: @"蚂蚁显示屏48V60V72V96V锂电池保护板大电流电瓶车三轮车均衡BMS", kUrlKey:@"taobao://item.taobao.com/item.htm?id=589681247198"},];
    }
    
    return _datasource;
}

@end
