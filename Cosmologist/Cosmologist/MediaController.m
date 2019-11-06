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
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TheAlbum"];
    NSArray *objects = [[CoreDataStack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    return objects;
}

- (NSArray *)videoAlbums {
    NSFetchRequest *fetcher = [NSFetchRequest fetchRequestWithEntityName:@"TheAlbumV"];
    NSArray *videos = [[CoreDataStack sharedInstance].managedObjectContext executeFetchRequest:fetcher error:NULL];
    return videos;
}

#pragma Images

//If there are no albums,
- (void)addPictureToAlbum:(UIImage *)image about:(NSString *)desc new:(BOOL)createNew {
    
    NSData *data = [self imageToData:image]; //Throw?
    ThePicture *picture = [NSEntityDescription insertNewObjectForEntityForName:@"ThePicture" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
    picture.about = desc;
    picture.data = data;
    
    if (createNew == YES) {
        TheAlbum *newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"TheAlbum" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
        newAlbum.name = [self newAlbumTitle];
        picture.album = newAlbum;
        [self synchronize];
    } else {
        TheAlbum *currentAlbum = self.albums.lastObject;
        picture.album = currentAlbum;
        [self synchronize];
    }
}

- (NSString *)newAlbumTitle {
    return [NSString stringWithFormat:@"Album %lu", self.albums.count + 1];
}

- (void)removePicture:(ThePicture *)picture {
    [[picture managedObjectContext]deleteObject:picture];
    [self synchronize];
}

- (void)removeAlbum:(TheAlbum *)album {
    [[album managedObjectContext]deleteObject:album];
    [self synchronize];
}

- (NSData *)imageToData:(UIImage *)image {
    return [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
}

- (void)synchronize {
    [[CoreDataStack sharedInstance].managedObjectContext save:NULL];
}

#pragma Videos

- (void)addURLtoAlbum:(NSString *)videoURL about:(NSString *)about andCreateNew:(BOOL)createNew {
    
    TheVideo *video = [NSEntityDescription insertNewObjectForEntityForName:@"TheVideo" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
    video.about = about;
    video.url = videoURL;
    
    if (createNew == YES) {
        TheAlbumV *newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"TheAlbumV" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
        newAlbum.name = [self newVideoAlbumTitle];
        video.albumV = newAlbum;
        [self synchronize];
    } else {
        TheAlbumV *current = self.videoAlbums.lastObject;
        video.albumV = current;
        [self synchronize];
    }
}

- (NSString *)newVideoAlbumTitle {
    return [NSString stringWithFormat:@"Album %lu", self.videoAlbums.count + 1];
}

- (void)removeVideo:(TheVideo *)video {
    [[video managedObjectContext]deleteObject:video];
    [self synchronize];
}

- (void)removeVideoAlbum:(TheAlbumV *)albumV {
    [[albumV managedObjectContext]deleteObject:albumV];
    [self synchronize];
}

@end
