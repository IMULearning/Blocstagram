//
//  CropBox.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-09-07.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "CropBox.h"

@interface CropBox ()

@property (nonatomic, strong) NSArray *horizontalLines;
@property (nonatomic, strong) NSArray *verticalLines;

@end

@implementation CropBox

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        for (UIView *view in [self.horizontalLines arrayByAddingObjectsFromArray:self.verticalLines]) {
            [self addSubview:view];
        }
    }
    return self;
}

- (NSArray *) horizontalLines {
    if (!_horizontalLines) {
        _horizontalLines = [self newArrayOfFourWhiteLines];
    }
    return _horizontalLines;
}

- (NSArray *) verticalLines {
    if (!_verticalLines) {
        _verticalLines = [self newArrayOfFourWhiteLines];
    }
    return _verticalLines;
}

- (NSArray *) newArrayOfFourWhiteLines {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [array addObject:view];
    }
    
    return array;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat thirdOfWidth = width / 3;
    
    for (int i = 0; i < 4; i++) {
        UIView *horizontalLine = self.horizontalLines[i];
        UIView *verticalLine = self.verticalLines[i];
        
        horizontalLine.frame = CGRectMake(0, (i * thirdOfWidth), width, 0.5);
        
        CGRect verticalFrame = CGRectMake(i * thirdOfWidth, 0, 0.5, width);
        
        if (i == 3) {
            verticalFrame.origin.x -= 0.5;
        }
        
        verticalLine.frame = verticalFrame;
    }
}

@end
