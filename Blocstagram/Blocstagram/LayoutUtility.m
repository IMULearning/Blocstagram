//
//  LayoutUtility.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "LayoutUtility.h"

@implementation LayoutUtility

+ (CGSize)sizeOfString: (NSAttributedString *)attributedString
           forMaxWidth: (CGFloat) maxWidth
      andBottomPadding: (CGFloat) bottomPadding{
    CGSize maxSize = CGSizeMake(maxWidth, 0.0);
    CGRect sizeRect = [attributedString boundingRectWithSize:maxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    
    sizeRect.size.height += bottomPadding;
    sizeRect = CGRectIntegral(sizeRect);
    
    return sizeRect.size;
}

@end
