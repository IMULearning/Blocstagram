//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "Media.h"
#import "Comment.h"
#import "User.h"

@interface MediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) NSArray *commentLabelArray;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation MediaTableViewCell

#pragma mark - Load Styles

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    paragraphStyle = mutableParagraphStyle;
}

#pragma mark - Helper

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    layoutCell.media = mediaItem;
    [layoutCell layoutSubviews];
    return CGRectGetMaxY([[layoutCell.commentLabelArray lastObject] frame]);
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.mediaImageView = [[UIImageView alloc] init];

        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel]) {
            [self.contentView addSubview:view];
        }
    }
    
    return self;
}

#pragma mark - UITableCell specific

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Style

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageHeight = self.media.image.size.height / self.media.image.size.width * CGRectGetWidth(self.contentView.bounds);
    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight);
    
    CGSize sizeOfUsernameAndCaptionLabel = [self sizeOfString:self.usernameAndCaptionLabel.attributedText];
    self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.bounds), sizeOfUsernameAndCaptionLabel.height + 20);
    
    CGFloat labelY = CGRectGetMaxY(self.usernameAndCaptionLabel.frame);
    for (UILabel *commentLabel in self.commentLabelArray) {
        CGSize sizeOfCommentLabel = [self sizeOfString:commentLabel.attributedText];
        commentLabel.frame = CGRectMake(0, labelY, CGRectGetWidth(self.bounds), sizeOfCommentLabel.height);
        labelY = CGRectGetMaxY(commentLabel.frame);
    }
    
    UILabel *lastLabel = [self.commentLabelArray lastObject];
    lastLabel.frame = CGRectMake(
                                 lastLabel.frame.origin.x,
                                 lastLabel.frame.origin.y,
                                 lastLabel.frame.size.width,
                                 lastLabel.frame.size.height + 20);
    
    // Hide cell line
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

- (NSAttributedString *)usernameAndCaptionString {
    CGFloat usernameFontSize = 15;
    NSDictionary *fontAttribtues = @{
                                     NSFontAttributeName: [lightFont fontWithSize:usernameFontSize],
                                     NSParagraphStyleAttributeName: paragraphStyle,
                                     NSKernAttributeName: @2
                                     };
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.media.user.userName, self.media.caption];
    
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                                                        attributes:fontAttribtues];
    NSRange usernameRange = [baseString rangeOfString:self.media.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName
                                            value:[boldFont fontWithSize:usernameFontSize]
                                            range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName
                                            value:linkColor
                                            range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

- (NSAttributedString *)commentString: (Comment *) comment {
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", comment.from.userName, comment.text];
    NSMutableDictionary *fontAttribtues = [@{
                                             NSFontAttributeName: lightFont,
                                             NSParagraphStyleAttributeName: paragraphStyle
                                             } mutableCopy];
    
    if ([self.media.comments indexOfObject:comment] == 0) {
        [fontAttribtues setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    }
    
    NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                                         attributes:fontAttribtues];
    NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
    [oneCommentString addAttribute:NSFontAttributeName
                             value:boldFont
                             range:usernameRange];
    [oneCommentString addAttribute:NSForegroundColorAttributeName
                             value:linkColor
                             range:usernameRange];
    
    return oneCommentString;
}

- (CGSize)sizeOfString: (NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40.0, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    sizeRect = CGRectIntegral(sizeRect);
    
    return sizeRect.size;
}

#pragma mark - Content

- (void)setMedia:(Media *)media {
    _media = media;
    self.mediaImageView.image = _media.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    
    NSMutableArray *mutableCommentLabelArray = [NSMutableArray array];

    for (int i = 0; i < _media.comments.count; i++) {
        Comment *comment = _media.comments[i];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.backgroundColor = commentLabelGray;
        label.attributedText = [self commentString:comment];
        label.textAlignment = (i % 2 == 0) ? NSTextAlignmentRight : NSTextAlignmentLeft;
        [mutableCommentLabelArray addObject:label];
        [self.contentView addSubview:label];
    }
    _commentLabelArray = mutableCommentLabelArray;
}

@end
