//
//  JXTLineButton.m
//  BMS
//
//  Created by qinwen on 2019/4/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTLineButton.h"

@interface JXTLineButton (){
    
}

@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *line;

@end

@implementation JXTLineButton

#pragma mark - Life Cycle

+ (instancetype)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalFont:(UIFont *)normalFont selectedFont:(UIFont *)selectedFont{
    JXTLineButton *btn = [JXTLineButton buttonWithType:UIButtonTypeCustom];
    btn.normalFont = normalFont;
    btn.selectedFont = selectedFont;
    btn.normalColor = normalColor;
    btn.selectedColor = selectedColor;
    btn.btnTitle = [title copy];
    [btn setupSubviews];
    [btn setSelected:NO];
    return btn;
}

#pragma mark - Private Method

- (void)setupSubviews{
    UILabel *label = [UILabel labelWithText:self.btnTitle font:self.normalFont textColor:self.normalColor textAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    self.label = label;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = self.selectedColor;
    [self addSubview:line];
    line.hidden = YES;
    self.line = line;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(line.mas_top);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(2);
    }];
}

#pragma mark - Getter & Setter

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        if (selected) {
            weakSelf.label.font = weakSelf.selectedFont;
            weakSelf.label.textColor = weakSelf.selectedColor;
            weakSelf.line.hidden = NO;
        } else {
            weakSelf.label.font = weakSelf.normalFont;
            weakSelf.label.textColor = weakSelf.normalColor;
            weakSelf.line.hidden = YES;
        }
    }];
}


@end
