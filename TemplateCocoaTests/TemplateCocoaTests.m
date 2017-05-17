//
//  TemplateCocoaTests.m
//  TemplateCocoaTests
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <XCTest/XCTest.h>

//
#import "GCDUtil.h"

// 接口
#import "Login_Post.h"

@interface TemplateCocoaTests : XCTestCase

@end

@implementation TemplateCocoaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testLoginApi {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Login_Post *loginApi = [[Login_Post alloc] initWithAccount:@"18668089860" password:@"123456"];
        [loginApi call];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(NO, @"sdsd");
        });
    });
    
}

@end
