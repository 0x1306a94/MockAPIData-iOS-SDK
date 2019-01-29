//
//  SSMockAPIAuthModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>
#import "SSMockAPIUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SSMockAPIAuthInfoModel;

@interface SSMockAPIAuthModel : NSObject
@property (nonatomic, strong) SSMockAPIAuthInfoModel *data;
@end

@interface SSMockAPIAuthInfoModel : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) SSMockAPIUserModel *user;
@end



NS_ASSUME_NONNULL_END
