//
//  JXTPeripheralCell.m
//  BMS
//
//  Created by qinwen on 2019/4/10.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTPeripheralCell.h"

@interface JXTPeripheralCell (){
    
}

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *circle;
@property (nonatomic, strong) UIImageView *icon;

@end

@implementation JXTPeripheralCell

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
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor lineColor];
    [self.contentView addSubview:bottomLine];
    
    UIView *dot = [[UIView alloc] init];
    dot.backgroundColor = [UIColor defaultItemColor];
    dot.layer.cornerRadius = 3;
    [self.contentView addSubview:dot];
    
    UILabel *nameLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *statusLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UIImageView *circle = JXT_IMAGE_VIEW(@"bluetoothcircle_small");
    [self.contentView addSubview:circle];
    self.circle = circle;
    
    UIImageView *icon = JXT_IMAGE_VIEW(@"bluetooth_small");
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    [dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(6, 6));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dot.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.right.equalTo(statusLabel.mas_left).offset(-10);
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-35);
        make.centerY.equalTo(self);
        make.width.equalTo(60);
    }];
    
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-39);
        make.size.equalTo(CGSizeMake(34, 34));
        make.centerY.equalTo(self);
    }];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(circle);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(24);
        make.centerX.equalTo(self);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.bottom.equalTo(self);
    }];
}

- (void)addAniamation{
    [self removeAnimation];
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(-M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = .3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [self.circle.layer addAnimation:animation forKey:@"key"];
}

- (void)removeAnimation{
    [self.circle.layer removeAnimationForKey:@"key"];
}

#pragma mark - Public Method

- (void)configCellWithPeripheral:(CBPeripheral *)peripheral {
    _nameLabel.text = peripheral.name;
    switch (peripheral.state) {
        case CBPeripheralStateConnected:
            self.circle.hidden = YES;
            self.icon.hidden = YES;
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已连接";
            self.statusLabel.textColor = [UIColor defaultItemColor];
            [self removeAnimation];
            break;

        case CBPeripheralStateConnecting:
            self.circle.hidden = NO;
            self.icon.hidden = NO;
            self.statusLabel.hidden = YES;
            [self addAniamation];
            break;
        default:
            self.circle.hidden = YES;
            self.icon.hidden = YES;
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"未连接";
            self.statusLabel.textColor = [UIColor defaultGrayColor];
            [self removeAnimation];
            break;
    }
}

@end
