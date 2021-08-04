//
//  NSString+YTDevicePlatform.m
//

#import "NSString+YTDevicePlatform.h"

@implementation NSString (YTDevicePlatform)

- (NSString *)getDevicePlatform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /// iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE 1st";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2nd";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    /// iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3rd";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3rd";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3rd";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4th";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4th";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4th";
    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad 5th";
    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad 5th";
    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad 6th";
    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad 6th";
    if ([platform isEqualToString:@"iPad7,11"]) return @"iPad 7th";
    if ([platform isEqualToString:@"iPad7,12"]) return @"iPad 7th";
    if ([platform isEqualToString:@"iPad11,6"]) return @"iPad 8th";
    if ([platform isEqualToString:@"iPad11,7"]) return @"iPad 8th";
    
    /// iPad mini
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad11,1"]) return @"iPad mini 5th";
    if ([platform isEqualToString:@"iPad11,2"]) return @"iPad mini 5th";
    
    /// iPad Air
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad11,3"]) return @"iPad Air 3rd";
    if ([platform isEqualToString:@"iPad11,4"]) return @"iPad Air 3rd";
    if ([platform isEqualToString:@"iPad13,1"]) return @"iPad Air 4th";
    if ([platform isEqualToString:@"iPad13,2"]) return @"iPad Air 4th";
    
    /// iPad Pro
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro 2nd (12.9-inch)";
    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 2nd (12.9-inch)";
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad8,1"]) return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,2"]) return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,3"]) return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,4"]) return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,5"]) return @"iPad Pro 3rd (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,6"]) return @"iPad Pro 3rd (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,7"]) return @"iPad Pro 3rd (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,8"]) return @"iPad Pro 3rd (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,9"]) return @"iPad Pro 2nd (11-inch)";
    if ([platform isEqualToString:@"iPad8,10"]) return @"iPad Pro 2nd (11-inch)";
    if ([platform isEqualToString:@"iPad8,11"]) return @"iPad Pro 4rd (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,12"]) return @"iPad Pro 4rd (12.9-inch)";
    
    /// 其他
    if ([platform isEqualToString:@"i386"]) return @"iPhone/iPad Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone/iPad Simulator";
    
    return platform;
}

@end
