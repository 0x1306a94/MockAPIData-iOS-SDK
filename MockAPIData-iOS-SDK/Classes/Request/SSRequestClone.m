//
//  SSRequestClone.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSRequestClone.h"
#import "SSMockAPIDataSDK.h"

@implementation SSRequestClone
+ (NSURLRequest *)cloneMockRequest:(NSURLRequest *)request {
    NSMutableURLRequest *newReq = [request mutableCopy];
    if ([SSMockAPIDataSDK shared].processType == SSMockProcessTypeLocal) {
        [newReq setValue:@"" forHTTPHeaderField:@"Mock-Token"];
    } else if ([SSMockAPIDataSDK shared].processType == SSMockProcessTypeServer) {
        [newReq setValue:@"52562ecc5e20082cdfa02176c1578156" forHTTPHeaderField:@"Mock-Project-Key"];
    }
    return newReq;
}
@end
