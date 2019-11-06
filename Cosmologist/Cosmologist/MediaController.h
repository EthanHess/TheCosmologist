//
//  MediaController.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThePicture+CoreDataClass.h"
#import "TheAlbum+CoreDataClass.h"
#import "TheVideo+CoreDataClass.h"
#import "TheAlbumV+CoreDataClass.h"
#import "CoreDataStack.h"

@interface MediaController : NSObject

@property (nonatomic, strong) NSArray *albums; //Jan 15
@property (nonatomic, strong) NSArray *videoAlbums;

+ (MediaController *)sharedInstance;

- (void)removePicture:(ThePicture *)picture;
- (void)removeAlbum:(TheAlbum *)album;
- (void)addPictureToAlbum:(UIImage *)image about:(NSString *)desc new:(BOOL)createNew;

- (void)removeVideo:(TheVideo *)video;
- (void)removeVideoAlbum:(TheAlbumV *)albumV;
- (void)addURLtoAlbum:(NSString *)videoURL about:(NSString *)about andCreateNew:(BOOL)createNew;

@end


