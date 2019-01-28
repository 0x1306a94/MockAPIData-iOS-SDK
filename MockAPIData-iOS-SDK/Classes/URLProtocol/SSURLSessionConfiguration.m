//
//  SSURLSessionConfiguration.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSURLSessionConfiguration.h"
#import "SSMockAPIURLProtocol.h"

#import <objc/runtime.h>

static volatile BOOL __isSwizzle__  = NO;
@implementation SSURLSessionConfiguration
+ (instancetype)defaultConfiguration {
    static SSURLSessionConfiguration *__instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instace = [[SSURLSessionConfiguration alloc] init];
    });
    return __instace;

}

- (void)ss_register {
    if (__isSwizzle__) return;
    __isSwizzle__ = YES;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];

}

- (void)ss_unregister {
    if (!__isSwizzle__) return;
    __isSwizzle__ = NO;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];

}

- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {
    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load NEURLSessionConfiguration."];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}

- (NSArray *)protocolClasses {
    return @[SSMockAPIURLProtocol.class];
}
@end
