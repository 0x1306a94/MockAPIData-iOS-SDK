//
//  SSHTTPSessionManager.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import <AFNetworking/AFHTTPSessionManager.h>

typedef void(^Successful)(id response);
typedef void(^Failure)(NSError *error);
NS_ASSUME_NONNULL_BEGIN

@interface SSHTTPSessionManager : AFHTTPSessionManager
- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters responseCls:(Class)responseCls success:(Successful)success failure:(Failure)failure;
- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters responseCls:(Class)responseCls success:(Successful)success failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END
