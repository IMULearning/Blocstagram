//
//  DataSource.h
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *mediaItems;

+ (instancetype)sharedInstance;

@end
