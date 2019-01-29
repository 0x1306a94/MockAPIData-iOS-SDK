//
//  UIApplication+SSMock.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/29.
//

#import "UIApplication+SSMock.h"
#import "SSMockAPICommon.h"
#import "SSMockAPIDataSDK.h"

#import <objc/runtime.h>


void swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}


@implementation UIApplication (SSMock)
+ (void)initialize {
    swizzle([UIApplication class], @selector(sendEvent:), @selector(ss_SendEvent:));
}

- (void)ss_SendEvent:(UIEvent *)event {
#warning 便于测试 故而写死
    BOOL shouldSyncWithShake = YES;//[SSMockAPIDataSDK shared].common.shouldSyncWithShake;
    if (shouldSyncWithShake == YES) {
        if (event.type == UIEventTypeMotion) {
            int result = [event valueForKey:@"_shakeState"] != nil ? [[event valueForKey:@"_shakeState"] intValue]: 0;
            if (result == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kSSRnotificationMotionEvent object:nil];
            }
        }
    }
    [self ss_SendEvent:event];
}
@end
