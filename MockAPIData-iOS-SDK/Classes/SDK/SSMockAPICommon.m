//
//  SSMockAPICommon.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPICommon.h"

const NSNotificationName kSSRnotificationSyncCompleteEvent = @"kSSRnotificationSyncCompleteEvent";
const NSNotificationName kSSRnotificationMotionEvent = @"kSSRnotificationMotionEvent";

const NSString *kLoginURL = @"login";
const NSString *kProjectURL = @"admin/project/list";
const NSString *kRuleURL = @"admin/rule/list";

@implementation SSMockAPICommon

- (BOOL)shouldSyncWithShake {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldSyncWithShake"];
}
- (void)setShouldSyncWithShake:(BOOL)shouldSyncWithShake {
    [[NSUserDefaults standardUserDefaults] setBool:shouldSyncWithShake forKey:@"shouldSyncWithShake"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
