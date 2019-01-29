//
//  SSMockAPIRuleModel.h
//  Pods
//
//  Created by sun on 2019/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIRuleModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updateAt;
@end

NS_ASSUME_NONNULL_END
