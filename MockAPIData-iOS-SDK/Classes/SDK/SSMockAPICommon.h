//
//  SSMockAPICommon.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN const NSNotificationName kSSRnotificationSyncCompleteEvent;
FOUNDATION_EXTERN const NSNotificationName kSSRnotificationMotionEvent;


FOUNDATION_EXTERN const NSString *kLoginURL;
FOUNDATION_EXTERN const NSString *kProjectURL;
FOUNDATION_EXTERN const NSString *kRuleURL;


@interface SSMockAPICommon : NSObject
@property (nonatomic, assign) BOOL shouldSyncWithShake;
@end

NS_ASSUME_NONNULL_END
