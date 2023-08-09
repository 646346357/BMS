//
//  JXTParamCell.m
//  BMS
//
//  Created by qinwen on 2019/4/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTParamCell.h"

@interface JXTParamCell (){
    
}

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JXTParamCell

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
    UIImageView *titleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:titleImageView];
    self.titleImageView = titleImageView;
    
    UILabel *titleLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrow = JXT_IMAGE_VIEW(@"setting_next");
    [self.contentView addSubview:arrow];
    
    UIView *bottomLine = [UIView lineView];
    [self.contentView addSubview:bottomLine];
    
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(24, 24));
        make.centerY.equalTo(self);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageView.mas_right).offset(15);
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

- (void)configCellWithImage:(UIImage *)image title:(NSString *)title {
    self.titleImageView.image = image;
    self.titleLabel.text = title;
}

@end
