//
//  NSTimerProxy.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimerProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@property (nonatomic,   weak) id target;

@end

NS_ASSUME_NONNULL_END
