//
//  JXTDynamicCurveController.m
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTDynamicCurveController.h"
#import "JXTYValueFormater.h"
#import "JXTXValueFormater.h"
#import "JXTDataValueFormater.h"
#import "JXTColorfulButton.h"

@interface JXTDynamicCurveController ()<ChartViewDelegate>

//记录断开连接前的设备，如果当前连成功的设备就是上一次断开的设备，则保留之前的曲线数据，否则清空当前的曲线数据
@property (nonatomic, strong) CBPeripheral *lastPeripheral;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) LineChartView * lineView;//折线图
@property (nonatomic, strong) LineChartDataSet *set1;//折线
@property (nonatomic, strong) LineChartDataSet *set2;
@property (nonatomic, strong) LineChartDataSet *set3;
@property (nonatomic, strong) LineChartDataSet *set4;
@property (nonatomic, strong) UIColor *color1;
@property (nonatomic, strong) UIColor *color2;
@property (nonatomic, strong) UIColor *color3;
@property (nonatomic, strong) UIColor *color4;
@property (nonatomic, assign) BOOL cleanData;

@property (nonatomic, strong) UILabel *voltageUnitLabel;
@property (nonatomic, strong) CAShapeLayer *socLayer;
@property (nonatomic, strong) UILabel *socLabel;
@property (nonatomic, strong) UIImageView *totalVoltagePoint;
@property (nonatomic, strong) UIImageView *averageVoltagePoint;
@property (nonatomic, strong) UIImageView *currentPoint;
@property (nonatomic, strong) UILabel *overallVoltageLabel;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UILabel *averageVoltageLabel;
@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation JXTDynamicCurveController

#pragma mark - LifeCycle Method

- (instancetype)init{
    if (self = [super init]) {
        //为了检测曲线数据 提前触发viewDidLoad
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSubviews];
    [self setupLineViewDataSet];
    [self addNotification];
    
    //测试数据
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self updateStatus];
//    }];
}

- (void)dealloc {
    [self removeNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning{
    [self setupLineViewDataSet];
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryInfoDidChanged:) name:JXT_BATTERY_INFO_NOTIFY object:nil];
    [center addObserver:self selector:@selector(peripheralDidConnected:) name:JXT_PERIPHERAL_CONNECTED_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)updateStatus{
    JXTBatteryInfoManager *manager = [JXTBatteryInfoManager sharedInstance];
    if (![JXTBluetooth sharedInstance].peripheralConnnected) {
        return;
    }

    //测试数据
//    manager.current.value = [NSString stringWithFormat:@"%d",(400 - arc4random()%800)];
//    manager.overallVoltage.value = [NSString stringWithFormat:@"%d",(30 + arc4random()%100)];
//    manager.highestVoltage.value = [NSString stringWithFormat:@"%.3f",(2 + arc4random()%2 + arc4random()%10/10.0)];
//    manager.lowestVoltage.value = [NSString stringWithFormat:@"%.3f",(2 + arc4random()%2 + arc4random()%10/10.0)];
    
    
    CGFloat current = [manager.current.value doubleValue];
    CGFloat overallVoltage = [manager.overallVoltage.value doubleValue];
    CGFloat highVoltage = [manager.highestVoltage.value doubleValue] * 1000;
    CGFloat lowVoltage = [manager.lowestVoltage.value doubleValue] * 1000;
    if (0 == current && 0 == overallVoltage && 0 == highVoltage && 0 == lowVoltage) {
        return;
    }

    _socLayer.strokeEnd = [manager.batteryRate.value integerValue]/100.0;
    _socLabel.text = manager.batteryRate.display;
    
    CGFloat totalVoltage = [manager.overallVoltage.value floatValue];
    CGFloat angle = 0;
    if (totalVoltage <= 20) {
        angle = 0;
    } else if (totalVoltage >= 150) {
        angle = (180-3.68*2)/180*M_PI;
    } else {
        angle = ((totalVoltage-20) / (150-20)) * ((180-3.68*2)/180*M_PI);
    }
    _totalVoltagePoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI+3.68/180*M_PI + angle);
    
    CGFloat averageVoltage = [manager.averageVoltage.value floatValue];
    if (averageVoltage <= 2) {
        angle = 0;
    } else if (averageVoltage >= 5) {
        angle = (180-3.68*2)/180*M_PI;
    } else {
        angle = ((averageVoltage-2) / (5-2)) * ((180-3.68*2)/180*M_PI);
    }
    _averageVoltagePoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI-3.68/180*M_PI - angle);
    
    if (current <= -400) {
        angle = 0;
    } else if (current >= 400) {
        angle = (360-21.0*2)/360*2*M_PI;
    } else {
        angle = ((current-(-400)) / (400-(-400))) * ((360-21.0*2)/360*2*M_PI);
    }
    _currentPoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2+21.0/180*M_PI + angle);
    
    _overallVoltageLabel.text = manager.overallVoltage.display;
    [_overallVoltageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([self.overallVoltageLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
    
    _currentLabel.text = manager.current.display;
    [_currentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([self.currentLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
    
    _averageVoltageLabel.text = manager.averageVoltage.display;
    [_averageVoltageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([self.averageVoltageLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
    
    BOOL set1 = false;
    BOOL set2 = false;
    BOOL set3 = false;
    BOOL set4 = false;
    static NSInteger maxCurrent = -400;
    static NSInteger minCurrent = 400;
    static NSInteger maxVoltage = 0;
    static NSInteger minVoltage = 5000;
    static NSInteger maxOverallVoltage = 0;
    static NSInteger minOverallVoltage = 200;
    if (self.cleanData) {
        self.cleanData = NO;
        maxCurrent = -400;
        minCurrent = 400;
        maxVoltage = 0;
        minVoltage = 5000;
        maxOverallVoltage = 0;
        minOverallVoltage = 200;
    }
    if (current >= maxCurrent) {
        maxCurrent = current + 1;
    }
    if (current <= minCurrent) {
        minCurrent = current - 1;
    }
    if (highVoltage >= maxVoltage) {
        maxVoltage = highVoltage + 10;
    }
    if (lowVoltage >= maxVoltage) {
        maxVoltage = lowVoltage + 10;
    }
    if (highVoltage <= minVoltage) {
        minVoltage = highVoltage - 10;
    }
    if (lowVoltage <= minVoltage) {
        minVoltage = lowVoltage - 10;
    }
    if (overallVoltage >= maxOverallVoltage) {
        maxOverallVoltage = overallVoltage + 1;
    }
    if (overallVoltage <= minOverallVoltage) {
        minOverallVoltage = overallVoltage - 1;
    }
    
    if (maxCurrent == minCurrent) {
        maxCurrent += 1;
    }
    if (maxVoltage == minVoltage) {
        maxVoltage += 10;
    }
    if (maxOverallVoltage == minOverallVoltage) {
        maxOverallVoltage += 1;
    }
    
    UIButton *btn1 = [self.view viewWithTag:100];
    UIButton *btn2 = [self.view viewWithTag:100+1];
    UIButton *btn3 = [self.view viewWithTag:100+2];
    self.lineView.rightAxis.axisMinimum = minCurrent;
    self.lineView.rightAxis.axisMaximum = maxCurrent;
    if (btn1.selected && !btn2.selected && !btn3.selected) {
        self.lineView.leftAxis.axisMaximum = maxOverallVoltage;
        self.lineView.leftAxis.axisMinimum = minOverallVoltage;
        self.voltageUnitLabel.text = @"电压/V";
    } else {
        self.lineView.leftAxis.axisMaximum = maxVoltage;
        self.lineView.leftAxis.axisMinimum = minVoltage;
        self.voltageUnitLabel.text = @"电压/mV";
    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate];
    if (self.set1.entryCount < 3) {
        set1 = [self.set1 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.overallVoltage.value doubleValue]]];
    } else {
        if ([self.set1.entries lastObject].y == [manager.overallVoltage.value doubleValue] && self.set1.entries[self.set1.entries.count-2].y == [manager.overallVoltage.value doubleValue]) {
            set1 = [self.set1 removeLast];
        }
        set1 = [self.set1 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.overallVoltage.value doubleValue]]];
    }
    
    if (self.set2.entryCount < 3) {
        set2 = [self.set2 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.highestVoltage.value doubleValue]*1000]];
    } else {
        if ([self.set2.entries lastObject].y == [manager.highestVoltage.value doubleValue]*1000 && self.set2.entries[self.set2.entries.count-2].y == [manager.highestVoltage.value doubleValue]*1000) {
            set2 = [self.set2 removeLast];
        }
        set2 = [self.set2 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.highestVoltage.value doubleValue]*1000]];
    }
    
    if (self.set3.entryCount < 3) {
        set3 = [self.set3 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.lowestVoltage.value doubleValue]*1000]];
    } else {
        if ([self.set3.entries lastObject].y == [manager.lowestVoltage.value doubleValue]*1000 && self.set3.entries[self.set3.entries.count-2].y == [manager.lowestVoltage.value doubleValue]*1000) {
            set3 = [self.set3 removeLast];
        }
        set3 = [self.set3 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.lowestVoltage.value doubleValue]*1000]];
    }
    
    if (self.set4.entryCount < 3) {
        set4 = [self.set4 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.current.value doubleValue]]];
    } else {
        if ([self.set4.entries lastObject].y == [manager.current.value doubleValue] && self.set4.entries[self.set4.entries.count-2].y == [manager.current.value doubleValue]) {
            set4 = [self.set4 removeLast];
        }
        set4 = [self.set4 addEntry:[[ChartDataEntry alloc] initWithX:interval y:[manager.current.value doubleValue]]];
    }
    
    if (interval >= self.lineView.xAxis.axisMaximum) {
        self.lineView.xAxis.axisMaximum =self.lineView.xAxis.axisMinimum + (interval-self.lineView.xAxis.axisMinimum) / 0.8;//当前值为最大坐标的80%
    }
    if (!self.scrollView.isDragging && !self.scrollView.isDecelerating) {
        [self.lineView setNeedsDisplay];
    }
}

- (void)setupNavigationBar {
    UIButton *deviceBtn = [UIButton buttonWithTitle:@"曲线清零" font:[UIFont fontOfSize_15] titleColor:[UIColor whiteColor] target:self selector:@selector(cleanBtnDidClicked:)];
    deviceBtn.frame = CGRectMake(0, 0, 80, 32);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deviceBtn];
}

- (void)setupSubviews{
    CGFloat socWidth = 160;
    CGFloat socHeight = 56;
    CGFloat socRadius = 56+46;
    CGFloat star = M_PI + asin(46.0/80);
    CGFloat end = 2*M_PI-asin(46.0/80);
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    
    UILabel *curveLabel = [UILabel labelWithText:@"动态曲线图" font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [contentView addSubview:curveLabel];
    
    UIImageView *curveTopImage = JXT_IMAGE_VIEW(@"line2");
    [contentView addSubview:curveTopImage];
    
    UILabel *voltageUnitLabel = [UILabel labelWithText:@"电压/mV" font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentCenter];
    self.voltageUnitLabel = voltageUnitLabel;
    [contentView addSubview:voltageUnitLabel];
    
    //    UIImageView *voltageYArrow = JXT_IMAGE_VIEW(@"shape1");
    //    [contentView addSubview:voltageYArrow];
    
    UILabel *currentUnitLabel = [UILabel labelWithText:@"电流/A" font:[UIFont fontOfSize_14] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentCenter];
    [contentView addSubview:currentUnitLabel];
    
    //    UIImageView *currentYArrow = JXT_IMAGE_VIEW(@"shape1");
    //    [contentView addSubview:currentYArrow];
    
    [contentView addSubview:self.lineView];
    
    UIView *btnBgView = [[UIView alloc] init];
    [contentView addSubview:btnBgView];
    
    NSArray *items = @[@{@"title": @"总压", @"normalColor": [UIColor lineColor], @"selectedColor": self.color1},
                       @{@"title": @"最高压", @"normalColor": [UIColor lineColor], @"selectedColor": self.color2},
                       @{@"title": @"最低压", @"normalColor": [UIColor lineColor], @"selectedColor": self.color3},
                       @{@"title": @"电流", @"normalColor": [UIColor lineColor], @"selectedColor": self.color4}];
    for (NSInteger i = 0; i < items.count; i++) {
        NSDictionary *dic = items[i];
        JXTColorfulButton *btn = [JXTColorfulButton buttonWithNormalColor:dic[@"normalColor"] selectedColor:dic[@"selectedColor"] title:dic[@"title"]];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnBgView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-6);
            make.height.equalTo(62);
            if (0 == i) {
                make.left.equalTo(40);
            } else {
                make.left.equalTo([btnBgView viewWithTag:100 + i-1].mas_right).offset(15);
            }
        }];
    }
    
    UILabel *meterLabel = [UILabel labelWithText:@"动态仪表图" font:[UIFont fontOfSize_16] textColor:[UIColor defaultGrayColor] textAlignment:NSTextAlignmentLeft];
    [contentView addSubview:meterLabel];
    
    UIImageView *meterTopImage = JXT_IMAGE_VIEW(@"line2");
    [contentView addSubview:meterTopImage];
    
    UIView *socBgView = [[UIView alloc] init];
    [contentView addSubview:socBgView];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.bounds = CGRectMake(0, 0, socWidth, socHeight);  //设置大小
    circle.position = CGPointMake(socWidth/2.0, socRadius);            //设置中心位置
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(socWidth/2.0, socHeight/2.0) radius:socRadius startAngle:star endAngle:end clockwise:YES].CGPath; //设置绘制路径
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
    circle2.position = CGPointMake(socWidth/2.0, socRadius);            //设置中心位置
    circle2.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(socWidth/2.0, socHeight/2.0) radius:socRadius startAngle:star endAngle:end clockwise:YES].CGPath; //设置绘制路径
    circle2.strokeColor = [UIColor defaultItemColor].CGColor;      //设置划线颜色
    circle2.fillColor = [UIColor clearColor].CGColor;   //设置填充颜色
    circle2.lineWidth = 10;          //设置线宽
    circle2.lineCap = kCALineCapRound;//设置线头形状
    circle2.lineJoin = kCALineJoinRound;
    circle2.strokeStart =0;
    circle2.strokeEnd = 0;        //设置轮廓结束位置
    [socBgView.layer addSublayer:circle2];
    _socLayer = circle2;
    
    UILabel *socDescLabel = [UILabel labelWithText:@"SOC" font:[UIFont fontOfSize_16] textColor:[UIColor defaultBlackColor] textAlignment:NSTextAlignmentCenter];
    [socBgView addSubview:socDescLabel];
    
    UILabel *socLabel = [UILabel labelWithText:@"0%" font:[UIFont fontOfSize_20] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    [socBgView addSubview:socLabel];
    _socLabel = socLabel;
    
    UIImageView *leftTextView = JXT_IMAGE_VIEW(@"text_left");
    [contentView addSubview:leftTextView];
    
    UIImageView *voltageView = JXT_IMAGE_VIEW(@"pic_v");
    [contentView addSubview:voltageView];
    
    UIImageView *totalVoltagePoint = JXT_IMAGE_VIEW(@"v_pointer");
    totalVoltagePoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI+3.68/180*M_PI);
    [voltageView addSubview:totalVoltagePoint];
    _totalVoltagePoint = totalVoltagePoint;
    
    [totalVoltagePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(voltageView);
    }];
    
    UILabel *overallVoltageLabel = [UILabel labelWithText:@"0.0V" font:[UIFont fontOfSize_20] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    overallVoltageLabel.backgroundColor = [UIColor whiteColor];
    overallVoltageLabel.layer.cornerRadius = 3;
    overallVoltageLabel.layer.borderWidth = JXT_LINE_WIDTH;
    overallVoltageLabel.layer.borderColor = JXT_HEX_COLOR(0x555555).CGColor;
    [voltageView addSubview:overallVoltageLabel];
    _overallVoltageLabel = overallVoltageLabel;
    
    UIImageView *averageVoltagePoint = JXT_IMAGE_VIEW(@"v_pointer");
    averageVoltagePoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI-3.68/180*M_PI);
    [voltageView addSubview:averageVoltagePoint];
    _averageVoltagePoint = averageVoltagePoint;
    [averageVoltagePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(voltageView);
    }];
    
    UILabel *averageVoltageLabel = [UILabel labelWithText:@"0.0V" font:[UIFont fontOfSize_20] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    averageVoltageLabel.backgroundColor = [UIColor whiteColor];
    averageVoltageLabel.layer.cornerRadius = 3;
    averageVoltageLabel.layer.borderWidth = JXT_LINE_WIDTH;
    averageVoltageLabel.layer.borderColor = JXT_HEX_COLOR(0x555555).CGColor;
    [voltageView addSubview:averageVoltageLabel];
    _averageVoltageLabel = averageVoltageLabel;
    
    UIImageView *currentView = JXT_IMAGE_VIEW(@"pic_a");
    [contentView addSubview:currentView];
    
    UIImageView *currentPoint = JXT_IMAGE_VIEW(@"a_pointer");
    currentPoint.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_2);
    [currentView addSubview:currentPoint];
    _currentPoint = currentPoint;
    [currentPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(currentView);
    }];
    
    UILabel *currentLabel = [UILabel labelWithText:@"0.0A" font:[UIFont fontOfSize_20] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
    currentLabel.backgroundColor = [UIColor whiteColor];
    currentLabel.layer.cornerRadius = 3;
    currentLabel.layer.borderWidth = JXT_LINE_WIDTH;
    currentLabel.layer.borderColor = JXT_HEX_COLOR(0x555555).CGColor;
    [currentView addSubview:currentLabel];
    _currentLabel = currentLabel;
    
    UIImageView *rightTextView = JXT_IMAGE_VIEW(@"text_right");
    [contentView addSubview:rightTextView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    [curveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(15);
        make.width.equalTo([curveLabel widthOfLabelWithFixedHeight:MAXFLOAT]);
    }];
    
    [curveTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(curveLabel.mas_right).offset(7);
        make.centerY.equalTo(curveLabel);
        make.right.equalTo(contentView.mas_right).offset(-15);
    }];
    
    [voltageUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curveLabel.mas_bottom).offset(24);
        make.left.equalTo(self.lineView);
        //        make.centerX.equalTo(voltageYArrow);
    }];
    
    //    [voltageYArrow mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(voltageUnitLabel.mas_bottom).offset(4);
    //        make.left.equalTo(45);
    //        make.size.equalTo(CGSizeMake(12, 12));
    //    }];
    
    [currentUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curveLabel.mas_bottom).offset(24);
        make.right.equalTo(self.lineView);
        //        make.centerX.equalTo(currentYArrow);
    }];
    
    //    [currentYArrow mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(currentUnitLabel.mas_bottom).offset(4);
    //        make.right.equalTo(contentView.mas_right).offset(-67);
    //        make.size.equalTo(voltageYArrow);
    //    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(voltageUnitLabel.mas_bottom).offset(4);
        make.left.equalTo(15);
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.height.equalTo(254);
    }];
    
    [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.right.equalTo(contentView);
        make.height.equalTo(68);
    }];
    
    [meterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnBgView.mas_bottom);
        make.left.equalTo(curveLabel);
    }];
    
    [meterTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(meterLabel.mas_right).offset(7);
        make.centerY.equalTo(meterLabel);
        make.right.equalTo(curveTopImage);
    }];
    
    [socBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(meterLabel.mas_bottom).offset(24);
        make.size.equalTo(CGSizeMake(socWidth, socHeight));
        make.centerX.equalTo(contentView);
    }];
    
    [socDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(22);
        make.centerX.equalTo(socBgView);
        make.height.equalTo(22);
    }];
    
    [socLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(socDescLabel.mas_bottom).offset(6);
        make.centerX.equalTo(socBgView);
        make.height.equalTo(20);
    }];
    
    [leftTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView.mas_bottom).offset(-20);
        if (JXT_SMALL_SCREEN) {
            make.size.equalTo(CGSizeMake(0.8*leftTextView.image.size.width, 0.8*leftTextView.image.size.height));
        }
    }];
    
    [voltageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftTextView);
        make.top.equalTo(socBgView.mas_bottom).offset(4);
        make.left.equalTo(curveLabel);
        if (JXT_SMALL_SCREEN) {
            make.size.equalTo(CGSizeMake(0.8*voltageView.image.size.width, 0.8*voltageView.image.size.height));
        }
    }];
    
    [overallVoltageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(44*(JXT_SMALL_SCREEN ? 0.8 : 1));
        make.centerX.equalTo(voltageView);
        make.height.equalTo(22);
        make.width.equalTo([overallVoltageLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
    
    [averageVoltageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(voltageView.mas_bottom).offset(-44*(JXT_SMALL_SCREEN ? 0.8 : 1));
        make.centerX.height.equalTo(overallVoltageLabel);
        make.width.equalTo([averageVoltageLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
    
    [rightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (JXT_SMALL_SCREEN) {
            make.size.equalTo(CGSizeMake(0.8*rightTextView.image.size.width, 0.8*rightTextView.image.size.height));
        }
    }];
    
    [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rightTextView);
        make.top.equalTo(socBgView.mas_bottom).offset(4);
        make.right.equalTo(curveTopImage);
        if (JXT_SMALL_SCREEN) {
            make.size.equalTo(CGSizeMake(0.8*currentView.image.size.width, 0.8*currentView.image.size.height));
        }
    }];
    
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(44*(JXT_SMALL_SCREEN ? 0.8 : 1));
        make.centerX.equalTo(currentView);
        make.height.equalTo(22);
        make.width.equalTo([currentLabel widthOfLabelWithFixedHeight:MAXFLOAT]+10);
    }];
}

- (void)setupLineViewDataSet {
    ChartXAxis *xAxis = self.lineView.xAxis;
    xAxis.axisMinimum = [[NSDate date] timeIntervalSinceReferenceDate];
    xAxis.axisMaximum = [[NSDate dateWithTimeIntervalSinceNow:60] timeIntervalSinceReferenceDate];
    
    self.set1 = [self chartDatasetWithEntries:[NSMutableArray array] lineColor:self.color1 label:nil axisDependency:AxisDependencyLeft];
    self.set2 = [self chartDatasetWithEntries:[NSMutableArray array] lineColor:self.color2 label:nil axisDependency:AxisDependencyLeft];
    self.set3 = [self chartDatasetWithEntries:[NSMutableArray array] lineColor:self.color3 label:nil axisDependency:AxisDependencyLeft];
    self.set3.axisDependency = AxisDependencyLeft;
    self.set4 = [self chartDatasetWithEntries:[NSMutableArray array] lineColor:self.color4 label:nil axisDependency:AxisDependencyRight];
    NSArray *dataset = @[self.set1, self.set2, self.set3, self.set4];

    LineChartData *data = [[LineChartData alloc]initWithDataSets:dataset];
    [self.lineView setData:data];
}

- (LineChartDataSet *)chartDatasetWithEntries:(NSMutableArray *)yVals lineColor:(UIColor *)lineColor label:(NSString *)label axisDependency:(AxisDependency)dependency {
    //创建LineChartDataSet对象
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithEntries:yVals label:label];
    
    set.axisDependency = dependency;
    //设置折线的样式
    set.lineWidth = 1;//折线宽度
    set.drawValuesEnabled = YES;//是否在拐点处显示数据
    set.valueFormatter = [[JXTDataValueFormater alloc] initWithArray:yVals];
    set.valueColors = @[[UIColor whiteColor]];//折线拐点处显示数据的颜色
    set.circleRadius = 3.0;
    [set setCircleColor:[UIColor whiteColor]];
    [set setColor:lineColor];//折线颜色
    set.highlightColor = [UIColor grayColor];
    set.highlightLineWidth = 0.5;
    //    set.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
    //折线拐点样式
    set.drawCirclesEnabled = NO;//是否绘制拐点
    set.drawFilledEnabled = NO;//是否填充颜色
    
    return set;
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    double value = entry.y;
    if (AxisDependencyRight == highlight.axis) {//电流
        self.selectLabel.text = [NSString stringWithFormat:@"%.1fA",value];
    } else {//电压
        UIButton *btn1 = [self.view viewWithTag:100];
        UIButton *btn2 = [self.view viewWithTag:100+1];
        UIButton *btn3 = [self.view viewWithTag:100+2];
        if (btn1.selected && !btn2.selected && !btn3.selected) {
            self.selectLabel.text = [NSString stringWithFormat:@"%.3fV",value];
        } else {
            self.selectLabel.text = [NSString stringWithFormat:@"%.3fV",value /1000.0];
        }
    }

    LineChartDataSet *set = (LineChartDataSet *)chartView.data.dataSets[highlight.dataSetIndex];
    self.selectLabel.textColor = [set.colors firstObject];
    
    self.selectLabel.jxt_width = [self.selectLabel widthOfLabelWithFixedHeight:MAXFLOAT]+12;
    self.shadowView.jxt_width = self.selectLabel.jxt_width;
}

- (void)chartValueNothingSelected:(ChartViewBase *)chartView{
    
}

#pragma mark - Action Method

- (void)cleanBtnDidClicked:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [JXTAlertViewController presentAlertControllerWithTitle:@"曲线清零将会重绘动态曲线，确定要执行吗？" level:JXTAlertViewControllerWarning confirmBlock:^{
        weakSelf.cleanData = YES;
        [weakSelf setupLineViewDataSet];
    }];
}

- (void)batteryInfoDidChanged:(NSNotification *)ntf{
    [self updateStatus];
}

- (void)peripheralDidConnected:(NSNotification *)ntf {
    if(!self.lastPeripheral){
        //第一次连接
        self.lastPeripheral = [JXTBluetooth sharedInstance].currentPeripheral;
        return;
    }
    if ([self.lastPeripheral.identifier.UUIDString isEqualToString:[JXTBluetooth sharedInstance].currentPeripheral.identifier.UUIDString]) {//断开设备重新连接
        self.lastPeripheral = [JXTBluetooth sharedInstance].currentPeripheral;
        return;
    } else {//连接新设备
        [self setupLineViewDataSet];//清空之前的数据
        self.lastPeripheral = [JXTBluetooth sharedInstance].currentPeripheral;
        return;
    }
}

- (void)btnDidClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSUInteger index = sender.tag - 100;
    NSArray *arr = @[self.set1, self.set2, self.set3, self.set4];
    LineChartDataSet *set = arr[index];
    if (sender.selected) {
        [self.lineView.data addDataSet:set];
    } else {
        [self.lineView.data removeDataSet:set];
    }
    
    [self.lineView setNeedsDisplay];
}

#pragma mark - Getter & Setter

- (LineChartView *)lineView {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] init];
        _lineView.extraLeftOffset = 15;
        _lineView.extraTopOffset = 30;
        _lineView.extraRightOffset = 15;
        _lineView.delegate = self;//设置代理
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.noDataText = @"暂无数据";
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        
        //        _lineView.dragEnabled = NO;//启用拖拽图标
        _lineView.userInteractionEnabled = YES;
        //        _lineView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
        
        _lineView.dragDecelerationFrictionCoef = 0.7;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        //设置滑动时候标签
//        ChartMarkerView *markerY = [[ChartMarkerView alloc] init];
//        markerY.offset = CGPointMake(-999, -8);
//        markerY.chartView = _lineView;
//        _lineView.marker = markerY;
//        [markerY addSubview:self.selectLabel];
        
        ChartMarkerView *marker = [[ChartMarkerView alloc] initWithFrame:CGRectZero];
        self.shadowView.frame = CGRectMake(-30, -24, 60, 20);
        [marker addSubview:self.shadowView];
        [self.shadowView addSubview:self.selectLabel];
        self.selectLabel.frame = CGRectMake(0, 0, 60, 20);
        _lineView.marker = marker;
   
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
//        leftAxis.labelCount = 6;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
//        leftAxis.forceLabelsEnabled = YES;//强制绘制指定数量的label
        leftAxis.axisMinimum = 0;//设置Y轴的最小值
        leftAxis.axisMaximum = 5;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor defaultBlackColor];//Y轴颜色
        leftAxis.valueFormatter = [[JXTYValueFormater alloc] init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor defaultBlackColor];//文字颜色
        leftAxis.labelFont = [UIFont fontOfSize_16];//文字字体
        leftAxis.gridColor = [UIColor lineColor];//网格线颜色
        leftAxis.gridLineDashLengths = @[@3,@3];
        leftAxis.granularity = 1;
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        _lineView.rightAxis.enabled = YES;//绘制右边轴
        ChartYAxis *rightAxis = _lineView.rightAxis;//获取右边Y轴
//        rightAxis.labelCount = 6;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
//        rightAxis.forceLabelsEnabled = YES;//强制绘制指定数量的label
        rightAxis.axisMinimum = -10;//设置Y轴的最小值
        rightAxis.axisMaximum = 10;//设置Y轴的最大值
        rightAxis.inverted = NO;//是否将Y轴进行上下翻转
        rightAxis.axisLineColor = [UIColor defaultBlackColor];//Y轴颜色
        rightAxis.valueFormatter = [[JXTYValueFormater alloc] init];
        rightAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        rightAxis.labelTextColor = [UIColor defaultBlackColor];//文字颜色
        rightAxis.labelFont = [UIFont fontOfSize_16];//文字字体
        rightAxis.gridColor = [UIColor lineColor];//网格线颜色
        rightAxis.gridLineDashLengths = @[@3,@3];
        rightAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.gridLineDashLengths = @[@3,@3];
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor lineColor];
        xAxis.labelTextColor = [UIColor defaultBlackColor];//文字颜色
        xAxis.axisLineColor = [UIColor defaultBlackColor];
        xAxis.labelFont = [UIFont systemFontOfSize:8];
        xAxis.forceLabelsEnabled = YES;
        xAxis.labelCount = 5;
        xAxis.valueFormatter = [[JXTXValueFormater alloc] init];
        
        _lineView.maxVisibleCount = 5;
        _lineView.legend.enabled = NO;
        [_lineView setAutoScaleMinMaxEnabled:YES];
        [_lineView animateWithXAxisDuration:1.0f];
    }
    
    return _lineView;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        CALayer *subLayer = _shadowView.layer;
        subLayer.shadowColor = [UIColor blackColor].CGColor;
        subLayer.shadowOffset = CGSizeMake(1,1);
        subLayer.shadowOpacity = 0.5;
        subLayer.shadowRadius = 4;
    }
    
    return _shadowView;
}

- (UILabel *)selectLabel{
    if (!_selectLabel) {
        _selectLabel = [UILabel labelWithText:nil font:[UIFont fontOfSize_16] textColor:[UIColor defaultItemColor] textAlignment:NSTextAlignmentCenter];
        _selectLabel.backgroundColor = [UIColor whiteColor];
        _selectLabel.layer.cornerRadius = 4;
        _selectLabel.layer.masksToBounds = YES;
    }
    
    return _selectLabel;
}

- (UIColor *)color1 {
    if (!_color1) {
        _color1 = JXT_HEX_COLOR(0x34c624);
    }
    
    return _color1;
}

- (UIColor *)color2 {
    if (!_color2) {
        _color2 = JXT_HEX_COLOR(0xed1515);
    }
    
    return _color2;
}

- (UIColor *)color3 {
    if (!_color3) {
        _color3 = [UIColor defaultItemColor];
    }
    
    return _color3;
}

- (UIColor *)color4 {
    if (!_color4) {
        _color4 = JXT_HEX_COLOR(0xffba27);
    }
    
    return _color4;
}

@end
