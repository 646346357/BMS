//
//  JXTFileViewController.h
//  BMS
//
//  Created by qinwen on 2019/4/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JXTFileViewControllerType) {
    JXTFileViewControllerTypeLog,
    JXTFileViewControllerTypeBin,
};

@interface JXTFileViewController : UIViewController

@property (nonatomic, copy)NSString *path;
@property (nonatomic, assign)JXTFileViewControllerType type;

- (instancetype)initWithPath:(NSString *)path type:(JXTFileViewControllerType)type;

@end


