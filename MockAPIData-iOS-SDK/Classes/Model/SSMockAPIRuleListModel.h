//
//  SSMockAPIRuleListModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIBaseModel.h"
#import "SSMockAPIRuleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIRuleListModel : SSMockAPIBaseModel
@property (nonatomic, strong) NSArray<SSMockAPIRuleModel *> *data;
@end

NS_ASSUME_NONNULL_END
