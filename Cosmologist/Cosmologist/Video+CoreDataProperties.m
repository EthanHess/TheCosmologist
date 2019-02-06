//
//  Video+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 2/5/19.
//
//

#import "Video+CoreDataProperties.h"

@implementation Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Video"];
}

@dynamic url;
@dynamic about;
@dynamic albumV;

@end
