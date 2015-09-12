//
//  ComposeCommentViewTests.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-12.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ComposeCommentView.h"

@interface ComposeCommentViewTests : XCTestCase

@property (nonatomic, strong) ComposeCommentView *view;

@end

@implementation ComposeCommentViewTests

- (void)setUp {
    [super setUp];
    self.view = [ComposeCommentView new];
}

- (void)tearDown {
    self.view = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) testWritingCommentIsYesWhenThereIsText {
    [self.view setText:@"someText"];
    XCTAssertTrue(self.view.isWritingComment);
}

- (void) testWritingCommentIsNoWhenThereIsNoText {
    [self.view setText:nil];
    XCTAssertFalse(self.view.isWritingComment);
}

@end
