//
//  UISearchBar+Category.h
//  SplendidGarden
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (FMAdd)

- (void)fm_setTextFont:(UIFont *)font;
- (void)fm_setTextColor:(UIColor *)textColor;
- (void)fm_setCancelButtonTitle:(NSString *)title;
/**
 *  设置取消按钮字体
 *
 *  @param font 字体
 */
- (void)fm_setCancelButtonFont:(UIFont *)font;

@end
