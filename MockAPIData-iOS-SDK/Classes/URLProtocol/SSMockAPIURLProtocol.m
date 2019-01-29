//
//  SSMockAPIURLProtocol.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIURLProtocol.h"
#import "SSURLSessionConfiguration.h"
#import "SSMockAPIDataSDK.h"
#import "SSRequestClone.h"
#import "SSMockAPICacheManager.h"

static NSString *const SSHTTP = @"SPRHTTP";

@interface SSMockAPIURLProtocol ()<NSURLSessionDataDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
//@property (nonatomic, strong) NSURLRequest *ss_request;
//@property (nonatomic, strong) NSURLResponse *ss_response;
//@property (nonatomic, strong) NSMutableData *ss_data;
@end

@implementation SSMockAPIURLProtocol
- (void)dealloc {
    if (self.connection) {
        [self.connection cancel];
        self.connection = nil;
    }
}
+ (void)ss_register {

    [NSURLProtocol registerClass:SSMockAPIURLProtocol.class];
    [[SSURLSessionConfiguration defaultConfiguration] ss_register];
}
+ (void)ss_unregister {
    [NSURLProtocol unregisterClass:SSMockAPIURLProtocol.class];
    [[SSURLSessionConfiguration defaultConfiguration] ss_unregister];
}
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    // 拦截过的不再拦截, 防止死循环
    if ([NSURLProtocol propertyForKey:SSHTTP inRequest:request]) {
        return NO;
    }
    if ([request.URL.absoluteString containsString:[SSMockAPIDataSDK shared].host.absoluteString]
        || [request.URL.absoluteString containsString:[SSMockAPIDataSDK shared].mockHost.absoluteString]) {
        // 过滤mock dashboard 相关接口
        return NO;
    }
    // 检查拉取的项目
    NSArray<SSMockAPIProjectModel *> *projects = [[SSMockAPICacheManager shared] getCacheProjects];
    if (!projects || projects.count == 0) return NO;
    for (SSMockAPIProjectModel *p in projects) {
        if ([request.URL.absoluteString containsString:p.host] && p.enable) {
            return YES;
        }
    }
    return YES;
}
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *newReq = [request mutableCopy];
    [NSURLProtocol setProperty:@YES
                        forKey:SSHTTP
                     inRequest:newReq];
    return [SSRequestClone cloneMockRequest:newReq];
}

- (void)startLoading {
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
//    self.ss_request = request;
}
- (void)stopLoading {
    if (self.connection) {
        [self.connection cancel];
        self.connection = nil;
    }
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.client URLProtocol:self didFailWithError:error];
    self.connection = nil;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    return YES;
}

#pragma mark - NSURLConnectionDataDelegate
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response != nil) {
//        self.ss_response = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
//    self.ss_response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
//    [self.ss_data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
    self.connection = nil;
}
@end
