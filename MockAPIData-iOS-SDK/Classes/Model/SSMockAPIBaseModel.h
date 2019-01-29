//
//  SSMockAPIBaseModel.h
//  MockAPIData-iOS-SDK
//
//  Created by sun on 2019/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMockAPIBaseModel : NSObject
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) id data;

@end

NS_ASSUME_NONNULL_END
