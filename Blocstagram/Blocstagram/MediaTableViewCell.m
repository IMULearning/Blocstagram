//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "MediaCommentsView.h"
#import "Media.h"
#import "Comment.h"
#import "User.h"
#import "StyleBootstrap.h"
#import "LayoutUtility.h"

@interface MediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) MediaCommentsView *commentsView;

@end

@implementation MediaTableViewCell

#pragma mark - Helper

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"layoutCell"];
    layoutCell.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    layoutCell.media = mediaItem;
    [layoutCell layoutSubviews];
    return CGRectGetMaxY(layoutCell.commentsView.frame);
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.mediaImageView = [[UIImageView alloc] init];

        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = [StyleBootstrap sharedInstance].usernameLabelGray;
        
        self.commentsView = [[MediaCommentsView alloc] init];
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentsView]) {
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
    self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.bounds), sizeOfUsernameAndCaptionLabel.height);
    
    CGFloat commentsHeight = [MediaCommentsView heightForComments:self.media.comments width:CGRectGetWidth(self.bounds)] + 20;
    self.commentsView.frame = CGRectMake(0, CGRectGetMaxY(self.usernameAndCaptionLabel.frame), CGRectGetWidth(self.bounds), commentsHeight);
    
    // Hide cell line
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

- (NSAttributedString *)usernameAndCaptionString {
    CGFloat usernameFontSize = 15;
    NSDictionary *fontAttribtues = @{
                                     NSFontAttributeName: [[StyleBootstrap sharedInstance].lightFont fontWithSize:usernameFontSize],
                                     NSParagraphStyleAttributeName: [StyleBootstrap sharedInstance].paragraphStyle
                                     };
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.media.user.userName, self.media.caption];
    
    
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString
                                                                                                        attributes:fontAttribtues];
    NSRange usernameRange = [baseString rangeOfString:self.media.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName
                                            value:[[StyleBootstrap sharedInstance].boldFont fontWithSize:usernameFontSize]
                                            range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName
                                            value:[StyleBootstrap sharedInstance].linkColor
                                            range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

- (CGSize)sizeOfString: (NSAttributedString *)string {
    return [LayoutUtility sizeOfString:string
                           forMaxWidth:CGRectGetWidth(self.contentView.bounds) - 40.0
                      andBottomPadding:20];
}

#pragma mark - Content

- (void)setMedia:(Media *)media {
    _media = media;
    self.mediaImageView.image = _media.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentsView.comments = _media.comments;
}

@end
