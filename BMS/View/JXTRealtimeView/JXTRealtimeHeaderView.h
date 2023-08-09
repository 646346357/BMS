//
//  JXTRealtimeHeaderView.h
//  BMS
//
//  Created by qinwen on 2019/3/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTRealtimeHeaderView : UIView

@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) CAShapeLayer *socLayer;
@property (nonatomic, strong, readonly) UILabel *socLabel;
@property (nonatomic, strong, readonly) UILabel *totalCapacityLabel;
@property (nonatomic, strong, readonly) UIView *chargeMosImgView;
@property (nonatomic, strong, readonly) UILabel *chargeMosLabel;
@property (nonatomic, strong, readonly) UILabel *balanceImgView;
@property (nonatomic, strong, readonly) UILabel *balanceLabel;
@property (nonatomic, strong, readonly) UILabel *dischargeMosImgView;
@property (nonatomic, strong, readonly) UILabel *dischargeMosLabel;
@property (nonatomic, strong, readonly) UILabel *overallVoltageLabel;
@property (nonatomic, strong, readonly) UILabel *currentLabel;
@property (nonatomic, strong, readonly) UILabel *powerLabel;
@property (nonatomic, strong, readonly) UILabel *highVoltageLabel;
@property (nonatomic, strong, readonly) UILabel *lowVoltageLabel;
@property (nonatomic, strong, readonly) UILabel *averageVoltageLabel;
@property (nonatomic, strong, readonly) UILabel *voltageDiffLabel;
@property (nonatomic, strong, readonly) UILabel *cycleCapacityLabel;
@property (nonatomic, strong, readonly) UILabel *mosTempratureLabel;
@property (nonatomic, strong, readonly) UILabel *balanceTempratureLabel;
@property (nonatomic, strong, readonly) UILabel *temprature1Label;
@property (nonatomic, strong, readonly) UILabel *temprature2Label;
@property (nonatomic, strong, readonly) UILabel *temprature3Label;
@property (nonatomic, strong, readonly) UILabel *temprature4Label;

- (void)setupSubviews;
- (void)updateStates;

@end


