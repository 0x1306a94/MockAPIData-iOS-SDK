//
//  SSMockAPIRequestProjectsOperation.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIRequestOperation.h"
#import "SSMockAPIProjectListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIRequestProjectsOperation : SSMockAPIRequestOperation
- (instancetype)initWithComplete:(void(^)(NSArray<SSMockAPIProjectModel *> * _Nullable projects))block;
@end

NS_ASSUME_NONNULL_END
