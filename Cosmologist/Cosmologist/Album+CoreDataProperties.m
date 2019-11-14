//
//  Album+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "Album+CoreDataProperties.h"

@implementation Album (CoreDataProperties)

+ (NSFetchRequest<Album *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Album"];
}

@dynamic name;
@dynamic pictures;

@end
