//
//  NSString+YTDevicePlatform.h
//  

#import <Foundation/Foundation.h>

#import "sys/utsname.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YTDevicePlatform)

- (NSString *)getDevicePlatform;

@end

NS_ASSUME_NONNULL_END
