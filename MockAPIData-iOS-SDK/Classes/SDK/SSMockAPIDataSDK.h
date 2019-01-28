//
//  SSMockAPIDataSDK.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>
#import "SSMockAPIAuthModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SSMockProcessType) {
    SSMockProcessTypeLocal = 0, // 从SDK拉取到本地的配置匹配
    SSMockProcessTypeServer = 1, // 服务器匹配
};


@interface SSMockAPIDataSDK : NSObject
@property (nonatomic, assign, readonly) SSMockProcessType processType;
@property (nonatomic, strong, readonly) SSMockAPIAuthModel *authInfo;
@property (nonatomic, strong, readonly) NSString *mockHost;
@property (nonatomic, assign) BOOL isEnable;
+ (instancetype)shared;

- (void)enable;
- (void)disable;
- (void)setupWithMockHost:(NSString *)mockHost processType:(SSMockProcessType)processType;
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;
@end

NS_ASSUME_NONNULL_END
