//
//  SSMockAPIRequestRulesOperation.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIRequestOperation.h"
#import "SSMockAPIRuleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIRequestRulesOperation : SSMockAPIRequestOperation
- (instancetype)initWithProjectId:(NSInteger)projectId projectKey:(NSString *)projectKey complete:(void(^)(NSInteger projectId, NSString *projectKey, NSArray<SSMockAPIRuleModel *> * _Nullable rules))block;
@end

NS_ASSUME_NONNULL_END
