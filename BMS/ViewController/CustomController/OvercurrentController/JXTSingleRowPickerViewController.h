//
//  JXTSingleRowPickerViewController.h
//  SplendidGarden
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTOverCurrentViewController.h"
@class JXTSingleRowPickerViewController;

@protocol JXTSingleRowPickerViewControllerDelegate <NSObject>

- (void)singleRowPickerViewController:(JXTSingleRowPickerViewController *)vc didSlelectRow:(NSInteger)row content:(NSString *)content;

@end

@interface JXTSingleRowPickerViewController : JXTOverCurrentViewController

@property (nonatomic, assign) NSInteger minRow;
@property (nonatomic, assign) NSInteger maxRow;
@property (nonatomic, weak) id<JXTSingleRowPickerViewControllerDelegate> singleRowPickerViewDelegate;

- (instancetype)initWithDatasource:(NSArray *)datasource;

@end
