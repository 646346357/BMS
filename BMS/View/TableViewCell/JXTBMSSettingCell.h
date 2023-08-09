//
//  JXTBMSSettingCell.h
//  BMS
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXTBMSSettingCell;

@protocol JXTBMSSettingCellDelegate <NSObject>

- (void)BMSSettingCell:(JXTBMSSettingCell *)cell valueChanged:(NSString *)value;
- (void)BMSSettingCell:(JXTBMSSettingCell *)cell settingValue:(NSString *)value;

@end

@interface JXTBMSSettingCell : UITableViewCell

@property (nonatomic, weak) id<JXTBMSSettingCellDelegate> delegate;

- (void)configCellWithCharacter:(JXTCharacter *)character;

@end

