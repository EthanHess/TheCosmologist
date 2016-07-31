//
//  NasaData.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "NasaData.h"

@implementation NasaData

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        self.title = dictionary[titleKey];
        self.copyright = dictionary[copyrightKey];
        self.explanation = dictionary[explanationKey];
        self.dateString = dictionary[dateKey];
        self.urlString = dictionary[urlKey];
        self.hdurlString = dictionary[hdurlKey];
        self.mediaType = dictionary[mediaTypeKey]; 
        
    }
    
    return self;
}

@end
