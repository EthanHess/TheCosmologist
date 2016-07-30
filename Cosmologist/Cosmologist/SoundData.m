//
//  SoundData.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "SoundData.h"

@implementation SoundData

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        self.title = dictionary[titleKey];
        self.soundDescription = dictionary[descriptionKey];
        self.streamURL = dictionary[streamUrlKey]; 
    }
    
    return self;
}

@end
