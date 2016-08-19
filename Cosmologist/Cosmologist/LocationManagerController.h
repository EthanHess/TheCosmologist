//
//  LocationManagerController.h
//  Cosmologist
//
//  Created by Ethan Hess on 8/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import UIKit;

@interface LocationManagerController : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) CLLocationCoordinate2D *currentLocation;
@property (nonatomic) BOOL locationReady;

+ (LocationManagerController *)sharedInstance;

- (void)getCurrentLocationWithCompletion:(void (^)(CLLocationCoordinate2D currentLocation, BOOL success))completion;

@end
