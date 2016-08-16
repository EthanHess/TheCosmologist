//
//  AsteroidData.h
//  Cosmologist
//
//  Created by Ethan Hess on 8/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *nameKey = @"name";
static const NSString *jplURLKey = @"nasa_jpl_url";
static const NSString *velocityKPHKey = @"kilometers_per_hour";
static const NSString *velocityMPHKey = @"miles_per_hour";
static const NSString *diameterMaxKey = @"estimated_diameter_max";
static const NSString *hazardKey = @"is_potentially_hazardous_asteroid";

//static const NSString *relativeVelocityDictKey = @"relative_velocity";
static const NSString *estimatedDiameterDictKey = @"estimated_diameter";
static const NSString *milesDictKey = @"miles";
static const NSString *kilometersDictKey = @"kilometers";
//static const NSString *approachDataKey = @"close_approach_data"; 

@interface AsteroidData : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *jplURL;

//@property (nonatomic, strong) NSString *velocityKilometersPerHour;
//@property (nonatomic, strong) NSString *velocityMilesPerHour;

@property (nonatomic, strong) NSString *estimatedDiameterKilometersMax;
@property (nonatomic, strong) NSString *estimatedDiameterMilesMax;

@property (nonatomic) BOOL isHazardous;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
