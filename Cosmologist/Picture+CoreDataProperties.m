//
//  Picture+CoreDataProperties.m
//  Cosmologist
//
//  Created by Ethan Hess on 5/2/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
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
