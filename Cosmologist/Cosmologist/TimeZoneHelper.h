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

+ (void)setVideoURLInDefaults:(NSString *)videoURL;
+ (void)setImageURLInDefaults:(NSString *)imageURL;
+ (void)setTimeStampInDefaults:(NSString *)timeStamp;

//Description + Title
+ (void)setTitleInDefaults:(NSString *)title;
+ (void)setDescriptionInDefaults:(NSString *)description;

+ (NSString *)lastTitle;
+ (NSString *)lastDescription;

+ (BOOL)pastMidnightEastCoastTime; //When NASA refreshes

//clear
+ (void)removeObjectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
