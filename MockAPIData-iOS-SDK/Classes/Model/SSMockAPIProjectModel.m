//
//  SSMockAPIProjectModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIProjectModel.h"

@implementation SSMockAPIProjectModel
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:NSDictionary.class]) return nil;
    SSMockAPIProjectModel *m = [[SSMockAPIProjectModel alloc] init];
    [m setValuesForKeysWithDictionary:dict];
    return m;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:NSStringFromSelector(@selector(id))]) {
        if ([value respondsToSelector:@selector(integerValue)]) {
            self.id = [value integerValue];
        }
        return;
    }
    if ([key isEqualToString:NSStringFromSelector(@selector(userId))]) {
        if ([value respondsToSelector:@selector(integerValue)]) {
            self.userId = [value integerValue];
        }
        return;
    }
    if ([key isEqualToString:NSStringFromSelector(@selector(insecureSkipVerify))]) {
        if ([value respondsToSelector:@selector(boolValue)]) {
            self.insecureSkipVerify = [value boolValue];
        }
        return;
    }
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }
@end
