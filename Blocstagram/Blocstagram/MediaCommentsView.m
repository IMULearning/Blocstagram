//
//  MediaCommentsView.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MediaCommentsView.h"
#import "StyleBootstrap.h"
#import "LayoutUtility.h"
#import "User.h"
#import "Comment.h"

@interface MediaCommentsView ()

@property (nonatomic, strong) NSArray *commentLabels;

@end

@implementation MediaCommentsView

+ (CGFloat) heightForComments:(NSArray *)comments width:(CGFloat)width {
    MediaCommentsView *view = [[MediaCommentsView alloc] init];
    view.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    view.comments = comments;
    [view layoutSubviews];
    return CGRectGetMaxY([[view.commentLabels lastObject] frame]);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"Called!");
    
    CGFloat y = 0;
    for (UILabel *label in self.commentLabels) {
        CGSize labelSize = [self sizeOfString:label.attributedText];
        label.frame = CGRectMake(0, y, CGRectGetWidth(self.bounds), labelSize.height);
        y = CGRectGetMaxY(label.frame);
    }
}

- (void)setComments:(NSArray *)comments {
    _comments = comments;
    NSMutableArray *mutableCommentLabels = [@[] mutableCopy];
    for (Comment *comment in comments) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.backgroundColor = [StyleBootstrap sharedInstance].commentLabelGray;
        label.attributedText = [self attributedStringForComment:comment];
        [self addSubview:label];
        [mutableCommentLabels addObject:label];
    }
    _commentLabels = mutableCommentLabels;
}

- (NSAttributedString *) attributedStringForComment: (Comment *) comment{
    NSDictionary *fontAttributes = @{NSFontAttributeName: [StyleBootstrap sharedInstance].lightFont,
                                     NSParagraphStyleAttributeName: [StyleBootstrap sharedInstance].paragraphStyle};
    NSString *commentText = [NSString stringWithFormat:@"%@ %@", comment.from.userName, comment.text];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:commentText attributes:fontAttributes];
    NSRange usernameRange = [commentText rangeOfString:comment.from.userName];
    [result addAttribute:NSFontAttributeName
                   value:[StyleBootstrap sharedInstance].boldFont
                   range:usernameRange];
    [result addAttribute:NSForegroundColorAttributeName
                   value:[StyleBootstrap sharedInstance].linkColor
                   range:usernameRange];
    
    return result;
}

- (CGSize)sizeOfString: (NSAttributedString *)string {
    return [LayoutUtility sizeOfString:string
                           forMaxWidth:CGRectGetWidth(self.bounds)
                      andBottomPadding:20];
}

@end
