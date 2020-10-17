//
//  TimeZoneHelper.h
//  Cosmologist
//
//  Created by Ethan Hess on 10/17/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeZoneHelper : NSObject

+ (NSString *)lastVideoURL;
+ (NSString *)lastImageURL;
+ (NSString *)lastFetchTimeStamp; //refresh every 24 hours

+ (BOOL)pastMidnightEastCoastTime; //When NASA refreshes

@end

NS_ASSUME_NONNULL_END
