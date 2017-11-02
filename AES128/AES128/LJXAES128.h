//
//  LJXAES128.h
//  AES128
//
//  Created by Rocky on 2017/9/28.
//  Copyright © 2017年 flowLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJXAES128 : NSObject


/**
 加密

 @param data 需要加密的string
 @return 加密后的字符串
 */
+ (NSString *)AES128EncryptString:(NSData *)data;


/**
 解密

 @param string 加密的字符串
 @return 解密后的内容
 */
+ (NSString *)AES128DecryptString:(NSString *)string;

/**
 加密
 
 @param data 需要加密的string
 @return 加密后的字符串
 */
//+ (NSData *)AES128EncryptData:(NSData *)data;
//
//
///**
// 解密
// 
// @param data 加密的字符串
// @return 解密后的内容
// */
//+ (NSData *)AES128DecryptData:(NSData *)data;
@end
