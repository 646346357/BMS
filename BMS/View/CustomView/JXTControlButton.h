//
//  JXTControlButton.h
//  BMS
//
//  Created by qinwen on 2019/4/14.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTControlButton : UIButton

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage normalTitleImage:(UIImage *)normalTitleImage selectedTitleImage:(UIImage *)selectedTitleImage normalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle;

@end

