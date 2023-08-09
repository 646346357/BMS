//
//  JXTCounterViewController.h
//  SplendidGarden
//
//  Created by qinwen on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTOverCurrentViewController.h"

@protocol JXTCounterViewControllerDelegate <NSObject>

- (void)counterViewControllerDidInputText:(NSString *)text;

@end

@interface JXTCounterViewController : JXTOverCurrentViewController

@property (nonatomic, weak) id<JXTCounterViewControllerDelegate> counterDelegate;

@end
