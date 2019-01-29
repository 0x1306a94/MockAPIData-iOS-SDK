//
//  SSHTTPSessionManager.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSHTTPSessionManager.h"
#import "SSMockAPIBaseModel.h"


#import <YYModel/YYModel.h>

@implementation SSHTTPSessionManager
- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters responseCls:(Class)responseCls success:(Successful)success failure:(Failure)failure {
    return [self GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handlerResponseCls:responseCls responseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
}
- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters responseCls:(Class)responseCls success:(Successful)success failure:(Failure)failure {
    return [self POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handlerResponseCls:responseCls responseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
}

- (void)handlerResponseCls:(Class)responseCls responseObject:(id)responseObject success:(Successful)success failure:(Failure)failure {
    if (!responseObject) {
        !success ?: success(nil);
        return;
    }
    __kindof SSMockAPIBaseModel *baseModel = nil;
    if (responseCls) {
        baseModel = [responseCls yy_modelWithJSON:responseObject];
    } else {
        baseModel = [SSMockAPIBaseModel yy_modelWithJSON:responseObject];
    }
    if ([baseModel isKindOfClass:SSMockAPIBaseModel.class] && baseModel.errorCode == 0) {
        !success ?: success(baseModel);
    } else {
        !success ?: success(baseModel);
    }
}
@end
