//
//  AlbumDetailViewController.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/15/19.
//  Copyright © 2019 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album+CoreDataClass.h"
#import "Picture+CoreDataClass.h"
#import "MediaController.h"
#import "Video+CoreDataClass.h"
#import "AlbumV+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumDetailViewController : UIViewController

@property (strong, nonatomic) Album *album;
@property (strong, nonatomic) AlbumV *videoAlbum;
@property (nonatomic, assign) BOOL vMode;

@end

NS_ASSUME_NONNULL_END
