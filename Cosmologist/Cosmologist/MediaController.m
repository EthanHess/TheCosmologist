//
//  MediaController.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MediaController.h"

@implementation MediaController

+ (MediaController *)sharedInstance {
    static MediaController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MediaController new];
    });
    
    return sharedInstance;
    
}

//TODO: Can save video of the day as well

//Allow external storage for better performance

- (NSArray *)pictures {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Picture"];
    
    NSArray *objects = [[CoreDataStack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
}

- (void)addImage:(UIImage *)image {
    
    NSData *data = [self imageToData:image];
    
    Picture *picture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
    
    picture.data = data;
    
    [self synchronize];
}

- (void)removePicture:(Picture *)picture {
    
    [[picture managedObjectContext]deleteObject:picture];
    
    [self synchronize];
}

- (NSData *)imageToData:(UIImage *)image {
    
    return [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
}

- (void)synchronize {
    
    [[CoreDataStack sharedInstance].managedObjectContext save:NULL];
}

@end
