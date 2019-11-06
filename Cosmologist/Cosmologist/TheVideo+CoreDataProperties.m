//
//  TheVideo+CoreDataProperties.m
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheVideo+CoreDataProperties.h"

@implementation TheVideo (CoreDataProperties)

+ (NSFetchRequest<TheVideo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TheVideo"];
}

@dynamic about;
@dynamic url;
@dynamic albumV;

@end
