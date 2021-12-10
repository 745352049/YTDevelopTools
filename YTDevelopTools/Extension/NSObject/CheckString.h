//
//  CheckString.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CheckString;

#define YTCheckStringNotBlank(string) string = [CheckString notBlank:string]

@interface CheckString : NSObject

/// 是否为空字符串
+ (BOOL)isBlank:(NSString *)string;

/// 字符串不能为空
+ (NSString *)notBlank:(NSString *)string;

/// 过滤字符串前后的空格
+ (NSString *)wipeFrontBackSpace:(NSString *)string;

/// 过滤所有空格
+ (NSString *)wipeAllSpace:(NSString *)string;

/// 替换所有空格
+ (NSString *)replaceAllSpace:(NSString *)string with:(NSString *)replacement;

/// 过滤所有换行
+ (NSString *)wipeLineFeed:(NSString *)string;

/// 替换所有换行
+ (NSString *)replaceAllLineFeed:(NSString *)string with:(NSString *)replacement;

/// 去除首位空格和换行
+ (NSString *)wipeFrontBackSpaceAndLineFeed:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
