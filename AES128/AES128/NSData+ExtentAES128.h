//
//  NSData+ExtentAES128.h
//  AES128
//
//  Created by Rocky on 2017/9/28.
//  Copyright © 2017年 flowLayout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (ExtentAES128)

/**
 加密

 @param key 公钥
 @return 加密之后的NSData
 */
- (NSData *)AES128EncrypWithKey:(NSData *)key;


/**
 解密

 @param key 公钥
 @return 解密之后的NSDate
 */
- (NSData *)AES128DecryptWithKey:(NSData *)key;
@end
