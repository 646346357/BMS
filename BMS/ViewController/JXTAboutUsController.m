//
//  JXTAboutUsController.m
//  BMS
//
//  Created by qinwen on 2019/4/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTAboutUsController.h"
#import "JXTWebViewController.h"

@interface JXTAboutUsController ()

@end

@implementation JXTAboutUsController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self setupNavigationBar];
}

#pragma mark - Private Method

- (void)setupNavigationBar {
    self.title = @"关于我们";
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

- (void)setupSubViews {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    
    UIImageView *logo = JXT_IMAGE_VIEW(@"icon_logo");
    [contentView addSubview:logo];
    
    NSString *version = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UILabel *versionLabel = [UILabel labelWithText:[NSString stringWithFormat:@"版本号：%@",version] font:[UIFont fontOfSize_12] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    [contentView addSubview:versionLabel];
    
    UILabel *contentLabel = [UILabel labelWithText:@"\t蚂蚁兴能起源于2014年，至今为止，线上智能BMS销量NO.1。随着公司的发展壮大，融合了深圳沃特玛，比亚迪，霍英东研究院等新能源行业人才。实现了从软硬件研发，PCB 贴片，到线上线下销售一条龙服务。\n\t同时公司构建了自己的采购体系，与原厂、代理商建立了量好的合作关系，保证了产品的品质和交期。\n\t公司主打产品为低压BMS，主要在 32串 以下应用，累计出货 50K+。\n\t广泛应用于低速车，低压储能，电动摩托车 等锂电市场。" font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft lineSpacing:12 kern:0 headIndent:0];
    [contentView addSubview:contentLabel];
    
    UILabel *webLabel = [UILabel labelWithText:@"蚂蚁兴能官网：" font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [contentView addSubview:webLabel];
    
    UIButton *webBtn = [UIButton buttonWithTitle:@"http://mayibms.com/index.html" font:[UIFont fontOfSize_14] titleColor:[UIColor defaultItemColor] target:self selector:@selector(webAction:)];
    [contentView addSubview:webBtn];
    
    UILabel *copyrightLabel = [UILabel labelWithText:@"Copyright 2018 © 十堰小蚂蚁电子科技有限公司" font:[UIFont fontOfSize_11] textColor:JXT_HEX_COLOR(0x999999) textAlignment:NSTextAlignmentCenter];
    [contentView addSubview:copyrightLabel];
    
    UILabel *recordLabel = [UILabel labelWithText:@"鄂ICP备13072051号-1" font:[UIFont fontOfSize_11] textColor:JXT_HEX_COLOR(0x999999) textAlignment:NSTextAlignmentCenter];
    [contentView addSubview:recordLabel];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(50);
        make.centerX.equalTo(contentView);
        make.size.equalTo(CGSizeMake(80, 80));
    }];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logo.mas_bottom).offset(10);
        make.centerX.equalTo(contentView);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLabel.mas_bottom).offset(50);
        make.left.equalTo(15);
        make.centerX.equalTo(contentView);
    }];
    
    [webLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(16);
        make.left.equalTo(contentLabel);
        make.height.equalTo(15);
    }];
    
    [webBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(webLabel);
        make.left.equalTo(webLabel.mas_right);
        make.right.lessThanOrEqualTo(contentLabel);
    }];
    
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(webBtn.mas_bottom).offset(50);
        make.centerX.equalTo(contentLabel);
    }];
    
    [recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyrightLabel.mas_bottom).offset(6);
        make.centerX.equalTo(contentLabel);
        make.bottom.equalTo(contentView.mas_bottom).offset(-50);
    }];
}

#pragma mark - Action Method

- (void)webAction:(UIButton *)sender{
    JXTWebViewController *webVc = [[JXTWebViewController alloc] initWithUrl:sender.titleLabel.text];
    webVc.title = @"蚂蚁兴能官网";
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)returnBtnDidClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
