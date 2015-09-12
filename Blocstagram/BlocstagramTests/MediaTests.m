//
//  MediaTests.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-12.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Media.h"

@interface MediaTests : XCTestCase

@end

@implementation MediaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatInitializationWorks {
    NSDictionary *userDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    NSDictionary *mediaDictionary = @{
                                      @"id": @"someId",
                                      @"user": userDictionary,
                                      @"images": @{
                                              @"standard_resolution": @{
                                                      @"url": @"https://www.instagram.com/somePicture.jpeg"
                                                      }
                                              },
                                      @"caption": @{
                                              @"text": @"testCaption"
                                              },
                                      @"comments": @{
                                              @"data": @[]
                                              },
                                      @"user_has_liked": @YES
                                      };
    
    Media *media = [[Media alloc] initWithDictionary:mediaDictionary];
    
    XCTAssertEqualObjects(media.idNumber, mediaDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(media.mediaURL.absoluteString, mediaDictionary[@"images"][@"standard_resolution"][@"url"], @"The url should be equal");
    XCTAssertEqualObjects(media.caption, mediaDictionary[@"caption"][@"text"], @"The caption should be equal");
    XCTAssertEqualObjects([NSNumber numberWithInteger:media.comments.count], @0, @"The comment counts should be equal");
}

@end
