//
//  MediaTableViewCellTests.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-12.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Media.h"
#import "User.h"
#import "MediaTableViewCell.h"
#import "ComposeCommentView.h"

@interface MediaTableViewCellTests : XCTestCase

@property (nonatomic, strong) Media *media;

@end

@implementation MediaTableViewCellTests

- (void)setUp {
    [super setUp];

    self.media = [Media new];
    self.media.image = [UIImage imageNamed:@"1.jpg"];
    
    User *user = [User new];
    user.userName = @"testUser";
    self.media.user = user;
    
    self.media.caption = @"testCaption";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testMediaImageIsNotNull {
    XCTAssertNotNil(self.media.image);
}

- (void) testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationForiPhone5Before {
    [self testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationWithWidth:320];
}

- (void) testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationForiPhone6After {
    [self testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationWithWidth:375];
}

- (void) testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationForiPad {
    [self testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationWithWidth:768];
}

- (void) testMediaImageViewCellHeightCalculationEqualsViewCellLifecycleCalculationWithWidth: (CGFloat)width {
    CGFloat height = [MediaTableViewCell heightForMediaItem:self.media width:width traitCollection:nil];
    
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"layoutCell"];
    layoutCell.media = self.media;
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    XCTAssertEqualObjects(@(height), @(CGRectGetHeight(layoutCell.mediaImageView.frame) + CGRectGetHeight(layoutCell.usernameAndCaptionLabel.frame) + CGRectGetHeight(layoutCell.commentLabel.frame) + CGRectGetHeight(layoutCell.commentView.frame)));
}

@end
