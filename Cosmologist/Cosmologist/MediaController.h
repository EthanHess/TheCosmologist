//
//  MediaController.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Picture+CoreDataClass.h"
#import "Album+CoreDataClass.h"
#import "Video+CoreDataClass.h"
#import "AlbumV+CoreDataClass.h"
#import "CoreDataStack.h"

@interface MediaController : NSObject

@property (nonatomic, strong) NSArray *albums; //Jan 15
@property (nonatomic, strong) NSArray *videoAlbums;

+ (MediaController *)sharedInstance;

- (void)removePicture:(Picture *)picture;
- (void)removeAlbum:(Album *)album;
- (void)addPictureToAlbum:(UIImage *)image about:(NSString *)desc new:(BOOL)createNew;

- (void)removeVideo:(Video *)video;
- (void)removeVideoAlbum:(AlbumV *)albumV;
- (void)addURLtoAlbum:(NSString *)videoURL about:(NSString *)about andCreateNew:(BOOL)createNew;

@end


