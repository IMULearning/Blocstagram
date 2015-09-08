//
//  CropImageViewController.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-07.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "CropImageViewController.h"
#import "CropBox.h"
#import "Media.h"
#import "UIImage+ImageUtilities.h"

@interface CropImageViewController ()

@property (nonatomic, strong) CropBox *cropBox;
@property (nonatomic, assign) BOOL hasLoadedOnce;

@property (nonatomic, strong) UIToolbar *topView;
@property (nonatomic, strong) UIToolbar *bottomView;

@end

@implementation CropImageViewController

- (instancetype) initWithImage:(UIImage *)sourceImage {
    self = [super init];
    if (self) {
        self.media = [[Media alloc] init];
        self.media.image = sourceImage;
        
        self.cropBox = [CropBox new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.cropBox];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Crop", @"Crop command")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(cropPressed:)];
    self.navigationItem.title = NSLocalizedString(@"Crop Image", nil);
    self.navigationItem.rightBarButtonItem = rightButton;

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    self.topView = [UIToolbar new];
    self.bottomView = [UIToolbar new];
    UIColor *whiteBG = [UIColor colorWithWhite:1.0 alpha:.15];
    self.topView.barTintColor = whiteBG;
    self.bottomView.barTintColor = whiteBG;
    self.topView.alpha = 0.5;
    self.bottomView.alpha = 0.5;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect cropRect = CGRectZero;
    
    CGFloat edigeSize = MIN(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    cropRect.size = CGSizeMake(edigeSize, edigeSize);
    
    CGSize size = self.view.frame.size;
    
    self.cropBox.frame = cropRect;
    self.cropBox.center = CGPointMake(size.width / 2, size.height / 2);
    self.scrollView.frame = self.cropBox.frame;
    self.scrollView.clipsToBounds = NO;
    
    [self recalculateZoomScale];
    
    if (self.hasLoadedOnce == NO) {
        self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
        self.hasLoadedOnce = YES;
    }
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    self.topView.frame = CGRectMake(0, 0, width, CGRectGetMinY(self.cropBox.frame));
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.cropBox.frame), width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.cropBox.frame));
}

#pragma mark - Button Target

- (void) cropPressed:(UIBarButtonItem *)sender {
    CGRect visibleRect;
    float scale = 1.0f / self.scrollView.zoomScale / self.media.image.scale;
    visibleRect.origin.x = self.scrollView.contentOffset.x * scale;
    visibleRect.origin.y = self.scrollView.contentOffset.y * scale;
    visibleRect.size.width = self.scrollView.bounds.size.width * scale;
    visibleRect.size.height = self.scrollView.bounds.size.height * scale;
    
    UIImage *scrollViewCrop = [self.media.image imageWithFixOrientation];
    scrollViewCrop = [scrollViewCrop imageCroppedToRect:visibleRect];
    
    [self.delegate cropControllerFinishedWithImage:scrollViewCrop];
}

@end
