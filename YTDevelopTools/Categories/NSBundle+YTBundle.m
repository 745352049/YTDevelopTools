//
//  NSBundle+YTBundle.m
//  

#import "NSBundle+YTBundle.h"

#import <objc/runtime.h>

static const char _bundle = 0;

@interface YTBundleExtension : NSBundle

@end

@implementation YTBundleExtension

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (YTBundle)

+ (NSDictionary<NSString *, id> *)getInfoDictionary {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)getAppShortVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)getAppBundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (void)setAppLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [YTBundleExtension class]);
    });

    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
