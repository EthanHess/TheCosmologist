//
//  Picture+CoreDataProperties.m
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
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
