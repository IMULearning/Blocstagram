//
//  CameraToolbar.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-07.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraToolbar;

@protocol CameraToolbarDelegate <NSObject>

- (void) leftButtonPressedOnToolbar:(CameraToolbar *)toolbar;
- (void) rightButtonPressedOnToolbar:(CameraToolbar *)toolbar;
- (void) cameraButtonPressedOnToolbar:(CameraToolbar *)toolbar;

@end

@interface CameraToolbar : UIView

@property (nonatomic, weak) id <CameraToolbarDelegate> delegate;

- (instancetype) initWithImageNames:(NSArray *)imageNames;

@end
