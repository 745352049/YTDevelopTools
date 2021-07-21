//
//  NSObject+YTRandom.m
//

#import "NSObject+YTRandom.h"

@implementation NSObject (YTRandom)

/// [from, to]
+ (int)getRandomValueOne:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1))); 
}

/// [from, to)
+ (int)getRandomValueTwo:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from)));
}

@end
