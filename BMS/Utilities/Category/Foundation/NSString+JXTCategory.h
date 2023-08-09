//
//  NSString+JXTRegex.h
//  SplendidGarden
//
//  Created by qinwen on 2017/11/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JXTRegex)

+ (BOOL)validateContactNumber:(NSString *)mobileNum;
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum;
//判断是否银行卡
+ (BOOL)checkCardNo:(NSString*)cardNo;

//计算字符串位数
+(NSInteger)jaf_getLenthByString:(NSString*)string;

-(CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont*)font;
-(CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont*)font;

//判断是否含有emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//过滤掉所有表情
+ (NSString *)disable_emoji:(NSString *)text;
@end

@interface NSString (JXTUnicode)

- (NSString *)unicodeStringToUTF8String;
- (NSString *)UTF8StringToUnicodeString;

- (NSString *)base64EncodedString;
- (NSString *)base64DecodeString;

+ (NSString *)urlEncodedString:(NSString *)str;
+ (NSString *)urlDecodedString:(NSString *)str;


@end
