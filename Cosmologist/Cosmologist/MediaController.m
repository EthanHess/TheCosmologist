//
//  MediaController.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MediaController.h"

@implementation MediaController

+ (MediaController *)sharedInstance {
    static MediaController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MediaController new];
    });
    
    return sharedInstance;
    
}

@end
