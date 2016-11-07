//
//  ISSModel.h
//  Cosmologist
//
//  Created by Ethan Hess on 11/6/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *latLongWrapperKey = @"iss_position";
static NSString *kLat = @"latitude";
static NSString *kLong = @"longitude";

@interface ISSModel : NSObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (id)initializeWithDictionary:(NSDictionary *)dictionary;

@end
