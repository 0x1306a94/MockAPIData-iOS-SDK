//
//  SSRequestClone.m
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import "SSRequestClone.h"
#import "SSMockAPIDataSDK+Private.h"
#import "SSMockAPICacheManager.h"

@implementation SSRequestClone
+ (NSURLRequest *)cloneMockRequest:(NSURLRequest *)request {
    NSArray<SSMockAPIProjectModel *> *projects = [[SSMockAPICacheManager shared] getCacheProjects];
    if (!projects || projects.count == 0) return request;
    SSMockAPIProjectModel *matchProject = nil;
    for (SSMockAPIProjectModel *p in projects) {
        if ([request.URL.absoluteString containsString:p.host] && p.enable) {
            matchProject = p;
            break;
        }
    }
    if (!matchProject || matchProject.key.length == 0) return request;

    NSMutableURLRequest *newReq = nil;
    if ([request isKindOfClass:NSMutableURLRequest.class]) {
        newReq = (NSMutableURLRequest *)request;
    } else {
        newReq = [request mutableCopy];
    }
    NSURLComponents *compnents = [NSURLComponents componentsWithString:request.URL.absoluteString];

    if ([SSMockAPIDataSDK shared].processType == SSMockProcessTypeLocal) {
        NSDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> *ruleMaps = [[SSMockAPICacheManager shared] getCacheRules];
        if (!ruleMaps || !ruleMaps[matchProject.key]) return request;
        NSArray<SSMockAPIRuleModel *> *rules = ruleMaps[matchProject.key];
        SSMockAPIRuleModel *rule = nil;
        for (SSMockAPIRuleModel *r in rules) {
            if ([request.HTTPMethod isEqualToString:r.method] && [request.URL.path isEqualToString:r.path] && r.enable) {
                rule = r;
                break;
            }
        }
        if (!rule) return request;
        compnents.host = [SSMockAPIDataSDK shared].mockHost.host;
        compnents.scheme = [SSMockAPIDataSDK shared].mockHost.scheme;
        compnents.port = [SSMockAPIDataSDK shared].mockHost.port;
        compnents.path = [NSString stringWithFormat:@"/mock/%ld/%ld", rule.projectId, rule.id];
        newReq.URL = compnents.URL;
        if ([SSMockAPIDataSDK shared].authInfo.token .length > 0) {
            [newReq setValue:[SSMockAPIDataSDK shared].authInfo.token forHTTPHeaderField:@"Mock-Token"];
        }
    } else if ([SSMockAPIDataSDK shared].processType == SSMockProcessTypeServer) {
        compnents.host = [SSMockAPIDataSDK shared].mockHost.host;
        compnents.scheme = [SSMockAPIDataSDK shared].mockHost.scheme;
        compnents.port = [SSMockAPIDataSDK shared].mockHost.port;
        newReq.URL = compnents.URL;
        if ([SSMockAPIDataSDK shared].authInfo.token .length > 0) {
            [newReq setValue:[SSMockAPIDataSDK shared].authInfo.token forHTTPHeaderField:@"Mock-Token"];
        }
        [newReq setValue:matchProject.key forHTTPHeaderField:@"Mock-Project-Key"];
    }
    return newReq;
}
@end
