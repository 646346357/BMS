//
//  JXTRealtimeHeaderView.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTRealtimeHeaderView.h"

static NSString * const kTitleKey = @"kTitleKey";
static NSString * const kImageKey = @"kImageKey";
static NSString * const kViewKey = @"kViewKey";

@implementation JXTRealtimeHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        //        [self setupSubviews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)setupSubviews{
    CGFloat socWidth = JXT_SCREEN_WIDTH * 280.0/750.0;
    CGFloat socHeight = 80;
    
    UILabel *nameDescLabel = [UILabel labelWithText:@"当前连接状态:" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:nameDescLabel];
    
    UILabel *nameLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *timeDescLabel = [UILabel labelWithText:@"运行时间:" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:timeDescLabel];
    
    UILabel *timeLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UIView *line1 = [UIView lineView];
    [self addSubview:line1];
    
    UIView *socBgView = [[UIView alloc] init];
    [self addSubview:socBgView];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.bounds = CGRectMake(0, 0, socWidth, socHeight);  //设置大小
    circle.position = CGPointMake(socWidth/2.0, socHeight);            //设置中心位置
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(socWidth/2.0, socHeight/2.0) radius:socWidth/2.0 startAngle:M_PI endAngle:2*M_PI clockwise:YES].CGPath; //设置绘制路径
    circle.strokeColor = [UIColor lineColor].CGColor;      //设置划线颜色
    circle.fillColor = [UIColor clearColor].CGColor;   //设置填充颜色
    circle.lineWidth = 10;          //设置线宽
    circle.lineCap = kCALineCapRound;//设置线头形状
    circle.lineJoin = kCALineJoinRound;
    circle.strokeStart =0;
    circle.strokeEnd = 1;        //设置轮廓结束位置
    [socBgView.layer addSublayer:circle];
    
    CAShapeLayer *circle2 = [CAShapeLayer layer];
    circle2.bounds = CGRectMake(0, 0, socWidth, socHeight);  //设置大小
    circle2.position = CGPointMake(socWidth/2.0, socHeight);            //设置中心位置
    circle2.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(socWidth/2.0, socHeight/2.0) radius:socWidth/2.0 startAngle:M_PI endAngle:2*M_PI clockwise:YES].CGPath; //设置绘制路径
    circle2.strokeColor = [UIColor defaultItemColor].CGColor;      //设置划线颜色
    circle2.fillColor = [UIColor clearColor].CGColor;   //设置填充颜色
    circle2.lineWidth = 10;          //设置线宽
    circle2.lineCap = kCALineCapRound;//设置线头形状
    circle2.lineJoin = kCALineJoinRound;
    circle2.strokeStart =0;
    circle2.strokeEnd = 0;        //设置轮廓结束位置
    [socBgView.layer addSublayer:circle2];
    _socLayer = circle2;
    
    UILabel *socDescLabel = [UILabel labelWithText:@"soc" font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentCenter];
    [socBgView addSubview:socDescLabel];
    
    UILabel *socLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    [socBgView addSubview:socLabel];
    _socLabel = socLabel;
    
    UIView *capacityBgView = [[UIView alloc] init];
    [self addSubview:capacityBgView];
    
    UILabel *capacityDescLabel = [UILabel labelWithText:@"总容量" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [socBgView addSubview:capacityDescLabel];
    
    UILabel *totalCapacityLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [socBgView addSubview:totalCapacityLabel];
    _totalCapacityLabel = totalCapacityLabel;
    
    UIView *line2 = [UIView lineView];
    [self addSubview:line2];
    
    NSArray *arr1 = @[
                      @{kTitleKey: @"充电MOS:",
                        kImageKey: NSStringFromSelector(@selector(chargeMosImgView)),
                        kViewKey: NSStringFromSelector(@selector(chargeMosLabel)),
                        },
                      @{kTitleKey: @"放电MOS:",
                        kImageKey: NSStringFromSelector(@selector(dischargeMosImgView)),
                        kViewKey: NSStringFromSelector(@selector(dischargeMosLabel)),
                        },
                      @{kTitleKey: @"均衡MOS:",
                        kImageKey: NSStringFromSelector(@selector(balanceImgView)),
                        kViewKey: NSStringFromSelector(@selector(balanceLabel)),
                        },];
    UIView *statusView1 = [self statusView1WithArray:arr1];
    [self addSubview:statusView1];
    
    UIView *line3 = [UIView lineView];
    [self addSubview:line3];
    
    NSArray *arr2 = @[
                      @{kTitleKey: @"总电压",
                        kImageKey: @"icon_totalvoltage",
                        kViewKey: NSStringFromSelector(@selector(overallVoltageLabel)),
                        },
                      @{kTitleKey: @"电流",
                        kImageKey: @"icon_electriccurrent",
                        kViewKey: NSStringFromSelector(@selector(currentLabel)),
                        },
                      @{kTitleKey: @"功率",
                        kImageKey: @"icon_power",
                        kViewKey: NSStringFromSelector(@selector(powerLabel)),
                        },
                      @{kTitleKey: @"最高电压",
                        kImageKey: @"icon_maximumvoltage",
                        kViewKey: NSStringFromSelector(@selector(highVoltageLabel)),
                        },
                      @{kTitleKey: @"最低电压",
                        kImageKey: @"icon_minimumvoltage",
                        kViewKey: NSStringFromSelector(@selector(lowVoltageLabel)),
                        },
                      @{kTitleKey: @"平均电压",
                        kImageKey: @"icon_averagevoltage",
                        kViewKey: NSStringFromSelector(@selector(averageVoltageLabel)),
                        },
                      @{kTitleKey: @"压差",
                        kImageKey: @"icon_differentialpressure",
                        kViewKey: NSStringFromSelector(@selector(voltageDiffLabel)),
                        },
                      @{kTitleKey: @"总循环",
                        kImageKey: @"icon_totalcirculation",
                        kViewKey: NSStringFromSelector(@selector(cycleCapacityLabel)),
                        },];
    UIView *statusView2 = [self statusView2WithArray:arr2];
    [self addSubview:statusView2];
    
    UIImageView *temperatureBg = JXT_IMAGE_VIEW(@"bg_temperature");
    [self addSubview:temperatureBg];
    
    UIImageView *temperatureImageView = JXT_IMAGE_VIEW(@"icon_temperature");
    [temperatureBg addSubview:temperatureImageView];
    
    UILabel *mosTDescLabel = [UILabel labelWithText:@"MOS" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:mosTDescLabel];
    
    UILabel *mosTlabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:mosTlabel];
    _mosTempratureLabel = mosTlabel;
    
    UILabel *balanceTDescLabel = [UILabel labelWithText:@"均衡" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:balanceTDescLabel];
    
    UILabel *balanceTlabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:balanceTlabel];
    _balanceTempratureLabel = balanceTlabel;
    
    UIView *line4 = [UIView lineView];
    [temperatureBg addSubview:line4];
    
    UILabel *tDescLabel1 = [UILabel labelWithText:@"T1" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:tDescLabel1];
    
    UILabel *tlabel1 = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:tlabel1];
    _temprature1Label = tlabel1;
    
    UILabel *tDescLabel2 = [UILabel labelWithText:@"T2" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:tDescLabel2];
    
    UILabel *tlabel2 = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:tlabel2];
    _temprature2Label= tlabel2;
    
    UILabel *tDescLabel3 = [UILabel labelWithText:@"T3" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:tDescLabel3];
    
    UILabel *tlabel3 = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:tlabel3];
    _temprature3Label = tlabel3;
    
    UILabel *tDescLabel4 = [UILabel labelWithText:@"T4" font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
    [temperatureBg addSubview:tDescLabel4];
    
    UILabel *tlabel4 = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
    [temperatureBg addSubview:tlabel4];
    _temprature4Label = tlabel4;
    
    UIImageView *bottomView = JXT_IMAGE_VIEW(@"line");
    [self addSubview:bottomView];
    
    UILabel *singleVoltageLabel = [UILabel labelWithText:@"单体电压" font:[UIFont fontOfSize_15] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentCenter];
    [self addSubview:singleVoltageLabel];
    
    [nameDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(20);
        make.width.equalTo([nameDescLabel widthOfLabelWithFixedHeight:CGFLOAT_MAX]);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(nameDescLabel);
        make.left.equalTo(nameDescLabel.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [timeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameDescLabel);
        make.top.equalTo(nameDescLabel.mas_bottom).offset(12);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(nameLabel);
        make.top.bottom.equalTo(timeDescLabel);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameDescLabel);
        make.right.equalTo(nameLabel);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.top.equalTo(timeDescLabel.mas_bottom).offset(20);
    }];
    
    [statusView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(line2.mas_left);
        make.centerY.equalTo(line2);
        make.height.equalTo(14*(arr1.count)+22*(arr1.count-1));
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(socBgView);
        make.bottom.equalTo(capacityBgView);
        make.width.equalTo(JXT_LINE_WIDTH);
        make.right.equalTo(socBgView.mas_left).offset(-16);
    }];
    
    [socBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(20);
        make.right.equalTo(line1);
        make.width.equalTo(socWidth);
        make.height.equalTo(socHeight);
    }];
    
    [socDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(socBgView);
        make.bottom.equalTo(socLabel.mas_top).offset(-4);
    }];
    
    [socLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(socBgView);
        make.bottom.equalTo(socBgView.mas_bottom).offset(-4);
    }];
    
    [capacityBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(socBgView);
        make.top.equalTo(socBgView.mas_bottom).offset(16);
    }];
    
    [capacityDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(capacityBgView);
    }];
    
    [totalCapacityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(capacityDescLabel.mas_right).offset(4);
        make.right.bottom.equalTo(capacityBgView);
    }];
    
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(20);
        make.left.right.height.equalTo(line1);
    }];
    
    NSInteger row = arr2.count/3+(arr2.count%3 == 0 ? 0 : 1);
    [statusView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line3);
        make.top.equalTo(line3.mas_bottom).offset(24);
        make.height.equalTo(42*row+30*(row-1));
    }];
    
    [temperatureBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(statusView2.mas_bottom).offset(10);
        make.height.equalTo(158);
    }];
    
    [temperatureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(temperatureBg);
        make.left.equalTo(34);
        make.size.equalTo(CGSizeMake(70, 90));
    }];
    
    [mosTDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(temperatureImageView);
        make.left.equalTo(temperatureImageView.mas_right).offset(20);
        make.width.equalTo(32);
    }];
    
    [mosTlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mosTDescLabel.mas_right).offset(6);
        make.top.bottom.equalTo(mosTDescLabel);
    }];
    
    [balanceTDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(mosTDescLabel);
        make.left.equalTo(line4.mas_centerX);
        make.width.equalTo(mosTDescLabel);
    }];
    
    [balanceTlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(balanceTDescLabel);
        make.left.equalTo(balanceTDescLabel.mas_right).offset(6);
        make.right.equalTo(line4);
    }];
    
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mosTDescLabel);
        make.right.equalTo(self.mas_right).offset(-34);
        make.height.equalTo(JXT_LINE_WIDTH);
        make.bottom.equalTo(tDescLabel1.mas_top).offset(-14);
    }];
    
    [tDescLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mosTDescLabel);
        make.bottom.equalTo(tDescLabel3.mas_top).offset(-14);
    }];
    
    [tlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mosTlabel);
        make.top.bottom.equalTo(tDescLabel1);
    }];
    
    [tDescLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(balanceTDescLabel);
        make.top.bottom.equalTo(tDescLabel1);
    }];
    
    [tlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(balanceTlabel);
        make.top.bottom.equalTo(tDescLabel2);
    }];
    
    [tDescLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mosTDescLabel);
        make.bottom.equalTo(temperatureImageView);
    }];
    
    [tlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mosTlabel);
        make.top.bottom.equalTo(tDescLabel3);
    }];
    
    [tDescLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(balanceTDescLabel);
        make.top.bottom.equalTo(tDescLabel3);
    }];
    
    [tlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(balanceTlabel);
        make.top.bottom.equalTo(tDescLabel4);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(temperatureBg.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    
    [singleVoltageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
    }];
}

- (UIView *)statusView1WithArray:(NSArray *)array{
    UIView *view = [[UIView alloc] init];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        NSString *title = dic[kTitleKey];
        NSString *targetViewKey = dic[kViewKey];
        NSString *targetImageViewKey = dic[kImageKey];
        UILabel *descLabel = [UILabel labelWithText:title font:[UIFont fontOfSize_14] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentRight];
        [view addSubview:descLabel];
        
        UIView *circle = [[UIView alloc] init];
        circle.backgroundColor = [UIColor safeColor];
        circle.layer.cornerRadius = 7;
        [view addSubview:circle];
        [self setValue:circle forKey:targetImageViewKey];
        
        UILabel *label = [UILabel labelWithText:nil font:[UIFont fontOfSize_14] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
        [view addSubview:label];
        [self setValue:label forKey:targetViewKey];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(i*(14+22));
            make.left.equalTo(16);
            make.width.equalTo(68);
        }];
        
        [circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(descLabel.mas_right).offset(4);
            make.centerY.equalTo(descLabel);
            make.size.equalTo(CGSizeMake(14, 14));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(circle.mas_right).offset(4);
            make.centerY.equalTo(descLabel);
            make.right.equalTo(view.mas_right);
        }];
    }
    
    return  view;
}

- (UIView *)statusView2WithArray:(NSArray *)array{
    UIView *view = [[UIView alloc] init];
    NSUInteger column = 3;
    CGFloat width = 1.0*(JXT_SCREEN_WIDTH-15*4)/column;
    CGFloat height = 42;
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        NSString *title = dic[kTitleKey];
        NSString *targetViewKey = dic[kViewKey];
        NSString *targetImageName = dic[kImageKey];
        
        UIView *bg = [[UIView alloc] init];
        [view addSubview:bg];
        
        UIImageView *imageView = JXT_IMAGE_VIEW(targetImageName);
        [bg addSubview:imageView];
        
        UILabel *label = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentLeft];
        [bg addSubview:label];
        [self setValue:label forKey:targetViewKey];
        
        UILabel *descLabel = [UILabel labelWithText:title font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
        [bg addSubview:descLabel];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bg);
            make.centerY.equalTo(bg);
            make.size.equalTo(CGSizeMake(24, 24));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.right.equalTo(bg);
        }];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label);
            make.bottom.equalTo(bg);
        }];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(width, height));
            make.top.equalTo((height+30)*(i/column));
            make.left.equalTo((width+15)*(i%column));
        }];
    }
    
    return  view;
}

#pragma mark - Public Method

- (void)updateStates {
    JXTBatteryInfoManager *manager = [JXTBatteryInfoManager sharedInstance];
    if ([JXTBluetooth sharedInstance].peripheralConnnected) {
        _nameLabel.text = [JXTBluetooth sharedInstance].currentPeripheral.name;
    } else {
        _nameLabel.text = @"未连接";
    }
    _timeLabel.text = manager.timeinterval.display;
    
    _socLayer.strokeEnd = [manager.batteryRate.value integerValue]/100.0;
    _socLabel.text = manager.batteryRate.display;
    _totalCapacityLabel.text = manager.overallCapacity.display;
    _chargeMosLabel.text = manager.chargeMosState.display;
    if ([manager.chargeMosState.value isEqualToString:@"关闭"]) {
        _chargeMosLabel.textColor = [UIColor lineColor];
    } else {
        _chargeMosLabel.textColor = [UIColor safeColor];
    }
    _chargeMosImgView.backgroundColor = _chargeMosLabel.textColor;
    
    _dischargeMosLabel.text = manager.dischargeMosState.display;
    if ([manager.dischargeMosState.value isEqualToString:@"关闭"]) {
        _dischargeMosLabel.textColor = [UIColor lineColor];
    } else {
        _dischargeMosLabel.textColor = [UIColor safeColor];
    }
    _dischargeMosImgView.backgroundColor = _dischargeMosLabel.textColor;
    
    _balanceLabel.text = manager.balanceState.display;
    if ([manager.balanceState.value isEqualToString:@"关闭"]) {
        _balanceLabel.textColor = [UIColor lineColor];
    } else {
        _balanceLabel.textColor = [UIColor safeColor];
    }
    _balanceImgView.backgroundColor = _balanceLabel.textColor;
    
    _overallVoltageLabel.text = manager.overallVoltage.display;
    _currentLabel.text = manager.current.display;
    _powerLabel.text = manager.power.display;
    _highVoltageLabel.text = manager.highestVoltage.display;
    _lowVoltageLabel.text = manager.lowestVoltage.display;
    _averageVoltageLabel.text = manager.averageVoltage.display;
    CGFloat diff = [manager.highestVoltage.value doubleValue]-[manager.lowestVoltage.value doubleValue];
    _voltageDiffLabel.text = [NSString stringWithFormat:@"%.3fV",diff];
    _cycleCapacityLabel.text = manager.cycleCapacity.display;
    
    for (NSInteger i = 0; i < manager.temperatureArray.count; i++) {
        JXTInfoDetails *t = manager.temperatureArray[i];
        switch (i) {
            case 0:
                _balanceTempratureLabel.text = t.display;
                break;
                
            case 1:
                _mosTempratureLabel.text = t.display;
                break;
            case 2:
                _temprature1Label.text = t.display;
                break;
            case 3:
                _temprature2Label.text = t.display;
                break;
            case 4:
                _temprature3Label.text = t.display;
                break;
            case 5:
                _temprature4Label.text = t.display;
                break;
        }
    }
}

@end
