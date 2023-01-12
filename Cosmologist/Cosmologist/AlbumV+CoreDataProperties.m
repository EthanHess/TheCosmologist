//
//  AlbumV+CoreDataProperties.m
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
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
