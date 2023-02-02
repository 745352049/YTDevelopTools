//
//  NSDate+YTDate.h
//  

#import <Foundation/Foundation.h>

#import "NSDateFormatter+YTFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YTDate)

/// 获取当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat;

/// 获取当前时间
+ (NSDate *)getCurrentTimeDateWithDateFormat:(NSString *)dateFormat;

/// 获取当前时间多少秒以后或者以前
+ (NSString *)getInterval:(NSTimeInterval)interval dateFormat:(NSString *)dateFormat;

/// 固定时间获取多少秒以后或者以前
+ (NSString *)getInterval:(NSTimeInterval)interval time:(NSString *)time dateFormat:(NSString *)dateFormat;

/// 时间比较  
+ (int)compareTime:(NSString *)start with:(NSString *)end dateFormat:(NSString *)dateFormat;

/// 获取时间差
+ (NSString *)getTime:(NSString *)time dateFormat:(NSString *)dateFormat AfterWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSString *)getDate:(NSDate *)date dateFormat:(NSString *)dateFormat AfterWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (NSDateComponents *)getComponentsWithStart:(NSString *)start end:(NSString *)end dateFormat:(NSString *)dateFormat unit:(NSCalendarUnit)unit;

@end

NS_ASSUME_NONNULL_END
