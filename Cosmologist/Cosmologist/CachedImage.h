//
//  CachedImage.h
//  Cosmologist
//
//  Created by Ethan Hess on 3/9/17.
//  Copyright © 2017 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CachedImage : NSObject

@property (nonatomic, strong) NSCache *imageCache;

+ (CachedImage *)sharedInstance;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;

@end

