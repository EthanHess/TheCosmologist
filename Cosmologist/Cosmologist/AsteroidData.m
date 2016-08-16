//
//  AsteroidData.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "AsteroidData.h"

@implementation AsteroidData

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        self.name = dictionary[nameKey];
        self.jplURL = dictionary[jplURLKey];
        self.isHazardous = [dictionary[hazardKey] boolValue]; //might need to be extracted differently?
        self.estimatedDiameterMilesMax = dictionary[estimatedDiameterDictKey][milesDictKey][diameterMaxKey];
        self.estimatedDiameterKilometersMax = dictionary[estimatedDiameterDictKey][kilometersDictKey][diameterMaxKey];
//        self.velocityMilesPerHour = dictionary[approachDataKey][relativeVelocityDictKey][velocityMPHKey];
//        self.velocityKilometersPerHour = dictionary[approachDataKey][relativeVelocityDictKey][velocityKPHKey];
        
    }
    
    return self;
}

@end
