//
//  AlbumDetailViewController.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/15/19.
//  Copyright © 2019 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheAlbum+CoreDataClass.h"
#import "ThePicture+CoreDataClass.h"
#import "MediaController.h"
#import "TheVideo+CoreDataClass.h"
#import "TheAlbumV+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumDetailViewController : UIViewController

@property (strong, nonatomic) TheAlbum *album;
@property (strong, nonatomic) TheAlbumV *videoAlbum;
@property (nonatomic, assign) BOOL vMode;

@end

NS_ASSUME_NONNULL_END
