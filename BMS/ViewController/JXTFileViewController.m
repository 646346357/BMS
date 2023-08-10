//
//  JXTFileViewController.m
//  BMS
//
//  Created by qinwen on 2019/4/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTFileViewController.h"
#import "JXTFileCell.h"

@interface JXTFileViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation JXTFileViewController

#pragma mark - Life Cycle

- (instancetype)initWithPath:(NSString *)path type:(JXTFileViewControllerType)type{
    if (self = [super init]) {
        _path = [path copy];
        _type = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Private Method

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupNavigationBar {
    if (JXTFileViewControllerTypeLog == _type) {
        self.title = @"运行日志";
    } else {
        self.title = @"升级文件";
    }
    
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

#pragma mark - Action Method

-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *title = self.datasource[indexPath.row];
    NSString *path = [self.path stringByAppendingPathComponent:title];
    __weak typeof(self) weakSelf = self;
    if (JXTFileViewControllerTypeLog == _type) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"预览日志" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[JXTDocumentManager sharedInstance] presentDocumentInteractionControllerWithPreviewController:weakSelf url:[NSURL fileURLWithPath:path] preview:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"导出日志" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[JXTDocumentManager sharedInstance] presentDocumentInteractionControllerWithPreviewController:weakSelf url:[NSURL fileURLWithPath:path] preview:NO];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
  
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        if (![JXTBluetooth sharedInstance].peripheralConnnected) {
            [UIView showHudString:@"您尚未连接任何BMS设备" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        NSData *binData = [[JXTDocumentManager sharedInstance] readBinFileWithPath:path];
        if (!binData) {
            [SVProgressHUD showErrorWithStatus:@"未检测到升级文件"];
            return;
        }
        [JXTAlertViewController presentAlertControllerWithTitle:@"确定要升级固件吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
            [UIView showActivityIndicatorViewWithString:@"准备升级,请稍候..."];
            [[JXTBluetooth sharedInstance] systemUpdateWithData:binData completion:^(BOOL isSccess) {
                [UIView dismissActivityIndicatorView];
                if (isSccess) {
                    [JXTAlertViewController presentAlertControllerWithTitle:@"升级成功！" level:JXTAlertViewControllerSuccess confirmBlock:nil];
                } else {
                    [JXTAlertViewController presentAlertControllerWithTitle:@"升级失败！" level:JXTAlertViewControllerFail confirmBlock:nil];
                }
            }];
        }];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JXTFileCell";
    JXTFileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXTFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *title = self.datasource[indexPath.row];
    NSString *path = [self.path stringByAppendingPathComponent:title];
    long long size = 0;
    if ([manager fileExistsAtPath:path]){
        size = [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    [cell configCellWithTitle:title size:size];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.datasource[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [JXTAlertViewController presentAlertControllerWithTitle:@"确定要删除该文件吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
        BOOL isSuccess = [[JXTDocumentManager sharedInstance] removeFileAtPath:[weakSelf.path stringByAppendingPathComponent:title]];
        if (!isSuccess) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            return;
        }
        [weakSelf.datasource removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
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
        tableView.rowHeight = 65;
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

- (NSMutableArray *)datasource{
    if (!_datasource) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *err;
        NSArray *files = [manager contentsOfDirectoryAtPath:_path error:nil];
        if (err || !files) {
            return [@[] mutableCopy];
        } else {
            _datasource = [[files sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return -[obj1 compare:obj2];
            }] mutableCopy];
        }
    }
    
    return _datasource;
}
@end
