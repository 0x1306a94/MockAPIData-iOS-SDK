//
//  SSMockAPIRequestProjectsOperation.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIRequestProjectsOperation.h"
#import "SSMockAPIDataSDK+Private.h"
#import "SSMockAPICommon.h"

@interface SSMockAPIRequestProjectsOperation ()
@property (nonatomic, strong) void(^block)(NSArray<SSMockAPIProjectModel *> * _Nullable);
@end

@implementation SSMockAPIRequestProjectsOperation
- (instancetype)initWithComplete:(void (^)(NSArray<SSMockAPIProjectModel *> * _Nullable))block {
    if (self == [super init]) {
        self.block = block;
    }
    return self;
}
- (void)main {
    @try {
        @autoreleasepool {
            __weak typeof(self) weakSelf = self;
            [[SSMockAPIDataSDK shared].sessionManager GET:kProjectURL parameters:@{@"pageNo" : @1, @"pageSize" : @(INT_MAX)} responseCls:SSMockAPIProjectListModel.class success:^(SSMockAPIProjectListModel * _Nullable response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                !strongSelf.block ?: strongSelf.block(response.data);
                strongSelf.block = nil;
                [strongSelf completeOperation];
            } failure:^(NSError *error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                !strongSelf.block ?: strongSelf.block(nil);
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
