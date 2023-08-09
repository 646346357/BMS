/*
 BabyBluetooth
 简单易用的蓝牙ble库，基于CoreBluetooth 作者：刘彦玮
 https://github.com/coolnameismy/BabyBluetooth
 */

//  Created by 刘彦玮 on 15/8/1.
//  Copyright (c) 2015年 刘彦玮. All rights reserved.
//

#import "BabyToy.h"

@implementation BabyToy

//求累加和(校验和)(CHECKSUM)的求法
+ (Byte)getCheckSum:(NSData *)byteStr headerLength:(NSInteger)headerLength {
    int length = (int)byteStr.length;
    Byte *bytes = (unsigned char *)[byteStr bytes];
    uint32_t sum = 0;
    for (NSInteger i = headerLength; i<length-1; i++) {
        sum += bytes[i];
    }
    Byte returnValue = sum & 0xff;
    return returnValue;
}

//将十进制转化为十六进制
+ (NSString *)ConvertIntToHexString:(int)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    int ttmpig;
    for (int i = 0; i < 9; i++) {
        ttmpig = tmpid % 16;
        tmpid = tmpid / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    //NSLog(@"16进制是：%@",str);
    //不够一个字节凑0
    if(str.length == 1){
        return [NSString stringWithFormat:@"0%@",str];
    }else{
        return str;
    }
}

+ (NSData *)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:sizeof(int)];
    }
    
    return data;
}

//十六进制转换为普通字符串的。
+ (NSString *)ConvertHexStringToString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:NSUTF8StringEncoding];
    //    BabyLog(@"===字符串===%@",unicodeString);
    return unicodeString;
}

//普通字符串转换为十六进制
+ (NSString *)ConvertStringToHexString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for (int i=0;i<[myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if ([newHexStr length]==1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
        
    }
    return hexStr;
}


//int转data
+ (NSData *)ConvertIntToData:(int)i {
    
    NSData *data = [NSData dataWithBytes: &i length: sizeof(i)];
    return data;
}

//data转int
+ (int)ConvertDataToInt:(NSData *)data {
    int i;
    [data getBytes:&i length:sizeof(i)];
    return i;
}

//data转Byte[]
+(Byte *)ConvertDataToByteArray:(NSData *)data {
    Byte *i = (Byte *)[data bytes];
    return i;
}

//十六进制转换为普通字符串的。
+ (NSData *)ConvertHexStringToData:(NSString *)hexString {
    
    NSData *data = [[BabyToy ConvertHexStringToString:hexString] dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}


//根据UUIDString查找CBCharacteristic
+ (CBCharacteristic *)findCharacteristicFormServices:(NSMutableArray *)services
                                          UUIDString:(NSString *)UUIDString {
    for (CBService *s in services) {
        for (CBCharacteristic *c in s.characteristics) {
            if ([c.UUID.UUIDString isEqualToString:UUIDString]) {
                return c;
            }
        }
    }
    return nil;
}

@end


