//
//  JXTColorfulButton.m
//  BMS
//
//  Created by qinwen on 2019/4/5.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTColorfulButton.h"

@interface JXTColorfulButton (){
    
}

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *outerCircle;
@property (nonatomic, strong) UIView *innerCicle;
@property (nonatomic, strong) UILabel *customTitleLabel;

@end

@implementation JXTColorfulButton

#pragma mark - Life Cycle

+ (instancetype)buttonWithNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor title:(NSString *)title {
    JXTColorfulButton *btn = [JXTColorfulButton buttonWithType:UIButtonTypeCustom];
    btn.normalColor = normalColor;
    btn.selectedColor = selectedColor;
    btn.title = [title copy];
    [btn setupSubviews];
    [btn setSelected:YES];
    
    return btn;
}

#pragma mark - Private Method

- (void)setupSubviews{
    UIView *outerCircle = [[UIView alloc] init];
    outerCircle.userInteractionEnabled = NO;
    outerCircle.layer.borderWidth = JXT_LINE_WIDTH;
    outerCircle.layer.cornerRadius = 5;
    [self addSubview:outerCircle];
    _outerCircle = outerCircle;
    
    UIView *innerCicle = [[UIView alloc] init];
    innerCicle.userInteractionEnabled = NO;
    innerCicle.layer.cornerRadius = 3;
    [outerCircle addSubview:innerCicle];
    _innerCicle = innerCicle;
    
    UILabel *titleLabel = [UILabel labelWithText:_title font:[UIFont fontOfSize_14] textColor:_selectedColor textAlignment:NSTextAlignmentLeft];
    [self addSubview:titleLabel];
    _customTitleLabel = titleLabel;
    
    [outerCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(10, 10));
    }];
    
    [innerCicle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(outerCircle);
        make.size.equalTo(CGSizeMake(6, 6));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(outerCircle);
        make.left.equalTo(outerCircle.mas_right).offset(5);
        make.right.equalTo(self);
    }];
}

#pragma mark - Getter & Setter

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _outerCircle.layer.borderColor = _selectedColor.CGColor;
        _innerCicle.backgroundColor = _selectedColor;
        _customTitleLabel.textColor = _selectedColor;
    } else {
        _outerCircle.layer.borderColor = _normalColor.CGColor;
        _innerCicle.backgroundColor = _normalColor;
        _customTitleLabel.textColor = _normalColor;
    }
}

@end
