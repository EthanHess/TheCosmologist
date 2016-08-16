//
//  NasaData.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

static NSString *const titleKey = @"title";
static NSString *const urlKey = @"url";
static NSString *const hdurlKey = @"hdurl";
static NSString *const copyrightKey = @"copyright";
static NSString *const dateKey = @"date";
static NSString *const explanationKey = @"explanation";
static NSString *const mediaTypeKey = @"media_type";

@interface NasaData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *hdurlString;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *explanation;
@property (nonatomic, strong) NSString *mediaType; 

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
