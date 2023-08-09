//
//  JXTWebViewController.m
//  BMS
//
//  Created by qinwen on 2019/4/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTWebViewController.h"

@interface JXTWebViewController (){
    
}

@property (nonatomic, copy) NSString *urlString;

@end

@implementation JXTWebViewController

#pragma mark - Life Cycle

- (instancetype)initWithUrl:(NSString *)urlString {
    if (self = [super init]) {
        _urlString = [urlString copy];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubViews];
    [self setupNavigationBar];
}

#pragma mark - Private Method

- (void)setupNavigationBar {
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

- (void)setupSubViews {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:request];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Action Method

- (void)returnBtnDidClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
