//
//  UIButton+JXTButton.m
//  SplendidGarden
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIButton+JXTCategory.h"

@implementation UIButton (JXTButton)

#pragma mark - Public Method

+ (instancetype)buttonWithTarget:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:taget action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (instancetype)buttonWithImage:(UIImage *)image target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithTarget:taget selector:sel];
    [btn setImage:image forState:UIControlStateNormal];

    return btn;
}

+ (instancetype)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithImage:image target:taget selector:sel];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithTarget:taget selector:sel];
    if (title.length > 0 ) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:title color:color font:font verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateNormal];
    }
    
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedFont:(UIFont *)selectedFont selectedTitleColor:(UIColor *)selectedTitleColor target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithTarget:taget selector:sel];
    if (title.length > 0 ) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:title color:color font:font verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateNormal];
    }
    
    if (selectedTitle.length > 0) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:selectedTitle color:selectedTitleColor font:selectedFont verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateSelected];
    }
    
    return btn;
}


+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithImage:image target:taget selector:sel];
    if (title.length > 0 ) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:title color:color font:font verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateNormal];
    }

    return btn;
}

+ (instancetype)buttonWithBackgroundImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color target:(id)taget selector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithTarget:taget selector:sel];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if (title.length > 0 ) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:title color:color font:font verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateNormal];
    }
 
    return btn;
}

@end
