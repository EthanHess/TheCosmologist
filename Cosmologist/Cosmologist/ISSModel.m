//
//  ISSModel.m
//  Cosmologist
//
//  Created by Ethan Hess on 11/6/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ISSModel.h"

@implementation ISSModel

- (id)initializeWithDictionary:(NSDictionary * __nullable)dictionary {
    
    if (self) { //configure properties
        
        self.latitude = [dictionary[latLongWrapperKey][kLat] doubleValue];
        self.longitude = [dictionary[latLongWrapperKey][kLong] doubleValue];
    }
    
    return self;
}

@end
