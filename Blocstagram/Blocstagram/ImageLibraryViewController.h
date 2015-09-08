//
//  ImageLibraryViewController.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-07.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageLibraryViewController;

@protocol ImageLibraryViewControllerDelegate <NSObject>

- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image;

@end

@interface ImageLibraryViewController : UICollectionViewController

@property (nonatomic, weak) id <ImageLibraryViewControllerDelegate> delegate;

@end
