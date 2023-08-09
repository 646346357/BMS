//
//  NSString+JXTRegex.m
//  SplendidGarden
//
//  Created by qinwen on 2017/11/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NSString+JXTCategory.h"

@implementation NSString (JXTRegex)

#pragma mark - Public Method

+ (BOOL)validateContactNumber:(NSString *)mobileNum {
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestPHS evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

//纯粹只验证手机号码的话用下面这个, 相比于上面那个去掉了验证固话的谓词.
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum {
    cellNum = [cellNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (cellNum.length != 11)
    {
        return NO;
    }
    if (![cellNum hasPrefix:@"1"]) {
        return NO;
    }
    return YES;
    
    //    }else{
    //        /**
    //         * 移动号段正则表达式
    //         *134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198
    //         */
    //        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(170[3,5,6])\\d{7}$";
    //        /**
    //         * 联通号段正则表达式
    //         *130、131、132、145、155、156、166、171、175、176、185、186
    //         */
    //        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(166)|(17[1,5-6])|(18[5,6]))\\d{8}|(170[4,7,8,9])\\d{7}$";
    //        /**
    //         * 电信号段正则表达式
    //         *133、149、153、173、177、180、181、189、199
    //         */
    //        NSString *CT_NUM = @"^((133)|(149)|(153)|(173)|(177)|(18[0,1,9])|(199))\\d{8}|(170[0-2])\\d{7}$";
    //
    //        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    //        BOOL isMatch1 = [pred1 evaluateWithObject:cellNum];
    //        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    //        BOOL isMatch2 = [pred2 evaluateWithObject:cellNum];
    //        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    //        BOOL isMatch3 = [pred3 evaluateWithObject:cellNum];
    //
    //        if (isMatch1 || isMatch2 || isMatch3) {
    //            return YES;
    //        }else{
    //            return NO;
    //        }
    //    }
}

//判断是否银行卡

+ (BOOL)checkCardNo:(NSString*)cardNo {
    NSInteger oddsum = 0;    //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = cardNo.length;
    NSInteger lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0) {
                tmpVal *= 2;
                if(tmpVal>=10) {
                    tmpVal -= 9;
                }
                evensum += tmpVal;
            } else {
                oddsum += tmpVal;
            }
        } else {
            if((i % 2) == 1) {
                tmpVal *= 2;
                if(tmpVal>=10) {
                    tmpVal -= 9;
                }
                evensum += tmpVal;
            } else {
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0) {
        return YES;
    } else {
        return NO;
    }
}

//计算字符串位数

+(NSInteger)jaf_getLenthByString:(NSString*)string{
    NSUInteger  character = 0;
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    return character;
}

//计算字符串高度
-(CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont*)font{
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    if(self == nil && self.length == 0){
        return 0;
    }
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    CGSize size =  [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
    return ceil(size.height) + 1;
}

//计算字符串宽度
-(CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont*)font{
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    if(self == nil && self.length == 0){
        return 0;
    }
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    CGSize size =  [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
    return ceil(size.width)+1;
}

+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (BOOL)stringContainsEmoji:(NSString *)string{
    
    __block BOOL returnValue = NO;
    
    
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
     
                               options:NSStringEnumerationByComposedCharacterSequences
     
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
                                const unichar hs = [substring characterAtIndex:0];
                                
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    
                                    if (substring.length > 1) {
                                        
                                        const unichar ls = [substring characterAtIndex:1];
                                        
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            
                                            returnValue = YES;
                                            
                                        }
                                        
                                    }
                                    
                                } else if (substring.length > 1) {
                                    
                                    const unichar ls = [substring characterAtIndex:1];
                                    
                                    if (ls == 0x20e3) {
                                        
                                        returnValue = YES;
                                        
                                    }
                                    
                                    
                                    
                                } else {
                                    
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        
                                        returnValue = YES;
                                        
                                    }else if (hs == 0x200d){
                                        
                                        returnValue = YES;
                                        
                                    }
                                    
                                }
                                
                            }];
    
    
    
    return returnValue;
    
}
@end

@implementation NSString (JXTUnicode)

#pragma mark - Public Method

- (NSString *)unicodeStringToUTF8String {
    if (0 == self.length) {
        return nil;
    }
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];
    
    return returnStr;
}

- (NSString *)UTF8StringToUnicodeString {
    NSUInteger length = self.length;
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++) {
        unichar _char = [self characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        } else if(_char >='a' && _char <= 'z') {
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        } else if(_char >='A' && _char <= 'Z') {
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        } else {
            [s appendFormat:@"\\u%x",[self characterAtIndex:i]];
        }
    }
    
    return s;
}

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //判断是否传入需要加密数据参数
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    
    //判断设备系统是否满足条件
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 6.9) {
        return nil;
    }
    
    //使用系统的API进行Base64加密操作
    NSDataBase64EncodingOptions options;
    options = NSDataBase64EncodingEndLineWithLineFeed;
    return [data base64EncodedStringWithOptions:options];
}

- (NSString *)base64DecodeString {
    //判断是否传入需要加密数据参数
    if ((self == nil) || (self == NULL)) {
        return nil;
    } else if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    //判断设备系统是否满足条件
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 6.9) {
        return nil;
    }
    
    //使用系统的API进行Base64解密操作
    NSDataBase64DecodingOptions options;
    options = NSDataBase64DecodingIgnoreUnknownCharacters;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:options];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)urlEncodedString:(NSString *)str {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

+ (NSString *)urlDecodedString:(NSString *)str {
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

@end
