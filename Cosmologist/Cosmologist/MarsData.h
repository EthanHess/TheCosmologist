//
//  MarsData.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const imageSourceKey = @"img_src";
static NSString *const roverKey = @"rover";
static NSString *const landingKey = @"landing_date";
static NSString *const cameraKey = @"camera"; //currently not using

@interface MarsData : NSObject

@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *landingDateString;

- (id)initWithDictionary:(NSDictionary *)dictionary; 

@end
