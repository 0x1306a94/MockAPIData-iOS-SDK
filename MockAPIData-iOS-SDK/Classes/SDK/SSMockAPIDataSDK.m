//
//  SSMockAPIDataSDK.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIDataSDK.h"
#import "SSMockAPIBaseModel.h"
#import "SSMockAPIURLProtocol.h"

@interface SSMockAPIDataSDK ()
@property (nonatomic, assign) SSMockProcessType processType;
@property (nonatomic, strong) SSMockAPIAuthModel *authInfo;
@property (nonatomic, strong) NSString *mockHost;

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

- (void)setupWithMockHost:(NSString *)mockHost processType:(SSMockProcessType)processType {
    self.mockHost = mockHost;
    self.processType = processType;

}
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    if (self.mockHost.length == 0) {
        @throw [NSException exceptionWithName:@"SSMockAPIDataSDK" reason:@"请使用 setupWithMockHost:processType: API 初始化 SDK" userInfo:nil];
        return;
    }
    NSParameterAssert(userName);
    NSParameterAssert(password);
    NSURL *baseURL = [NSURL URLWithString:self.mockHost];
    NSURL *url = [baseURL URLByAppendingPathComponent:@"login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = @{@"userName" :  userName, @"password" : password};
    NSError *error = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];

    self.loginTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"登录出错: %@", error);
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            SSMockAPIBaseModel *result = [SSMockAPIBaseModel modelWithDictionary:dict];
            if (result && result.state == 1 && result.errorCode == 0) {
                SSMockAPIAuthModel *auth = [SSMockAPIAuthModel modelWithDictionary:result.data];
                if (auth.token.length > 0 && auth.user) {
                    self.authInfo = auth;
                    NSLog(@"登录成功: %@", result.data);
                }
            } else {
                NSLog(@"登录出错: errorCode: %ld, errorMsg: %@", result.errorCode, result.errorMsg);
            }
        }
        self.loginTask = nil;
    }];
    [self.loginTask resume];
}
@end
