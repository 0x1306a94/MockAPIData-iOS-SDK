//
//  SSMockAPIRequestRulesOperation.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIRequestRulesOperation.h"
#import "SSMockAPIDataSDK+Private.h"
#import "SSMockAPICommon.h"

@interface SSMockAPIRequestRulesOperation ()
@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, strong) NSString *projectKey;
@property (nonatomic, strong) void(^block)(NSInteger projectId, NSString *projectKey, NSArray<SSMockAPIRuleModel *> * _Nullable);
@end

@implementation SSMockAPIRequestRulesOperation
- (instancetype)initWithProjectId:(NSInteger)projectId projectKey:(NSString *)projectKey complete:(void(^)(NSInteger projectId, NSString *projectKey, NSArray<SSMockAPIRuleModel *> * _Nullable rules))block {
    if (self == [super init]) {
        self.projectId = projectId;
        self.projectKey = projectKey;
        self.block = block;
    }
    return self;
}
- (void)main {
    @try {
        @autoreleasepool {
            __weak typeof(self) weakSelf = self;
            [[SSMockAPIDataSDK shared].sessionManager GET:kRuleURL parameters:@{@"pageNo" : @1, @"pageSize" : @(INT_MAX), @"projectId" : @(self.projectId)} responseCls:SSMockAPIRuleListModel.class success:^(SSMockAPIRuleListModel * _Nullable response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                !strongSelf.block ?: strongSelf.block(strongSelf.projectId, strongSelf.projectKey, response.data);
                strongSelf.block = nil;
                [strongSelf completeOperation];
            } failure:^(NSError *error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                !strongSelf.block ?: strongSelf.block(strongSelf.projectId, strongSelf.projectKey, nil);
                strongSelf.block = nil;
                [strongSelf completeOperation];
            }];
        }
    } @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    } @finally {

    }
}
@end
