//
//  NSObject+YTRandomTools.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YTRandom)

/// [from, to]
+ (int)getRandomValueOne:(int)from to:(int)to;

/// [from, to)
+ (int)getRandomValueTwo:(int)from to:(int)to;

@end

NS_ASSUME_NONNULL_END
