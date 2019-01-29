//
//  SSMockAPICacheManager.h
//  Pods
//
//  Created by sun on 2019/1/29.
//

#import <Foundation/Foundation.h>
#import "SSMockAPIProjectModel.h"
#import "SSMockAPIRuleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPICacheManager : NSObject

+ (instancetype)shared;
- (NSArray<SSMockAPIProjectModel *> *)getCacheProjects;
- (NSDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> *)getCacheRules;

- (void)storeProjects:(NSArray<SSMockAPIProjectModel *> *)projects;
- (void)removeRulesWithProjectKey:(NSString *)key;
- (void)storeRulesWithProjectKey:(NSString *)key rules:(NSArray<SSMockAPIRuleModel *> *)rules;

- (void)saveToDisk;
@end

NS_ASSUME_NONNULL_END
