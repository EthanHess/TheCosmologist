//
//  TheAlbum+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheAlbum+CoreDataProperties.h"

@implementation TheAlbum (CoreDataProperties)

+ (NSFetchRequest<TheAlbum *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TheAlbum"];
}

@dynamic name;
@dynamic pictures;

@end
