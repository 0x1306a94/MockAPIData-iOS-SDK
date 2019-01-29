//
//  SSMockAPIRuleListModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIRuleListModel.h"

@implementation SSMockAPIRuleListModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"data" : SSMockAPIRuleModel.class};
}
@end
