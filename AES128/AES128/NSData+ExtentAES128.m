//
//  NSData+ExtentAES128.m
//  AES128
//
//  Created by Rocky on 2017/9/28.
//  Copyright © 2017年 flowLayout. All rights reserved.
//

#import "NSData+ExtentAES128.h"

@implementation NSData (ExtentAES128)


/**
 根据CCOperation，确定加密还是解密

 @param operation kCCEncrypt ->加密  kCCDecrypt->解密
 @param key 公钥
 @return 加密或解密的NSData
 */
- (NSData *)AES128Operation:(CCOperation)operation key:(NSData *)key {
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    [key getBytes:keyPtr length:kCCKeySizeAES128 + 1];
    
    
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                     
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    
    free(buffer);
    return nil;
}

- (NSData *)AES128EncrypWithKey:(NSData *)key {
    
    return [self AES128Operation:kCCEncrypt key:key ];
}

- (NSData *)AES128DecryptWithKey:(NSData *)key {
    
    return [self AES128Operation:kCCDecrypt key:key ];
}

/**
 根据CCOperation，确定加密还是解密
 
 @param operation kCCEncrypt ->加密  kCCDecrypt->解密
 @param key 公钥
 @return 加密或解密的NSData
 */
- (NSData *)AES128Operation:(CCOperation)operation stringKey:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    [key getBytes:keyPtr length:kCCKeySizeAES128 + 1];
    
    
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    
    free(buffer);
    return nil;
}

- (NSData *)AES128EncrypWithStringKey:(NSString *)key {
    
    return [self AES128Operation:kCCEncrypt stringKey:key ];
}

- (NSData *)AES128DecryptWithStringKey:(NSString *)key {
    
    return [self AES128Operation:kCCDecrypt stringKey:key ];
}

@end
