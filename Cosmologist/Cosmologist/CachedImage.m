//
//  CachedImage.m
//  Cosmologist
//
//  Created by Ethan Hess on 3/9/17.
//  Copyright © 2017 Ethan Hess. All rights reserved.
//

#import "CachedImage.h"

@implementation CachedImage

+(CachedImage *)sharedInstance {
    
    static CachedImage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [CachedImage new];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.imageCache = [NSCache new];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.imageCache setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [self.imageCache objectForKey:key];
}

@end
