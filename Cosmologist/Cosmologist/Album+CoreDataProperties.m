//
//  Album+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 1/15/19.
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
