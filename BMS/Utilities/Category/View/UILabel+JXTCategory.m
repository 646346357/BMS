//
//  UILabel+JXTLabel.m
//  SplendidGarden
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UILabel+JXTCategory.h"

@implementation UILabel (JXTLabel)

#pragma mark - Public Method

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = textAlignment;
    label.minimumScaleFactor = 1;
    if (JXT_SMALL_SCREEN) {
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = .7;
    }

    label.font = font;
    label.textColor = color;
    label.text= text;

    return label;
}

+ (instancetype)labelWithBackgroundColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = color;
    
    return label;
}

//带行间距和字间距的UILabel
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern headIndent:(CGFloat)headIndent {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineBreakMode = NSLineBreakByClipping;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    paraStyle.alignment = textAlignment;
//    NSNumber *kernSpacing = @(kern);//设置字间距
    if (0 != headIndent) {
        paraStyle.firstLineHeadIndent = headIndent;//首行缩进
    }
    
    if (0 == text.length) {
        return label;
    }

    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    if (color) {
        [attrDic setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    if (font) {
        [attrDic setObject:font forKey:NSFontAttributeName];
    }
   
    [attrDic setObject:paraStyle forKey:NSParagraphStyleAttributeName];
//    [attrDic setObject:kernSpacing forKey:NSKernAttributeName];
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:attrDic];
    label.attributedText = attributeStr;
    
    return label;
}

//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)heightOfLabelWithText:(NSString *)text fixedWidth:(CGFloat)width textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineBreakMode = NSLineBreakByClipping;
    paraStyle.alignment = textAlignment;
    paraStyle.lineSpacing = lineSpacing;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)};
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    size.height += 2*lineSpacing;
    return size.height;
}

//计算UILabel的宽度(带有字间距的情况)
+ (CGFloat)widthOfLabelWithText:(NSString *)text fixedHeight:(CGFloat)height textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineBreakMode = NSLineBreakByClipping;
    paraStyle.alignment = textAlignment;
    paraStyle.lineSpacing = lineSpacing;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)
                          };
    CGSize size = [text boundingRectWithSize:CGSizeMake(999, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

- (void)changeLineSpaceWithSpace:(float)space {
    
    NSString *labelText = self.text;
    if (labelText.length <= 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
//    [self sizeToFit];
}

- (void)changeWordSpaceWithSpace:(float)space {
    
    NSString *labelText = self.text;
    if (labelText.length <= 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)changeLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    if (labelText.length <= 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (CGFloat)widthOfLabelWithFixedHeight:(CGFloat)height {
    NSDictionary * dict=[NSDictionary dictionaryWithObject: self.font forKey:NSFontAttributeName];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width +1;
}

- (CGFloat)heightOfLabelWithFixedWidth:(CGFloat)width {
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return rect.size.height;
}

/**
 *  设置UILable里的文字两边对齐
 *  maxInteger    : 应占字符数 （中文为1，英文为0.5/个）
 *  currentString : 要显示的文字
 */
- (void)conversionCharacterInterval:(NSInteger)maxInteger current:(NSString *)currentString
{
    CGRect rect = [[currentString substringToIndex:1] boundingRectWithSize:CGSizeMake(200,self.frame.size.height)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                                attributes:@{NSFontAttributeName: self.font}
                                                                   context:nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:currentString];
    float strLength = [self getLengthOfString:currentString];
    [attrString addAttribute:NSKernAttributeName value:@(((maxInteger - strLength) * rect.size.width)/(strLength - 1)) range:NSMakeRange(0, strLength-1)];
    self.attributedText = attrString;
}

-  (float)getLengthOfString:(NSString*)str {
    
    float strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength/2;
}


@end
