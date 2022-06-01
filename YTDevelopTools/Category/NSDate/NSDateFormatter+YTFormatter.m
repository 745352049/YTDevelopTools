//
//  NSDateFormatter+YTFormatter.m
//

#import "NSDateFormatter+YTFormatter.h"

@implementation NSDateFormatter (YTFormatter)

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        dateFormatter.locale = [NSLocale systemLocale];
        /**
         设置 -> 通用 -> 语言与地区
         系统日历有三种
         1 公历 2 日本日历 3 佛教日历
         根据用户的选择会出现不同的时间
         1 2019-09-23 11:55:18 2 0028-07-23 02:10:17 3 2562-09-23 11:57:25
         防止用户选择其他日历而发生冲突 所以这里要设置日历为 公历 日历
         */
        [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    });
    return dateFormatter;
}

@end
