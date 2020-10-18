//
//  TimeZoneHelper.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/17/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import "TimeZoneHelper.h"

@implementation TimeZoneHelper

//TODO const for keys, better practice
//Can compact / D.R.Y. some of these functions as well

//Fetch from NSUserDefaults
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

//Set in NSUserDefaults
+ (void)setVideoURLInDefaults:(NSString *)videoURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:videoURL forKey:@"lastVideoURLKey"];
}

+ (void)setImageURLInDefaults:(NSString *)imageURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imageURL forKey:@"lastImageURLKey"];
}

+ (void)setTimeStampInDefaults:(NSString *)timeStamp {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:timeStamp forKey:@"lastFetchTimeStampKey"];
}

//Desc. + Title

+ (void)setTitleInDefaults:(NSString *)title {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:title forKey:@"titleKey"];
}

+ (void)setDescriptionInDefaults:(NSString *)description {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:description forKey:@"descriptionKey"];
}

+ (NSString *)lastTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"titleKey"] != nil ? [defaults objectForKey:@"titleKey"] : @"";
}

+ (NSString *)lastDescription {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"descriptionKey"] != nil ? [defaults objectForKey:@"descriptionKey"] : @"";
}

+ (BOOL)pastMidnightEastCoastTime {
    return YES; //TODO imp.
}

+ (NSTimeZone *)timeZoneForDateFormatter:(BOOL)current {
    return current == YES ? [NSTimeZone systemTimeZone] : [NSTimeZone timeZoneWithName:@"US/Eastern"];
}

//MARK: clear NSUserDefaults
+ (void)removeObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}

@end
