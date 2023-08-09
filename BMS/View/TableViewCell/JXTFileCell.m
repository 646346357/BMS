//
//  JXTFileCell.m
//  BMS
//
//  Created by qinwen on 2019/4/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTFileCell.h"

@interface JXTFileCell (){
    
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sizeLabel;

@end

@implementation JXTFileCell

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
    
    UILabel *sizeLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:sizeLabel];
    self.sizeLabel = sizeLabel;
    
    UIView *bottomLine = [UIView lineView];
    [self.contentView addSubview:bottomLine];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
    }];
    
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(JXT_LINE_WIDTH);
    }];
}

#pragma mark - Public Method

- (void)configCellWithTitle:(NSString *)title size:(long long)size {
    self.titleLabel.text = title;
    NSString *sizeStr = @"";
    if (size < 1024) {
        sizeStr = [NSString stringWithFormat:@"%lldB",size];
    } else if (size < 1024*1024){
        sizeStr = [NSString stringWithFormat:@"%.1fKB",size/1024.0];
    } else {
        sizeStr = [NSString stringWithFormat:@"%.1fMB",size/1024.0/1024.0];
    }
    self.sizeLabel.text = sizeStr;
}

@end

