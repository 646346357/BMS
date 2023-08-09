//
//  JXTBatteryCell.m
//  BMS
//
//  Created by qinwen on 2019/3/31.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTBatteryCell.h"

@interface JXTBatteryCell () {
    UIImageView *_bg1;
    UILabel *_nameLabel1;
    UILabel *_valueLabel1;
    UIImageView *_bgImage1;
    UIImageView *_bg2;
    UILabel *_nameLabel2;
    UILabel *_valueLabel2;
    UIImageView *_bgImage2;
}

@end

@implementation JXTBatteryCell

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
    UIImageView *bg1 =JXT_IMAGE_VIEW(@"bg_monomervoltage");
    [self.contentView addSubview:bg1];
    _bg1 = bg1;
    
    UIImageView *bgImage1 = JXT_IMAGE_VIEW(@"bg_monomervoltage1");
    [bg1 addSubview:bgImage1];
    _bgImage1 = bgImage1;
    
    UIView *leftBg =[[UIView alloc] init];
    leftBg.backgroundColor = [UIColor clearColor];
    [bgImage1 addSubview:leftBg];
    
    UIView *leftBgBg = [[UIView alloc] init];
    leftBgBg.backgroundColor = [UIColor clearColor];
    [leftBg addSubview:leftBgBg];
    
    UIImageView *batteryImage = JXT_IMAGE_VIEW(@"icon_chip");
    [leftBgBg addSubview:batteryImage];
    
    UILabel *titleLabel1 = [UILabel labelWithText:nil font:[UIFont fontOfSize_18] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [leftBgBg addSubview:titleLabel1];
    _nameLabel1 = titleLabel1;
    
    UILabel *valueLabel1 = [UILabel labelWithText:nil font:[UIFont fontOfSize_18] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [bgImage1 addSubview:valueLabel1];
    _valueLabel1 = valueLabel1;
    
    UIImageView *bg2 =JXT_IMAGE_VIEW(@"bg_monomervoltage");
    [self.contentView addSubview:bg2];
    _bg2 = bg2;
    
    UIImageView *bgImage2 = JXT_IMAGE_VIEW(@"bg_monomervoltage1");
    [bg2 addSubview:bgImage2];
    _bgImage2 = bgImage2;
    
    UIView *leftBg2 =[[UIView alloc] init];
    leftBg2.backgroundColor = [UIColor clearColor];
    [bgImage2 addSubview:leftBg2];
    
    UIView *leftBgBg2 = [[UIView alloc] init];
    leftBgBg2.backgroundColor = [UIColor clearColor];
    [leftBg2 addSubview:leftBgBg2];
    
    UIImageView *batteryImage2 = JXT_IMAGE_VIEW(@"icon_chip");
    [leftBgBg2 addSubview:batteryImage2];
    
    UILabel *titleLabel2 = [UILabel labelWithText:nil font:[UIFont fontOfSize_18] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [leftBgBg2 addSubview:titleLabel2];
    _nameLabel2 = titleLabel2;
    
    UILabel *valueLabel2 = [UILabel labelWithText:nil font:[UIFont fontOfSize_18] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentLeft];
    [bgImage2 addSubview:valueLabel2];
    _valueLabel2 = valueLabel2;
    
    [bg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(11);
        make.top.bottom.equalTo(self);
        make.width.equalTo((JXT_SCREEN_WIDTH-11*2-5)/2);
    }];
    
    [bgImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bg1);
    }];
    
    [leftBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bgImage1);
        make.width.equalTo(bgImage1.mas_width).multipliedBy(146.0/348);
    }];
    
    [leftBgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBg);
        make.centerX.equalTo(leftBg);
    }];
    
    [batteryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(24, 24));
        make.centerY.equalTo(leftBg);
        make.left.equalTo(leftBgBg);
    }];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBg);
        make.left.equalTo(batteryImage.mas_right);
        make.right.equalTo(leftBgBg);
    }];
    
    [valueLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bgImage1);
        make.left.equalTo(leftBg.mas_right).offset(2);
    }];

    [bg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg1.mas_right).offset(5);
        make.top.bottom.width.equalTo(bg1);
    }];
    
    [bgImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bg2);
    }];
    
    [leftBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bgImage2);
        make.width.equalTo(leftBg);
    }];
    
    [leftBgBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBg2);
        make.centerX.equalTo(leftBg2);
    }];
    
    [batteryImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(batteryImage);
        make.centerY.equalTo(leftBgBg2);
        make.left.equalTo(leftBgBg2);
    }];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftBg2);
        make.left.equalTo(batteryImage2.mas_right);
        make.right.equalTo(leftBgBg2);
    }];
    
    [valueLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bgImage2);
        make.left.equalTo(leftBg2.mas_right).offset(2);
    }];

}

#pragma mark - Public Method

- (void)configCellWithLeftInfo:(JXTInfoDetails *)leftInfo rightInfo:(JXTInfoDetails *)rightInfo {
    _bg1.hidden = !leftInfo;
    _bg2.hidden = !rightInfo;
    if (leftInfo) {
        _nameLabel1.text = leftInfo.name;
        _valueLabel1.text = leftInfo.display;
        _bgImage1.image = leftInfo.isBalance ? JXT_IMAGE(@"bg_monomervoltage2") : JXT_IMAGE(@"bg_monomervoltage1");
        if (leftInfo.isHighest) {
            _valueLabel1.textColor = [UIColor defaultHighColor];
        } else if (leftInfo.isLowest) {
            _valueLabel1.textColor = [UIColor defaultLowColor];
        } else {
            _valueLabel1.textColor = [UIColor defaultBlackColor];
        }
    }
    
    if (rightInfo) {
        _nameLabel2.text = rightInfo.name;
        _valueLabel2.text = rightInfo.display;
        _bgImage2.image = rightInfo.isBalance ? JXT_IMAGE(@"bg_monomervoltage2") : JXT_IMAGE(@"bg_monomervoltage1");
        if (rightInfo.isHighest) {
            _valueLabel2.textColor = [UIColor defaultHighColor];
        } else if (rightInfo.isLowest) {
            _valueLabel2.textColor = [UIColor defaultLowColor];
        } else {
            _valueLabel2.textColor = [UIColor defaultBlackColor];
        }
    }
}

@end


