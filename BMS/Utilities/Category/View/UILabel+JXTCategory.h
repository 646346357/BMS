//
//  UILabel+JXTLabel.h
//  SplendidGarden
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JXTLabel)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

+ (instancetype)labelWithBackgroundColor:(UIColor *)color;


//带行间距和字间距的UILabel
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern headIndent:(CGFloat)headIndent;
//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)heightOfLabelWithText:(NSString *)text fixedWidth:(CGFloat)width textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern;
//计算UILabel的宽度(带有字间距的情况)
+ (CGFloat)widthOfLabelWithText:(NSString *)text fixedHeight:(CGFloat)height textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern;

/**
 *  改变行间距
 */
- (void)changeLineSpaceWithSpace:(float)space;

/**
 *  改变字间距
 */
- (void)changeWordSpaceWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


- (CGFloat)widthOfLabelWithFixedHeight:(CGFloat)height;
- (CGFloat)heightOfLabelWithFixedWidth:(CGFloat)width;
- (void)conversionCharacterInterval:(NSInteger)maxInteger current:(NSString *)currentString;

@end
