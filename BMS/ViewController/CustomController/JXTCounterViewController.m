//
//  JXTCounterViewController.m
//  SplendidGarden
//
//  Created by qinwen on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTCounterViewController.h"

@interface JXTCounterViewController ()<UITextFieldDelegate> {
    UITextField *_numberTextField;
}

@end

@implementation JXTCounterViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [_numberTextField becomeFirstResponder];
}


#pragma mark - Private Method

- (void)setupSubViews {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    UILabel *titleLabel = [UILabel labelWithText:@"请输入参数" font:[UIFont systemFontOfSize:14] textColor:JXT_HEX_COLOR(0x323232) textAlignment:NSTextAlignmentCenter];
    [bgView addSubview:titleLabel];
    
    UIView *textBgView = [[UIView alloc] init];
    textBgView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:textBgView];
    
    UITextField *numberTextField = [[UITextField alloc] init];
    numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    numberTextField.textAlignment = NSTextAlignmentCenter;
    numberTextField.font = [UIFont systemFontOfSize:21];
    numberTextField.textColor = JXT_HEX_COLOR(0x323232);
    numberTextField.tintColor = [UIColor defaultItemColor];
    numberTextField.delegate = self;
    [textBgView addSubview:numberTextField];
    _numberTextField = numberTextField;
    
    UIView *textLine = [[UIView alloc] init];
    textLine.backgroundColor = [UIColor defaultItemColor];
    [textBgView addSubview:textLine];
    
    UIView *line = [UIView lineView];
    [bgView addSubview:line];
    
    UIButton *cancelBtn = [UIButton buttonWithBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] title:@"取消" font:[UIFont systemFontOfSize:17] titleColor:JXT_HEX_COLOR(0x595757) target:self selector:@selector(cancelButtonDidClicked:)];
    [bgView addSubview:cancelBtn];
    
    UIButton *okBtn = [UIButton buttonWithBackgroundImage:[UIImage imageWithColor:JXT_HEX_COLOR(0x21bd5f)] title:@"确定" font:[UIFont systemFontOfSize:17] titleColor:JXT_HEX_COLOR(0xffffff) target:self selector:@selector(okButtonDidClicked:)];
    [bgView addSubview:okBtn];

    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(240, 141));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.right.equalTo(bgView);
        make.height.equalTo(14);
    }];
    
    [textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(titleLabel.mas_bottom);
        make.bottom.equalTo(line.mas_top);
    }];
    
    [numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(textBgView);
        make.height.equalTo(20);
        make.left.equalTo(20);
    }];
    
    [textLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(numberTextField);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.bottom.equalTo(numberTextField);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.bottom.equalTo(cancelBtn.mas_top);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(bgView);
        make.height.equalTo(45);
        make.width.equalTo(okBtn);
    }];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.equalTo(cancelBtn);
        make.left.equalTo(cancelBtn.mas_right);
        make.right.equalTo(bgView);
    }];
}

#pragma mark - Action Method

- (void)cancelButtonDidClicked:(UIButton *)sender {
    [_numberTextField resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)okButtonDidClicked:(UIButton *)sender {
    [_numberTextField resignFirstResponder];
    if ([self.counterDelegate respondsToSelector:@selector(counterViewControllerDidInputText:)]) {
        [self.counterDelegate counterViewControllerDidInputText:_numberTextField.text];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}

@end
