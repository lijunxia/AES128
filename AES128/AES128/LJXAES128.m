//
//  LJXAES128.m
//  AES128
//
//  Created by Rocky on 2017/9/28.
//  Copyright © 2017年 flowLayout. All rights reserved.
//

#import "LJXAES128.h"
#import "NSData+ExtentAES128.h"


#define KEY @"YAOWBmetnhZNtcQA"  //自定义秘钥

@implementation LJXAES128

+ (NSString *)AES128EncryptString:(NSData *)data{
    NSData *keyData = [self converHexStrToData:@"1B0E93959A53EC71956ABD47E71D33A3"];
    NSData *aesData = [data AES128EncrypWithKey:keyData];
    
    return [LJXAES128 convertDataToHexStr:aesData];
}

+ (NSString *)AES128DecryptString:(NSString *)string{
    NSData *keyData = [self converHexStrToData:@"1B0E93959A53EC71956ABD47E71D33A3"];
    NSData *data = [LJXAES128 converHexStrToData:string];
    NSData *aesData = [data AES128DecryptWithKey:keyData];
    return [LJXAES128 convertDataToHexStr:aesData];
}

+ (NSString *)AES128EncryptkeyString:(NSData *)data{
    
    NSData *aesData = [data AES128EncrypWithStringKey:KEY];
    
    return [LJXAES128 convertDataToHexStr:aesData];
}

+ (NSString *)AES128DecryptkeyString:(NSString *)string{
    
    NSData *data = [LJXAES128 converHexStrToData:string];
    NSData *aesData = [data AES128DecryptWithStringKey:KEY];
    return [LJXAES128 convertDataToHexStr:aesData];
}

//+ (NSData *)AES128EncryptData:(NSData *)data{
//    NSData *aesData = [data AES128EncrypWithKey:KEY];
//    return aesData;
//}
//
//+ (NSData *)AES128DecryptData:(NSData *)data{
//     NSData *aesData = [data AES128DecryptWithKey:KEY];
//    return aesData;
//}

//16进账转换为NSData
+ (NSData *)converHexStrToData:(NSString *)str{
    
    if (!str || [str length] == 0) {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc]initWithCapacity:[str length] * 2];
    NSRange range;
    
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc]initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc]initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

//NSData转换为16进账
+ (NSString *)convertDataToHexStr:(NSData *)data{
    
    if (!data || [data length] == 0) {
        return @"";
    }
    
    NSMutableString *string = [[NSMutableString alloc]initWithCapacity:[data length] / 2];
    
    [data enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
        unsigned char *dataBytes = (unsigned char *)bytes;
        for (NSInteger i = 0; i < byteRange.length; i ++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i] & 0xff)];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@",hexStr];
            }
        }
    }];
    
    return string;
}

@end
