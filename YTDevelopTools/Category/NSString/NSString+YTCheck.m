//
//  NSString+YTCheck.m
//  

#import "NSString+YTCheck.h"

@implementation NSString (YTCheck)

- (NSString *)Safe_substringWithRange:(NSRange)range {
    if ((range.location + range.length) <= self.length) {
        return [self substringWithRange:range];
    }
    return nil;
}

- (NSArray<NSString *> *)safe_componentsSeparatedByString:(NSString *)separator {
    if (self.length > 0) {
        return [self componentsSeparatedByString:separator];
    }
    return @[];
}

@end
