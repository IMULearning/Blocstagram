//
//  CropImageViewController.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-07.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MediaFullScreenViewController.h"

@class CropImageViewController;

@protocol CropImageViewControllerDelegate <NSObject>

- (void) cropControllerFinishedWithImage:(UIImage *)croppedImage;

@end

@interface CropImageViewController : MediaFullScreenViewController

- (instancetype) initWithImage:(UIImage *)sourceImage;

@property (nonatomic, weak) id <CropImageViewControllerDelegate> delegate;

@end
