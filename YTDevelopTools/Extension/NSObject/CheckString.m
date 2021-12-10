//
//  CheckString.m
//

#import "CheckString.h"

@implementation CheckString

+ (BOOL)isBlank:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:NULL]) {
        return YES;
    }
    if ([string isEqual:@"NULL"]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string class] isSubclassOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string class] isMemberOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    if ([string isEqualToString:@"NULL"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if (!string.length || string.length <= 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)notBlank:(NSString *)string {
    if ([self isBlank:string]) {
        return @"";
    }
    return string;
}

+ (NSString *)wipeFrontBackSpace:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)wipeAllSpace:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSString *)replaceAllSpace:(NSString *)string with:(NSString *)replacement {
    return [string stringByReplacingOccurrencesOfString:@" " withString:replacement];
}

+ (NSString *)wipeLineFeed:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+ (NSString *)replaceAllLineFeed:(NSString *)string with:(NSString *)replacement {
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:replacement];
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:replacement];
}

+ (NSString *)wipeFrontBackSpaceAndLineFeed:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
