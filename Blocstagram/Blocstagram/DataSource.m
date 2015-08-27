//
//  DataSource.m
//  Blocstagram
//
//  Created by Weinan Qiu on 2015-08-25.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"

@interface DataSource () {
    NSMutableArray *_mediaItems;
}

@end

@implementation DataSource

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addRandomData];
    }
    return self;
}

- (void)addRandomData {
    NSMutableArray *randomMediaItems = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        if (image) {
            Media *media = [[Media alloc] init];

            media.image = image;
            media.user = [self randomUser];
            media.caption = [self randomSentence];
            
            NSUInteger commentCount = arc4random_uniform(10) + 2;
            NSMutableArray *randomComments = [NSMutableArray array];
            for (int j = 0; j < commentCount; j++) {
                [randomComments addObject:[self randomComment]];
            }
            media.comments = randomComments;
            
            [randomMediaItems addObject:media];
        }
    }
    
    _mediaItems = randomMediaItems;
}

- (User *)randomUser {
    User *user = [[User alloc] init];
    
    user.userName = [self randomStringOfLength:arc4random_uniform(10) + 2];
    user.fullName = [NSString stringWithFormat:@"%@ %@",
                     [self randomStringOfLength:arc4random_uniform(7) + 2],
                     [self randomStringOfLength:arc4random_uniform(12) + 2]];
    
    return user;
}

- (Comment *)randomComment {
    Comment *comment = [[Comment alloc] init];
    
    comment.from = [self randomUser];
    comment.text = [self randomSentence];
    
    return comment;
}

- (NSString *)randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *)randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}

- (void) deleteMediaItem:(Media *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}

- (void) moveToTop:(Media *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    
    [mutableArrayWithKVO removeObject:item];
    [mutableArrayWithKVO insertObject:item atIndex:0];
}

#pragma mark - Key/Value Observing

- (NSUInteger)countOfMediaItems {
    return _mediaItems.count;
}

- (id)objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

- (NSArray *)mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

- (void)insertObject:(Media *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void)removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void)replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

@end
