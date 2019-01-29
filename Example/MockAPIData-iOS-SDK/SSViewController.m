//
//  SSViewController.m
//  MockAPIData-iOS-SDK
//
//  Created by king129 on 01/28/2019.
//  Copyright (c) 2019 king129. All rights reserved.
//

#import "SSViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MockAPIData-iOS-SDK/SSMockAPIDataSDK.h>

//@import AFNetworking;
//@import MockAPIData_iOS_SDK;

@interface SSViewController ()

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[SSMockAPIDataSDK shared] setupWithHost:[NSURL URLWithString:@"http://127.0.0.1:9999"] mockHost:[NSURL URLWithString:@"http://127.0.0.1:8888"] processType:SSMockProcessTypeServer];
    [[SSMockAPIDataSDK shared] enable];
    [[SSMockAPIDataSDK shared] loginWithUserName:@"0x1306a94" password:@"123456"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[AFHTTPSessionManager manager] GET:@"http://httpbin.org/headers" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
