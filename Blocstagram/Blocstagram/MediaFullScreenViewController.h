//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-01.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) Media *media;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype)initWithMedia:(Media *)media;

- (void)centerScrollView;

- (void) recalculateZoomScale;

@end
