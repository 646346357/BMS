//
//  NSAttributedString+JXTAttributedString.h
//  SplendidGarden
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger ,JXTVerticalAlignment){
    JXTVerticalAlignmentBottom = -1, //低居中
    JXTVerticalAlignmentMiddle, //中居中
    JXTVerticalAlignmentTop //上居中
};

@interface NSAttributedString (JXTAttributedString)

+ (instancetype)stringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font verticalAlignment:(JXTVerticalAlignment)verticalAlignment;
+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing kern:(CGFloat)kern headIndent:(CGFloat)headIndent;
+ (instancetype)deleteLineStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font;

@end
