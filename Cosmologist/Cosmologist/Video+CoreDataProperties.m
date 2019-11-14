//
//  Video+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/13/19.
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
