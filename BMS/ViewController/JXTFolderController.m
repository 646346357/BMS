//
//  JXTFolderController.m
//  BMS
//
//  Created by qinwen on 2019/4/29.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTFolderController.h"
#import "JXTFileViewController.h"
#import "JXTSystemCell.h"

@interface JXTFolderController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation JXTFolderController

#pragma mark - Life Cycle

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _path = [path copy];
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
    self.title = @"文件夹";
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
    JXTFileViewController *fileVc = [[JXTFileViewController alloc] initWithPath:[self.path stringByAppendingPathComponent:title] type:JXTFileViewControllerTypeLog];
    [self.navigationController pushViewController:fileVc animated:YES];
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
    [cell configCellWithTitle:title hideArrow:NO];
    
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
    [JXTAlertViewController presentAlertControllerWithTitle:@"删除文件夹会同时删除该文件夹下所有子文件，确定要删除吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
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

