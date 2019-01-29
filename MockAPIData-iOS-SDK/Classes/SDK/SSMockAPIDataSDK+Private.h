//
//  SSMockAPIDataSDK+Private.h
//  Pods
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIDataSDK.h"
#import "SSMockAPIAuthModel.h"
#import "SSHTTPSessionManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIDataSDK (Private)
@property (nonatomic, strong) SSMockAPIAuthInfoModel *authInfo;
@property (nonatomic, strong) SSHTTPSessionManager *sessionManager;
@end

NS_ASSUME_NONNULL_END
