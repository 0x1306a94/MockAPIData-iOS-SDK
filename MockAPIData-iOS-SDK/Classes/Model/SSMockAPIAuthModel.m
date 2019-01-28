//
//  SSMockAPIAuthModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIAuthModel.h"

@implementation SSMockAPIAuthModel
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:NSDictionary.class]) return nil;
    SSMockAPIAuthModel *m = [[SSMockAPIAuthModel alloc] init];
    [m setValuesForKeysWithDictionary:dict];
    return m;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:NSStringFromSelector(@selector(user))]) {
        if ([value isKindOfClass:NSDictionary.class]) {
            self.user = [SSMockAPIUserModel modelWithDictionary:value];
        }
        return;
    }
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }
@end
