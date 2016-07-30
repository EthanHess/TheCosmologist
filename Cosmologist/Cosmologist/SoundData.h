//
//  SoundData.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const titleKey = @"title";
static NSString *const descriptionKey = @"description";
static NSString *const streamUrlKey = @"stream_url";

@interface SoundData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *soundDescription;
@property (nonatomic, strong) NSString *streamURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
