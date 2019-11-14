//
//  Picture+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "Picture+CoreDataProperties.h"

@implementation Picture (CoreDataProperties)

+ (NSFetchRequest<Picture *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Picture"];
}

@dynamic about;
@dynamic data;
@dynamic album;

@end
