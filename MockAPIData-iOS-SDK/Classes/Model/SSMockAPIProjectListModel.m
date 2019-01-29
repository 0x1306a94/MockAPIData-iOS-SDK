//
//  SSMockAPIProjectListModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIProjectListModel.h"

@implementation SSMockAPIProjectListModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"data" : SSMockAPIProjectModel.class};
}
@end
