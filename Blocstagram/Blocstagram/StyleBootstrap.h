//
//  StyleBootstrap.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StyleBootstrap : NSObject

@property (nonatomic, strong, readonly) UIFont *lightFont;
@property (nonatomic, strong, readonly) UIFont *boldFont;
@property (nonatomic, strong, readonly) UIColor *usernameLabelGray;
@property (nonatomic, strong, readonly) UIColor *commentLabelGray;
@property (nonatomic, strong, readonly) UIColor *linkColor;
@property (nonatomic, strong, readonly) NSParagraphStyle *paragraphStyle;

+ (instancetype)sharedInstance;

@end
