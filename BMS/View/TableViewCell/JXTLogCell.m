//
//  JXTLogCell.m
//  BMS
//
//  Created by qinwen on 2019/4/17.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTLogCell.h"

@interface JXTLogCell (){
    
}

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *statusDisplayLabel;

@end

@implementation JXTLogCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)setupSubViews {
    UIImageView *bg = JXT_IMAGE_VIEW(@"bg_log2");
    [self.contentView addSubview:bg];
    
    UILabel *indexLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:JXT_HEX_COLOR(0x999999) textAlignment:NSTextAlignmentLeft];
    [bg addSubview:indexLabel];
    self.indexLabel = indexLabel;
    
    UILabel *statusLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UILabel *numberLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    UILabel *statusDisplayLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [bg addSubview:statusDisplayLabel];
    self.statusDisplayLabel = statusDisplayLabel;
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(21);
        make.centerY.equalTo(bg);
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(indexLabel);
        make.left.equalTo(indexLabel.mas_right).offset(20);
    }];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(indexLabel);
        make.left.equalTo(statusLabel.mas_right).offset(20);
    }];
    
    [statusDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(indexLabel);
        make.left.equalTo(numberLabel.mas_right).offset(20);
        make.right.lessThanOrEqualTo(bg.mas_right).offset(-21);
    }];
}

#pragma mark - Public Method

- (void)configCellWithLog:(JXTLog *)log {
    self.indexLabel.text = [NSString stringWithFormat:@"序号：%lu", (unsigned long)log.index];
    self.statusLabel.text = (1 == log.status) ? @"《放电》" : @"《充电》";
    self.numberLabel.text = [NSString stringWithFormat:@"(%lu)", (unsigned long)log.number];
    self.statusDisplayLabel.text = log.statusDisplay;
}

@end
