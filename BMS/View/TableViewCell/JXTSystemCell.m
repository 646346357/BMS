//
//  JXTSystemCell.m
//  BMS
//
//  Created by qinwen on 2019/4/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTSystemCell.h"

@interface JXTSystemCell (){
    
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation JXTSystemCell

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
    UILabel *titleLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrow = JXT_IMAGE_VIEW(@"setting_next");
    [self.contentView addSubview:arrow];
    self.arrowImageView = arrow;
    
    UIView *bottomLine = [UIView lineView];
    [self.contentView addSubview:bottomLine];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
    }];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(10, 16));
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(JXT_LINE_WIDTH);
    }];
}

#pragma mark - Public Method

- (void)configCellWithTitle:(NSString *)title hideArrow:(BOOL)hideArrow {
    self.titleLabel.text = title;
    self.arrowImageView.hidden = hideArrow;
}

@end

