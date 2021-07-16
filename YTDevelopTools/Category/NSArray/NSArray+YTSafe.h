//
//  NSArray+YTSafe.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YTSafe)

- (id)safe_ObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
