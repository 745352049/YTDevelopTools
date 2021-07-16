//
//  NSString+YTCheck.m
//  

#import "NSString+YTCheck.h"

@implementation NSString (YTCheck)

- (BOOL)isBlankString {
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isEqual:NULL]) {
        return YES;
    }
    if ([self isEqual:@"NULL"]) {
        return YES;
    }
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self class] isSubclassOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self class] isMemberOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([self isEqualToString:@"null"]) {
        return YES;
    }
    if ([self isEqualToString:@"NULL"]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)notBlankString {
    if ([self isBlankString]) {
        return @"";
    }
    return self;
}

- (NSString *)wipeFrontBackSpace {
    /// 过滤字符串前后的空格
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)wipeAllSpace {
    /// 过滤所有空格
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)wipeLineFeed {
    /// 过滤所有换行
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\r" withString:@"，"];
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:@"，"];
}

- (NSString *)wipeLineFeed:(NSString *)str {
    /// 过滤所有换行
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\r" withString:str];
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:str];
}

@end
