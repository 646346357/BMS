//
//  UIButton+JXTButton.h
//  SplendidGarden
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JXTButton)

+ (instancetype)buttonWithImage:(UIImage *)image target:(id)taget selector:(SEL)sel;
+ (instancetype)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)taget selector:(SEL)sel;
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel;
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedFont:(UIFont *)selectedFont selectedTitleColor:(UIColor *)selectedTitleColor target:(id)taget selector:(SEL)sel;

+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel;
+ (instancetype)buttonWithBackgroundImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel;

@end
