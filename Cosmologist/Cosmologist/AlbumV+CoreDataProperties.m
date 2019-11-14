//
//  AlbumV+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "AlbumV+CoreDataProperties.h"

@implementation AlbumV (CoreDataProperties)

+ (NSFetchRequest<AlbumV *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AlbumV"];
}

@dynamic name;
@dynamic videos;

@end
