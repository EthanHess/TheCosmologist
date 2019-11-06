//
//  ArchivesViewController.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArchivesCollectionViewCell.h"
#import "MediaController.h"
#import "ThePicture+CoreDataClass.h"
#import "TheAlbum+CoreDataClass.h"
#import "TheVideo+CoreDataClass.h"
#import "TheAlbumV+CoreDataClass.h"

@interface ArchivesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
