//
//  DataSource.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

@interface DataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *mediaItems;

+ (instancetype)sharedInstance;

- (void) deleteMediaItem:(Media *)item;

- (void) moveToTop:(Media *)item;

@end
