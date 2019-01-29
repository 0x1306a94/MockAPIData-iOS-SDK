//
//  SSMockAPIProjectListModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPIBaseModel.h"
#import "SSMockAPIProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIProjectListModel : SSMockAPIBaseModel
@property (nonatomic, strong) NSArray<SSMockAPIProjectModel *> *data;
@end

NS_ASSUME_NONNULL_END
