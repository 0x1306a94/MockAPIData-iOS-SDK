//
//  SSMockAPIProjectModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIProjectModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) BOOL insecureSkipVerify;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *updateAt;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
