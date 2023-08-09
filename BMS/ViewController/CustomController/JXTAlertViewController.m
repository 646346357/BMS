//
//  JXTAlertViewController.m
//  BMS
//
//  Created by qinwen on 2019/4/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTAlertViewController.h"

@interface JXTAlertViewController (){
    
}

@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, assign) JXTAlertViewControllerLevel level;
@property (nonatomic, copy) JXTAlertViewControllerBlock block;

@end

@implementation JXTAlertViewController

#pragma mark - Life Cycle

+ (instancetype)presentAlertControllerWithTitle:(NSString *)title level:(JXTAlertViewControllerLevel)level confirmBlock:(JXTAlertViewControllerBlock)block {
    JXTAlertViewController *alert = [[[self class] alloc] init];
    alert.alertTitle = [title copy];
    alert.level = level;
    alert.block = [block copy];
    [alert setupSubviews];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:NO completion:nil];
    return alert;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:.2 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Private Method

- (void)setupSubviews{
    UIColor *confirmColor;
    UIImage *topImage;
    UIImage *centerImage;
    switch (self.level) {
        case JXTAlertViewControllerSuccess:
            confirmColor = [UIColor defaultItemColor];
            topImage = JXT_IMAGE(@"bg_success");
            centerImage = JXT_IMAGE(@"icon_success");
            break;
        case JXTAlertViewControllerFail:
            confirmColor = JXT_HEX_COLOR(0xff5a5a);
            topImage = JXT_IMAGE(@"bg_fail");
            centerImage = JXT_IMAGE(@"icon_fail");
            break;
        case JXTAlertViewControllerWarning:
            confirmColor = JXT_HEX_COLOR(0xffc41f);
            topImage = JXT_IMAGE(@"bg_warning");
            centerImage = JXT_IMAGE(@"icon_warning");
            break;
    }
    
    UIView *centerBgView = [[UIView alloc] initWithFrame:CGRectZero];
    centerBgView.backgroundColor = [UIColor whiteColor];
    centerBgView.center = [UIApplication sharedApplication].keyWindow.center;
    centerBgView.layer.cornerRadius = 15;
    centerBgView.layer.masksToBounds = YES;
    [self.view addSubview:centerBgView];
    [UIView animateWithDuration:.5 animations:^{
        centerBgView.jxt_size = CGSizeMake(290, 278);
        centerBgView.center = [UIApplication sharedApplication].keyWindow.center;
    }];
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.userInteractionEnabled = YES;
    topImageView.image = topImage;
    [centerBgView addSubview:topImageView];
    
    UIButton *closeBtn = [UIButton buttonWithImage:JXT_IMAGE(@"icon_close") target:self selector:@selector(closeBtnDidClicked:)];
    [centerBgView addSubview:closeBtn];
    
    UIView *centerImageBgView = [[UIView alloc] init];
    centerImageBgView.backgroundColor = [UIColor whiteColor];
    centerImageBgView.layer.cornerRadius = 45;
    [centerBgView addSubview:centerImageBgView];
    
    UIImageView *centerImageView = [[UIImageView alloc] init];
    centerImageView.userInteractionEnabled = YES;
    centerImageView.image = centerImage;
    [centerImageBgView addSubview:centerImageView];
    
    UILabel *titleLabel = [UILabel labelWithText:self.alertTitle font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentCenter lineSpacing:10 kern:0 headIndent:0];
    titleLabel.numberOfLines = 2;
    [centerBgView addSubview:titleLabel];
    
    UIView *line1 = [UIView lineView];
    [centerBgView addSubview:line1];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"取消" font:[UIFont fontOfSize_18] titleColor:JXT_HEX_COLOR(0x999999) target:self selector:@selector(cancelBtnDidClicked:)];
    [centerBgView addSubview:leftBtn];
    
    UIView *line2 = [UIView lineView];
    [centerBgView addSubview:line2];
    
    UIButton *rightBtn = [UIButton buttonWithTitle:@"确定" font:[UIFont fontOfSize_18] titleColor:confirmColor target:self selector:@selector(confirmBtnDidClicked:)];
    [centerBgView addSubview:rightBtn];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerBgView);
        make.height.equalTo(90);
    }];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(centerBgView);
        make.size.equalTo(CGSizeMake(closeBtn.currentImage.size.width+20, closeBtn.currentImage.size.height+20));
    }];
    
    [centerImageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(35);
        make.size.equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(centerBgView);
    }];
    
    [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(centerImageBgView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(27);
        make.top.equalTo(centerImageView.mas_bottom).offset(30);
        make.centerX.equalTo(centerBgView);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(JXT_LINE_WIDTH);
        make.left.right.equalTo(centerBgView);
        make.bottom.equalTo(leftBtn.mas_top);
    }];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(centerBgView);
        make.height.equalTo(51);
        make.right.equalTo(line2);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBtn);
        make.width.equalTo(JXT_LINE_WIDTH);
        make.centerX.equalTo(centerBgView);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBtn);
        make.right.equalTo(centerBgView);
        make.left.equalTo(line2.mas_right);
    }];
}

#pragma mark - Action Method

- (void)closeBtnDidClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)cancelBtnDidClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)confirmBtnDidClicked:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        if (weakSelf.block) {
            weakSelf.block();
        }
    }];
}

@end
