//
//  NSString+YTCheck.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define YTCheckNotBlankString(string) string = [string notBlankString]
#define YTCheckWipeLineFeed(string, replaceString) string = [string wipeLineFeed:replaceString]

@interface NSString (YTCheck)

- (BOOL)isBlankString;

- (NSString *)notBlankString;

- (NSString *)wipeFrontBackSpace;

- (NSString *)wipeAllSpace;

- (NSString *)wipeLineFeed;

- (NSString *)wipeLineFeed:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
