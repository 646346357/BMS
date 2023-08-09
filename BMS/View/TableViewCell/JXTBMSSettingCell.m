//
//  JXTBMSSettingCell.m
//  BMS
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTBMSSettingCell.h"

@interface JXTBMSSettingCell ()<UITextFieldDelegate> {
    UILabel *_nameLabel;
    UILabel *_valueLabel;
    UITextField *_textField;
    UIButton *_settingBtn;
}

@end

@implementation JXTBMSSettingCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)setupSubViews {
    UILabel *titleLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:titleLabel];
    _nameLabel = titleLabel;
    
    UILabel *valueLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:valueLabel];
    _valueLabel = valueLabel;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
//    textField.tintColor = [UIColor defaultBlackColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont fontOfSize_16];
    textField.textColor = [UIColor defaultBlackColor];
    textField.layer.borderColor = [UIColor lineColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 6;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    _textField = textField;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.layer.cornerRadius = 6;
    settingBtn.layer.masksToBounds = YES;
    [settingBtn setBackgroundColor:[UIColor defaultItemColor]];
    [settingBtn setAttributedTitle:[NSAttributedString stringWithString:@"设置" color:[UIColor whiteColor] font:[UIFont fontOfSize_14] verticalAlignment:JXTVerticalAlignmentMiddle] forState:(UIControlState)UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:settingBtn];
    _settingBtn = settingBtn;
    
    UIView *bottomLine = [UIView lineView];
    [self.contentView addSubview:bottomLine];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLine.mas_left).offset(5);
        make.centerY.equalTo(self);
    }];
    
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(textField.mas_left).offset(-4);
        make.left.equalTo(titleLabel.mas_right);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(60, 30));
        make.right.equalTo(settingBtn.mas_left).offset(-10);
    }];
    
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(textField);
        make.width.equalTo(44);
        make.right.equalTo(bottomLine.mas_right).offset(-5);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerX.equalTo(self);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *valueString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *valueArray = [valueString componentsSeparatedByString:@"."];
    if (valueArray.count > 2) {
        return NO;
    }
    if (2 == valueArray.count) {
        NSString *decimal = [valueArray lastObject];
        if (decimal.length > 3) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Action Method

- (void)textFieldChanged:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(BMSSettingCell:valueChanged:)]) {
        [self.delegate BMSSettingCell:self valueChanged:textField.text];
    }
}

- (void)settingButtonClicked {
    [UIResponder jxt_resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(BMSSettingCell:settingValue:)]) {
        [self.delegate BMSSettingCell:self settingValue:_textField.text];
    }
}

#pragma mark - Public Method

- (void)configCellWithCharacter:(JXTCharacter *)character {
    if (character.sendDefaultValueOnly) {
        character.settingValueText = @"0";
    }
    _nameLabel.text = character.name;
    NSMutableString *value = [character.valueDisplay mutableCopy];
    if (character.unit.length > 0) {
        [value appendString:character.unit];
    }
    _valueLabel.text = value;
    _textField.text = character.settingValueText;
    if (character.isSignaled) {
        _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    } else {
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    if (character.readOnly) {
        _valueLabel.hidden = NO;
        _textField.hidden = YES;
        _settingBtn.hidden = YES;
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self->_settingBtn.mas_right).offset(-4);
            make.left.equalTo(self->_nameLabel.mas_right);
//            make.left.greaterThanOrEqualTo(self->_nameLabel);
//            make.right.lessThanOrEqualTo(self.mas_right).offset(-5);
//            make.center.equalTo(self);
        }];
    } else if (character.sendDefaultValueOnly) {
        _valueLabel.hidden = YES;
        _textField.hidden = YES;
        _settingBtn.hidden = NO;
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self->_textField.mas_left).offset(-4);
            make.left.equalTo(self->_nameLabel.mas_right);
        }];
    } else {
        _valueLabel.hidden = NO;
        _textField.hidden = NO;
        _settingBtn.hidden = NO;
        [_valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_textField.mas_left).offset(-4);
        }];
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self->_textField.mas_left).offset(-4);
            make.left.equalTo(self->_nameLabel.mas_right);
        }];
    }
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([self->_nameLabel widthOfLabelWithFixedHeight:MAXFLOAT]);
    }];
}

@end

