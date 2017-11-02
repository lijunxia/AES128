//
//  ViewController.m
//  AES128
//
//  Created by Rocky on 2017/9/28.
//  Copyright © 2017年 flowLayout. All rights reserved.
//

#import "ViewController.h"
#import "LJXAES128.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 16进制字符串转data
    NSData *hexStr = [self converHexStrToData:@"06010101000000000000000000000000"];
    //加密
    NSString *strEncrpyt = [LJXAES128 AES128EncryptString:hexStr];
    //解密字符串
    NSString *strDecrypt = [LJXAES128  AES128DecryptString:strEncrpyt];
    NSLog(@"加密：%@      解密字符串:%@",strEncrpyt,strDecrypt);
    
//    NSData *keyData = [self converHexStrToData:@"BA28166F462BFCE342EFB3FD44B2FD0E"];
//    NSString *result =[[ NSString alloc] initWithData:keyData encoding:NSUTF8StringEncoding];
//    NSLog(@"result====:%@",result);
}


- (NSData *)converHexStrToData:(NSString *)str{
    
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


@end
