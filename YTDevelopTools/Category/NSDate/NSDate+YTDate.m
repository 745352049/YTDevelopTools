//
//  NSDate+YTDate.m
//  

#import "NSDate+YTDate.h"

@implementation NSDate (YTDate)

- (NSCalendar *)calendar {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    return [NSCalendar currentCalendar]
#endif
}

+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSDate *)getCurrentTimeDateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    NSDate *datestr = [formatter dateFromString:[self getCurrentTimeWithDateFormat:dateFormat]];
    
    return datestr;
}

+ (NSString *)getInterval:(NSTimeInterval)interval dateFormat:(NSString *)dateFormat {
    NSDate *date = [self getCurrentTimeDateWithDateFormat:dateFormat];
    NSDate *intervalDate = [NSDate dateWithTimeInterval:interval sinceDate:date];
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:intervalDate];
}

+ (NSString *)getInterval:(NSTimeInterval)interval time:(NSString *)time dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    NSDate *date = [formatter dateFromString:time];
    NSDate *intervalDate = [NSDate dateWithTimeInterval:interval sinceDate:date];
    return [formatter stringFromDate:intervalDate];
}

+ (int)compareTime:(NSString *)start with:(NSString *)end dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    NSDate *startDate = [formatter dateFromString:start];
    NSDate *endDate = [formatter dateFromString:end];
    NSComparisonResult result = [startDate compare:endDate];
    int comparisonResult;
    switch (result) {
        case NSOrderedAscending: // start < end
            comparisonResult = 1;
            break;
        case NSOrderedSame: // start = end 
            comparisonResult = 0;
            break;
        case NSOrderedDescending: // start > end
            comparisonResult = -1;
            break;
        default:
            break;
    }
    return comparisonResult;
}

+ (NSString *)getTime:(NSString *)time dateFormat:(NSString *)dateFormat AfterWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    
    NSDate *date = [formatter dateFromString:time];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
    return [formatter stringFromDate:newDate];
}

- (NSString *)getDate:(NSDate *)date dateFormat:(NSString *)dateFormat AfterWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
    return [formatter stringFromDate:newDate];
}

+ (NSDateComponents *)getComponentsWithStart:(NSString *)start end:(NSString *)end dateFormat:(NSString *)dateFormat unit:(NSCalendarUnit)unit {
    NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
    [formatter setDateFormat:dateFormat];
    NSDate *startDate = [formatter dateFromString:start];
    NSDate *endDate = [formatter dateFromString:end];
    
    // NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return components;
}

@end
