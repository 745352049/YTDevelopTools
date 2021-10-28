//
//  NSTimerProxy.m
//

#import "NSTimerProxy.h"

@implementation NSTimerProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    NSTimerProxy *proxy = [NSTimerProxy alloc];
    proxy.target = target;
    
    return proxy;
}

// NSProxy 是专门做消息转发的, 只要调用到NSProxy里面的方法, 就会立即执行下面的函数
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
