//
//  TheAlbumV+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheAlbumV+CoreDataProperties.h"

@implementation TheAlbumV (CoreDataProperties)

+ (NSFetchRequest<TheAlbumV *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TheAlbumV"];
}

@dynamic name;
@dynamic videos;

@end
