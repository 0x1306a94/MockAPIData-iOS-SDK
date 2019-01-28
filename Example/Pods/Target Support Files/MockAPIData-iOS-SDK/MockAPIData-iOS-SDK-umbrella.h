#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SSMockAPIAuthModel.h"
#import "SSMockAPIBaseModel.h"
#import "SSMockAPIProjectModel.h"
#import "SSMockAPIUserModel.h"
#import "SSRequestClone.h"
#import "SSMockAPIDataSDK.h"
#import "SSMockAPIURLProtocol.h"
#import "SSURLSessionConfiguration.h"

FOUNDATION_EXPORT double MockAPIData_iOS_SDKVersionNumber;
FOUNDATION_EXPORT const unsigned char MockAPIData_iOS_SDKVersionString[];

