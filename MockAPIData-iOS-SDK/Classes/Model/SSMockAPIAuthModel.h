//
//  SSMockAPIAuthModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>
#import "SSMockAPIUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIAuthModel : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) SSMockAPIUserModel *user;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
