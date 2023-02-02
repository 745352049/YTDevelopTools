//
//  NSString+YTCheck.m
//  

#import "NSString+YTCheck.h"

@implementation NSString (YTCheck)

- (NSString *)safe_substringWithRange:(NSRange)range {
    if ((range.location + range.length) <= self.length) {
        return [self substringWithRange:range];
    }
    return nil;
}

- (BOOL)safe_containsString:(NSString *)string {
    if (string.length <= 0) return NO;
    return [self containsString:string];
}

- (NSArray<NSString *> *)safe_componentsSeparatedByString:(NSString *)separator {
    if (self.length > 0) {
        return [self componentsSeparatedByString:separator];
    }
    return @[];
}

@end
