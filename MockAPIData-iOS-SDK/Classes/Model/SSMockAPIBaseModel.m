//
//  SSMockAPIBaseModel.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSMockAPIBaseModel.h"

@implementation SSMockAPIBaseModel
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:NSDictionary.class]) return nil;
    SSMockAPIBaseModel *m = [[SSMockAPIBaseModel alloc] init];
    [m setValuesForKeysWithDictionary:dict];
    return m;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }
@end
