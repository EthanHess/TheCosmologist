//
//  Video+CoreDataProperties.m
//  Cosmologist
//
//  Created by Ethan Hess on 5/2/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//
//

#import "Video+CoreDataProperties.h"

@implementation Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Video"];
}

@dynamic about;
@dynamic url;
@dynamic albumV;

@end
