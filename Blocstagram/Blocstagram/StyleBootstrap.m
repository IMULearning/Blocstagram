//
//  StyleBootstrap.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "StyleBootstrap.h"

@interface StyleBootstrap ()

@property (nonatomic, strong) UIFont *lightFont;
@property (nonatomic, strong) UIFont *boldFont;
@property (nonatomic, strong) UIColor *usernameLabelGray;
@property (nonatomic, strong) UIColor *commentLabelGray;
@property (nonatomic, strong) UIColor *linkColor;
@property (nonatomic, strong) NSParagraphStyle *paragraphStyle;

@end

@implementation StyleBootstrap

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
        self.boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
        self.usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
        self.commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
        self.linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
        
        NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        mutableParagraphStyle.headIndent = 20.0;
        mutableParagraphStyle.firstLineHeadIndent = 20.0;
        mutableParagraphStyle.tailIndent = -20.0;
        mutableParagraphStyle.paragraphSpacingBefore = 5;
        self.paragraphStyle = mutableParagraphStyle;
    }
    return self;
}

@end
