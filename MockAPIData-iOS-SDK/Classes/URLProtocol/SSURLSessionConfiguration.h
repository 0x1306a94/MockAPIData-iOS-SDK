//
//  SSURLSessionConfiguration.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSURLSessionConfiguration : NSObject
+ (instancetype)defaultConfiguration;
- (void)ss_register;
- (void)ss_unregister;
@end

NS_ASSUME_NONNULL_END
