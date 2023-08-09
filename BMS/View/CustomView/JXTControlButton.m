//
//  JXTControlButton.m
//  BMS
//
//  Created by qinwen on 2019/4/14.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTControlButton.h"

@interface JXTControlButton (){
    
}

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *titleBgImageView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedTitleImage;
@property (nonatomic, strong) UIImage *normalTitleImage;
@property (nonatomic, copy) NSString *selectedTitle;
@property (nonatomic, copy) NSString *normalTitle;


@end

@implementation JXTControlButton

#pragma mark - Life Cycle

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage normalTitleImage:(UIImage *)normalTitleImage selectedTitleImage:(UIImage *)selectedTitleImage normalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle{
    JXTControlButton *btn = [JXTControlButton buttonWithType:UIButtonTypeCustom];
    btn.normalImage = normalImage;
    btn.selectedImage = selectedImage;
    btn.normalTitleImage = normalTitleImage;
    btn.selectedTitleImage = selectedTitleImage;
    btn.normalTitle = [normalTitle copy];
    btn.selectedTitle = [selectedTitle copy];
    [btn setupSubviews];
    [btn setSelected:NO];
    return btn;
}

#pragma mark - Private Method

- (void)setupSubviews{
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:self.normalImage];
    topImageView.userInteractionEnabled = NO;
    [self addSubview:topImageView];
    _topImageView = topImageView;
    
    UIImageView *titleBgImageView = [[UIImageView alloc] initWithImage:self.normalTitleImage];
    titleBgImageView.userInteractionEnabled = NO;
    [self addSubview:titleBgImageView];
    _titleBgImageView = titleBgImageView;
    
    UIImageView *switchImageView = JXT_IMAGE_VIEW(@"icon_switch");
    [titleBgImageView addSubview:switchImageView];
    
    UILabel *statusLabel = [UILabel labelWithText:self.normalTitle font:[UIFont fontOfSize_14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight];
    [titleBgImageView addSubview:statusLabel];
    _statusLabel = statusLabel;
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(62, 62));
    }];
    
    [titleBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(13);
        make.centerX.equalTo(self);
    }];
    
    [switchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(16);
        make.centerY.equalTo(titleBgImageView);
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleBgImageView.mas_right).offset(-16);
        make.centerY.equalTo(titleBgImageView);
        make.left.greaterThanOrEqualTo(switchImageView.mas_right);
    }];
}

#pragma mark - Getter & Setter

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _topImageView.image = _selectedImage;
        _titleBgImageView.image = _selectedTitleImage;
        _statusLabel.text = _selectedTitle;
    } else {
        _topImageView.image = _normalImage;
        _titleBgImageView.image = _normalTitleImage;
        _statusLabel.text = _normalTitle;
    }
}

@end
