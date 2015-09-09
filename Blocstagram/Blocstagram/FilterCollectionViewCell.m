//
//  FilterCollectionViewCell.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-09.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UIImageView *)thumbnail {
    if (!_thumbnail) {
        _thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _edigeSize, _edigeSize)];
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.tag = imageViewTag;
        _thumbnail.clipsToBounds = YES;
        [self.contentView addSubview:_thumbnail];
    }
    return _thumbnail;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, _edigeSize, _edigeSize, 20)];
        _label.textAlignment = UITextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        _label.tag = labelTag;
        [self.contentView addSubview:_label];
    }
    return _label;
}

@end
