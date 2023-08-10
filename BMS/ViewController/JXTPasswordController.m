//
//  JXTPasswordController.m
//  BMS
//
//  Created by qinwen on 2019/4/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTPasswordController.h"
#import "JXTLineButton.h"

static const NSTimeInterval kupdateTimeout = 60;

@interface JXTPasswordController (){
    JXTLineButton *_verifyBtn;
    JXTLineButton *_modifyBtn;
    UITextField *_verifyTextField;
    UITextField *_modifyTextField;
    UIView *_modifyTextFieldBg;
}

@end

@implementation JXTPasswordController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupSubViews];
    [self addNotification];
}

- (void)dealloc{
    [self removeNotification];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - Private Method

- (void)settingPasswordTimeout{
    NSString *hud = _verifyBtn.selected ? @"验证密码失败" : @"修改密码失败";
    [UIView dismissActivityIndicatorView];
    [UIView showHudString:hud stayDuration:1 animationDuration:0 hudDidHide:nil];
}

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryValueDidWrite:) name:JXT_CHARACTERISTIC_READ_VALUE_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setupSubViews {
    UIImageView *logo = JXT_IMAGE_VIEW(@"icon_logo1");
    [self.view addSubview:logo];
    
    JXTLineButton *verifyBtn = [JXTLineButton buttonWithTitle:@"验证密码" normalColor:[UIColor defaultBlackColor] selectedColor:[UIColor defaultItemColor] normalFont:[UIFont fontOfSize_15] selectedFont:[UIFont fontOfSize_16]];
    [verifyBtn addTarget:self action:@selector(lineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    verifyBtn.selected = YES;
    [self.view addSubview:verifyBtn];
    _verifyBtn = verifyBtn;
    
    JXTLineButton *modifyBtn = [JXTLineButton buttonWithTitle:@"修改密码" normalColor:[UIColor defaultBlackColor] selectedColor:[UIColor defaultItemColor] normalFont:[UIFont fontOfSize_15] selectedFont:[UIFont fontOfSize_16]];
    [modifyBtn addTarget:self action:@selector(lineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyBtn];
    _modifyBtn = modifyBtn;
    
    UIView *line = [UIView lineView];
    [self.view addSubview:line];
    
    UIView *verifyTextFieldBg = [self textFieldViewWithImage:JXT_IMAGE(@"setting_check") placeholder:@"请输入密码验证" indedx:0];
    [self.view addSubview:verifyTextFieldBg];
    
    UIView *modifyTextFieldBg = [self textFieldViewWithImage:JXT_IMAGE(@"setting_password") placeholder:@"请再次输入8位新密码" indedx:1];
    modifyTextFieldBg.hidden = YES;
    [self.view addSubview:modifyTextFieldBg];
    _modifyTextFieldBg = modifyTextFieldBg;
    
    UIButton *sureBtn = [UIButton buttonWithBackgroundImage:JXT_IMAGE(@"button_sure") title:@"确定" font:[UIFont fontOfSize_16] titleColor:[UIColor whiteColor] target:self selector:@selector(sureBtnClicked:)];
    [self.view addSubview:sureBtn];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(72);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(82, 82));
    }];
    
    [verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verifyTextFieldBg.mas_left).offset(30);
        make.width.equalTo(80);
        make.height.equalTo(34);
        make.top.equalTo(logo.mas_bottom).offset(55);
    }];
    
    [modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(verifyBtn);
        make.right.equalTo(modifyTextFieldBg.mas_right).offset(-30);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(verifyTextFieldBg);
        make.top.equalTo(verifyBtn.mas_bottom);
        make.height.equalTo(JXT_LINE_WIDTH);
    }];
    
    [verifyTextFieldBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(sureBtn);
        make.height.equalTo(64);
        make.top.equalTo(line.mas_bottom);
    }];
    
    [modifyTextFieldBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(verifyTextFieldBg);
        make.top.equalTo(verifyTextFieldBg.mas_bottom);
        make.height.equalTo(0);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(modifyTextFieldBg.mas_bottom).offset(45);
        make.centerX.equalTo(self.view);
    }];
}

- (UIView *)textFieldViewWithImage:(UIImage *)image placeholder:(NSString *)placeholder indedx:(NSUInteger)index{
    UIView *view = [[UIView alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [view addSubview:imageView];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
    textField.attributedPlaceholder = [NSAttributedString stringWithString:placeholder color:JXT_HEX_COLOR(0x999999) font:[UIFont fontOfSize_14] verticalAlignment:JXTVerticalAlignmentMiddle];
    textField.textColor = [UIColor defaultBlackColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.font = [UIFont fontOfSize_14];
    textField.secureTextEntry = YES;
    [view addSubview:textField];
    if (0 == index) {
        _verifyTextField = textField;
    } else {
        _modifyTextField = textField;
    }
    
    UIView *line = [UIView lineView];
    [view addSubview:line];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(6);
        make.size.equalTo(CGSizeMake(20, 20));
        make.bottom.equalTo(-16);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(line);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(view);
        make.height.equalTo(JXT_LINE_WIDTH);
    }];
    
    return view;
}

- (void)setupNavigationBar {
    self.title = @"验证密码和修改密码";
    UIButton *returnBtn = [UIButton buttonWithImage:JXT_IMAGE(@"nav_back") target:self selector:@selector(returnBtnDidClicked:)];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
}

#pragma mark - Action Method

- (void)batteryValueDidWrite:(NSNotification *)ntf{
    NSData *data = ntf.object;
    NSLog(@"data=====%@", data);
    Byte *byte = [BabyToy ConvertDataToByteArray:data];
    Byte addr = byte[2];
    if (addr == 241 || addr == 242 || addr == 243 || addr == 244) {//验证密码
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(settingPasswordTimeout) object:nil];
        [UIView dismissActivityIndicatorView];
        [UIView showHudString:@"验证密码成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } else if(addr == 102 || addr == 103 || addr == 104 || addr == 105) {//修改密码
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(settingPasswordTimeout) object:nil];
        [UIView dismissActivityIndicatorView];
        [UIView showHudString:@"修改密码成功" stayDuration:1 animationDuration:0 hudDidHide:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)returnBtnDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lineBtnClicked:(JXTLineButton *)sender{
    if (sender.selected) {
        return;
    }
    
    CGFloat height;
    BOOL hidden;
    __weak typeof(self) weakSelf = self;
    _verifyTextField.text = nil;
    _modifyTextField.text = nil;
    if (sender == _verifyBtn) {
        _verifyBtn.selected = YES;
        _modifyBtn.selected = NO;
        _verifyTextField.attributedPlaceholder = [NSAttributedString stringWithString:@"请输入密码验证" color:JXT_HEX_COLOR(0x999999) font:[UIFont fontOfSize_14] verticalAlignment:JXTVerticalAlignmentMiddle];
        hidden = YES;
        height = 0;
    } else {
        _verifyBtn.selected = NO;
        _modifyBtn.selected = YES;
        _verifyTextField.attributedPlaceholder = [NSAttributedString stringWithString:@"请输入8位新密码" color:JXT_HEX_COLOR(0x999999) font:[UIFont fontOfSize_14] verticalAlignment:JXTVerticalAlignmentMiddle];
        hidden = NO;
        height = 64;
    }
    [UIView animateWithDuration:.3 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf->_modifyTextFieldBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height);
        }];
        strongSelf->_modifyTextFieldBg.hidden = hidden;
        [strongSelf.view layoutIfNeeded];
    }];
}

- (void)sureBtnClicked:(UIButton *)sender{
    [UIResponder jxt_resignFirstResponder];
    if (_verifyBtn.selected) {//验证密码
        if (0 == _verifyTextField.text.length){
            [UIView showHudString:@"请输入验证码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        if (_verifyTextField.text.length != 8) {
            [UIView showHudString:@"请输入8位验证码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        [[JXTBluetooth sharedInstance] verifyPassword:_verifyTextField.text];
    } else {//修改密码
        if (0 == _verifyTextField.text.length){
            [UIView showHudString:@"请输入新密码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        if (_verifyTextField.text.length != 8) {
            [UIView showHudString:@"请输入8位新密码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        if (0 == _modifyTextField.text.length){
            [UIView showHudString:@"请再次输入密码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        if (_modifyTextField.text.length != 8) {
            [UIView showHudString:@"请再次输入8位新密码" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        if (![_verifyTextField.text isEqualToString:_modifyTextField.text]){
            [UIView showHudString:@"两次输入密码不一致" stayDuration:1 animationDuration:0 hudDidHide:nil];
            return;
        }
        [[JXTBluetooth sharedInstance] modifyPassword:_modifyTextField.text];
    }
    [UIView showActivityIndicatorViewWithString:@"请稍候..."];
    [self performSelector:@selector(settingPasswordTimeout) withObject:nil afterDelay:kupdateTimeout];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIResponder jxt_resignFirstResponder];
}

@end
