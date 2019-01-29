//
//  SSJSONRequestSerializer.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSJSONRequestSerializer.h"
#import "SSMockAPIDataSDK+Private.h"

@implementation SSJSONRequestSerializer
- (nullable NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                                        withParameters:(nullable id)parameters
                                                 error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableURLRequest *newReq = [[super requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    if ([SSMockAPIDataSDK shared].authInfo.token .length > 0) {
        [newReq setValue:[SSMockAPIDataSDK shared].authInfo.token forHTTPHeaderField:@"Mock-Token"];
    }
    return newReq;
    
}
@end
