//
//  SSRequestClone.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSRequestClone : NSObject
+ (NSURLRequest *)cloneMockRequest:(NSURLRequest *)request;
@end

NS_ASSUME_NONNULL_END
