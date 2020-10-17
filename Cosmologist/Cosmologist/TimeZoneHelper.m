//
//  TimeZoneHelper.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/17/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import "TimeZoneHelper.h"

@implementation TimeZoneHelper

+ (NSString *)lastVideoURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"lastVideoURLKey"] != nil ? [defaults objectForKey:@"lastVideoURLKey"] : @"";
}

+ (NSString *)lastImageURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"lastImageURLKey"] != nil ? [defaults objectForKey:@"lastImageURLKey"] : @"";
}

+ (NSString *)lastFetchTimeStamp {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"lastFetchTimeStampKey"] != nil ? [defaults objectForKey:@"lastFetchTimeStampKey"] : @"";
}

+ (BOOL)pastMidnightEastCoastTime {
    return YES; //TODO imp.
}

+ (NSTimeZone *)timeZoneForDateFormatter:(BOOL)current {
    return current == YES ? [NSTimeZone systemTimeZone] : [NSTimeZone timeZoneWithName:@"US/Eastern"];
}


@end
