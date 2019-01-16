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

- (NSArray *)albums {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSArray *objects = [[CoreDataStack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    return objects;
}


//If there are no albums,
- (void)addPictureToAlbum:(UIImage *)image about:(NSString *)desc new:(BOOL)createNew {
    
    NSData *data = [self imageToData:image]; //Throw?
    Picture *picture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
    picture.about = desc;
    picture.data = data;
    
    if (createNew == YES) {
        Album *newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
        newAlbum.name = [self newAlbumTitle];
        picture.album = newAlbum;
        [self synchronize];
    } else {
        Album *currentAlbum = self.albums.lastObject;
        picture.album = currentAlbum;
        [self synchronize];
    }
}

- (NSString *)newAlbumTitle {
    return [NSString stringWithFormat:@"Album %lu", self.albums.count + 1];
}

- (void)removePicture:(Picture *)picture {
    [[picture managedObjectContext]deleteObject:picture];
    [self synchronize];
}

- (void)removeAlbum:(Album *)album {
    [[album managedObjectContext]deleteObject:album];
    [self synchronize];
}

- (NSData *)imageToData:(UIImage *)image {
    return [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
}

- (void)synchronize {
    [[CoreDataStack sharedInstance].managedObjectContext save:NULL];
}

@end
