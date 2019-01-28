//
//  SSViewController.m
//  MockAPIData-iOS-SDK
//
//  Created by king129 on 01/28/2019.
//  Copyright (c) 2019 king129. All rights reserved.
//

#import "SSViewController.h"

@import AFNetworking;
@import MockAPIData_iOS_SDK;

@interface SSViewController ()

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[SSMockAPIDataSDK shared] setupWithMockHost:@"http://127.0.0.1:9999" processType:SSMockProcessTypeServer];
    [[SSMockAPIDataSDK shared] enable];
    [[SSMockAPIDataSDK shared] loginWithUserName:@"0x1306a94" password:@"123456"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSDictionary *parameters = @{
                                 @"pageNo" : @1,
                                 @"pageSize" : @10,
                                 @"cityId": @28,
                                 @"showTime": @7,
                                 @"appVersion" : @"4.3.0",
                                 @"sortType" : @1,
                                 @"terminal" : @"ios",
                                 @"uid": @"FAE1A000A3414624AB73D5CC064548441546927368",
                                 @"sysVersion": @"12.1",
                                 @"sign" : @"5b436dc9d17dcf2148297fa20f6c7b93",
                                 };
    [[AFHTTPSessionManager manager] GET:@"http://127.0.0.1:9999/xxx" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
