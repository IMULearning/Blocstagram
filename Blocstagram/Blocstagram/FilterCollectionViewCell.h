//
//  FilterCollectionViewCell.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-09.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSInteger imageViewTag = 1000;
static const NSInteger labelTag = 1001;

@interface FilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat edigeSize;

@end
