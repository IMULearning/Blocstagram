//
//  MediaCommentsView.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface MediaCommentsView : UIView

@property (nonatomic, strong) NSArray *comments;

+ (CGFloat) heightForComments:(NSArray *)comments width:(CGFloat)width;

@end
