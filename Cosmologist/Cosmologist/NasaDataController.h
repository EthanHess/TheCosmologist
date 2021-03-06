//
//  NasaDataController.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NasaDataController : NSObject

+ (NasaDataController *)sharedInstance;

- (void)getNasaInfoWithURL:(NSURL *)url andCompletion:(void (^)(NSArray *nasaArray))completion;

@end
