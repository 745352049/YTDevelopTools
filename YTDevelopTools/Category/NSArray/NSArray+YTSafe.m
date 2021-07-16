//
//  NSArray+YTSafe.m
//

#import "NSArray+YTSafe.h"

@implementation NSArray (YTSafe)

- (id)safe_ObjectAtIndex:(NSUInteger)index {
    if (index < self.count && index >= 0) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
