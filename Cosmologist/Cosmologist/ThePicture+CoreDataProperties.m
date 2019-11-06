//
//  ThePicture+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "ThePicture+CoreDataProperties.h"

@implementation ThePicture (CoreDataProperties)

+ (NSFetchRequest<ThePicture *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ThePicture"];
}

@dynamic about;
@dynamic data;
@dynamic album;

@end
