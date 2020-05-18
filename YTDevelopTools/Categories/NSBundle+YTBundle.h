//
//  NSBundle+YTBundle.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (YTBundle)

+ (NSDictionary<NSString *, id> *)getInfoDictionary;

+ (NSString *)getAppShortVersion;

+ (NSString *)getAppVersion;

+ (NSString *)getAppName;

+ (NSString *)getAppBundleIdentifier;

+ (void)setAppLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
