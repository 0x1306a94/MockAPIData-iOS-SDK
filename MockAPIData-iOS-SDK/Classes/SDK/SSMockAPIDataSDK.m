//
//  SSMockAPIDataSDK.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIDataSDK.h"
#import "SSMockAPIDataSDK+Private.h"


#import "SSMockAPIBaseModel.h"
#import "SSMockAPIURLProtocol.h"

#import "SSJSONRequestSerializer.h"

#import <YYModel/YYModel.h>

@interface SSMockAPIDataSDK ()
@property (nonatomic, assign) SSMockProcessType processType;
@property (nonatomic, strong) SSMockAPICommon *common;
@property (nonatomic, strong) NSURL *host;
@property (nonatomic, strong) NSURL *mockHost;
@property (nonatomic, strong) NSURLSessionDataTask *loginTask;
@end

@implementation SSMockAPIDataSDK
+ (instancetype)shared {
    static SSMockAPIDataSDK *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[[SSMockAPIDataSDK class] alloc] init];
    });
    return __instance;
}

- (instancetype)init {
    if (self == [super init]) {
        self.common = [[SSMockAPICommon alloc] init];
    }
    return self;
}
- (void)enable {
    if (self.isEnable) return;
    self.isEnable = YES;
    [SSMockAPIURLProtocol ss_register];
}
- (void)disable {
    if (!self.isEnable) return;
    self.isEnable = NO;
    [SSMockAPIURLProtocol ss_unregister];
}

- (void)setupWithHost:(NSURL *)host mockHost:(NSURL *)mockHost processType:(SSMockProcessType)processType {
    NSParameterAssert(host);
    NSParameterAssert(mockHost);
    self.host = host;
    self.mockHost = mockHost;
    self.processType = processType;
    self.sessionManager = [[SSHTTPSessionManager alloc] initWithBaseURL:self.host];
    self.sessionManager.requestSerializer = [SSJSONRequestSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = 60.0;
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

}
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    if (!self.host || !self.mockHost) {
        @throw [NSException exceptionWithName:@"SSMockAPIDataSDK" reason:@"请使用 setupWithHost:mockHost:processType: API 初始化 SDK" userInfo:nil];
        return;
    }
    NSParameterAssert(userName.length > 0);
    NSParameterAssert(password.length > 0);
    [self.sessionManager POST:kLoginURL parameters:@{@"userName" :  userName, @"password" : password} responseCls:SSMockAPIAuthModel.class success:^(SSMockAPIAuthModel *response) {
        if (response.data.token.length > 0 && response.data.user) {
            self.authInfo = response.data;
            NSLog(@"登录成功: %@", response.data.token);
        }
    } failure:^(NSError *error) {
        NSLog(@"登录出错: %@", error);
    }];
}
@end
