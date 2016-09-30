//
//  CoreDataStack.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface CoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (CoreDataStack *)sharedInstance;

@end
