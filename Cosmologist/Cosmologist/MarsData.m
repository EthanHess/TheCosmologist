//
//  MarsData.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MarsData.h"

@implementation MarsData

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.imageURLString = dictionary[imageSourceKey];
        self.landingDateString = dictionary[roverKey][landingKey]; 
        //TODO: Add camera properties
    }
    
    return self;
}

@end
