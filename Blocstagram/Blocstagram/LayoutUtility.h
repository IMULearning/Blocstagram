//
//  LayoutUtility.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-26.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LayoutUtility : NSObject

+ (CGSize)sizeOfString: (NSAttributedString *)attributedString
           forMaxWidth: (CGFloat) maxWidth
      andBottomPadding: (CGFloat) bottomPadding;

@end
