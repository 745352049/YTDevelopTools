//
//  NSString+YTMD5Encrypt.h
//  

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YTMD5Encrypt)

/// 32位小写加密
- (NSString *)MD5EncryptForLower32Bate;

/// 32位大写加密
- (NSString *)MD5EncryptForUpper32Bate;

/// 16位小写加密
- (NSString *)MD5EncryptForLower16Bate;

/// 16位大写加密
- (NSString *)MD5EncryptForUpper16Bate;

@end

NS_ASSUME_NONNULL_END
