//
//  NSAttributedString+JXTAttributedString.m
//  SplendidGarden
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NSAttributedString+JXTCategory.h"

@implementation NSAttributedString (JXTAttributedString)

#pragma mark - Public Method

+ (instancetype)stringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font verticalAlignment:(JXTVerticalAlignment)verticalAlignment {
    if (0 == string.length) {
        return nil;
    }
    NSRange range = NSMakeRange(0, string.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    if (color) {
        [attrDic setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    if (font) {
        [attrDic setObject:font forKey:NSFontAttributeName];
    }
    
    CGSize size = [string sizeWithAttributes:attrDic];
    NSNumber *lineOffset = @(verticalAlignment * (size.height-font.pointSize)/2);
    [attrDic setObject:lineOffset forKey:NSBaselineOffsetAttributeName];
    
    [attrStr setAttributes:attrDic range:range];
    
    return attrStr;
}

+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern headIndent:(CGFloat)headIndent {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByClipping;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    paraStyle.alignment = textAlignment;
    //    NSNumber *kernSpacing = @(kern);//设置字间距
    if (0 != headIndent) {
        paraStyle.firstLineHeadIndent = headIndent;//首行缩进
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
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:attrDic];

    return attributeStr;
}


+ (instancetype)deleteLineStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    if (0 == string.length) {
        return nil;
    }
    
    NSMutableAttributedString *attrStr = [[NSAttributedString stringWithString:string color:color font:font verticalAlignment:JXTVerticalAlignmentBottom] mutableCopy];
     [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, string.length)];
    
    return attrStr; 
}

@end
