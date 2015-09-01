//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell;

@protocol MediaTableViewCellDelegate <NSObject>

- (void)cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

@end

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *media;
@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end
