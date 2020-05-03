//
//  AlbumV+CoreDataProperties.m
//  Cosmologist
//
//  Created by Ethan Hess on 5/2/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
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
