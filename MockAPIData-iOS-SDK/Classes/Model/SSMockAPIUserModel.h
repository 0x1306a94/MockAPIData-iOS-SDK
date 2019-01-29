//
//  SSMockAPIUserModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIUserModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL admin;
@property (nonatomic, assign) BOOL management;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updateAt;
@end

NS_ASSUME_NONNULL_END
