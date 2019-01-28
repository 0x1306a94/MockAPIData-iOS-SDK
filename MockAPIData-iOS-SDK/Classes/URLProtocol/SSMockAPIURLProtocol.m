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

static NSString *const SSHTTP = @"SPRHTTP";

@interface SSMockAPIURLProtocol ()<NSURLSessionDataDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLSessionDataTask *ss_task;
@property (nonatomic, strong) NSURLRequest *ss_request;
@property (nonatomic, strong) NSURLResponse *ss_response;
@property (nonatomic, strong) NSMutableData *ss_data;
@end

@implementation SSMockAPIURLProtocol
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

    if ([request.URL.absoluteString containsString:[SSMockAPIDataSDK shared].mockHost]) {
        // 过滤mock server 本身接口
        NSString *path = request.URL.path;
        if ([path isEqualToString:@"/registered"] || [path isEqualToString:@"/login"] || [path hasPrefix:@"/admin"]) {
            return NO;
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
    self.ss_request = request;
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
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    return YES;
}

#pragma mark - NSURLConnectionDataDelegate
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response != nil) {
        self.ss_response = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.ss_response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.ss_data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}
@end
