//
//  SSMockAPIDataSDK+Private.m
//  Pods
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIDataSDK+Private.h"

#import <objc/runtime.h>

@implementation SSMockAPIDataSDK (Private)
- (SSMockAPIAuthInfoModel *)authInfo {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAuthInfo:(SSMockAPIAuthInfoModel *)authInfo {
    objc_setAssociatedObject(self, @selector(authInfo), authInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SSHTTPSessionManager *)sessionManager {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSessionManager:(SSHTTPSessionManager *)sessionManager {
    objc_setAssociatedObject(self, @selector(sessionManager), sessionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
