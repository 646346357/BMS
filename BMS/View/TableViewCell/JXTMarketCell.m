//
//  JXTMarketCell.m
//  BMS
//
//  Created by qinwen on 2019/4/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTMarketCell.h"

@interface JXTMarketCell (){
    
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;

@end

@implementation JXTMarketCell

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
    UIImageView *bg = JXT_IMAGE_VIEW(@"bg_log1");
    bg.userInteractionEnabled = YES;
    [self.contentView addSubview:bg];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = 6;
    imageView.layer.masksToBounds = YES;
    [bg addSubview:imageView];
    self.titleImageView = imageView;
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [bg addSubview:label];
    self.titleLabel = label;
    
    UILabel *detailLabel = [UILabel labelWithText:@"查看详情" font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    detailLabel.layer.borderColor = [UIColor defaultItemColor].CGColor;
    detailLabel.layer.cornerRadius = 12;
    detailLabel.layer.borderWidth = 1;
    [bg addSubview:detailLabel];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(6);
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.centerY.equalTo(bg);
        make.size.equalTo(CGSizeMake(120, 120));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(28);
        make.left.equalTo(imageView.mas_right).offset(12);
        make.right.equalTo(bg.mas_right).offset(-17);
        make.bottom.equalTo(detailLabel.mas_top).offset(-10);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label);
        make.bottom.equalTo(bg.mas_bottom).offset(-28);
        make.size.equalTo(CGSizeMake(80, 24));
    }];
}

#pragma mark - Public Method

- (void)configCellWithImage:(UIImage *)image content:(NSString *)content {
    self.titleImageView.image = image;
    self.titleLabel.attributedText = [NSAttributedString stringWithString:content font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentJustified lineSpacing:6 kern:0 headIndent:0];
}

@end
