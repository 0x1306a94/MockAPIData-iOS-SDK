//
//  SSMockAPIUserModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIUserModel.h"

@implementation SSMockAPIUserModel
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:NSDictionary.class]) return nil;
    SSMockAPIUserModel *m = [[SSMockAPIUserModel alloc] init];
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
    if ([key isEqualToString:NSStringFromSelector(@selector(admin))]) {
        if ([value respondsToSelector:@selector(boolValue)]) {
            self.admin = [value boolValue];
        }
        return;
    }
    if ([key isEqualToString:NSStringFromSelector(@selector(management))]) {
        if ([value respondsToSelector:@selector(boolValue)]) {
            self.management = [value boolValue];
        }
        return;
    }
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }
@end
