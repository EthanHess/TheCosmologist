//
//  AlbumDetailViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 1/15/19.
//  Copyright © 2019 Ethan Hess. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "ArchivesCollectionViewCell.h"
#import "CachedImage.h"
#import "UIImage+Resize.h"

//TODO External data source

@interface AlbumDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UIImageView *theImageView;

@end

@implementation AlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
    if (self.theImageView == nil) {
        self.theImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.theImageView.image = [UIImage imageNamed:@"tableViewBG"]; //Size to fit?
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:self.theImageView belowSubview:self.collectionView];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)refresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vMode == YES ? self.videoAlbum.videos.count : self.album.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ri = @"pCell";
    ArchivesCollectionViewCell *ac = [collectionView dequeueReusableCellWithReuseIdentifier:ri forIndexPath:indexPath];
    if (self.vMode == YES) {
        TheVideo *video = self.videoAlbum.videos[indexPath.row];
        [self configureVideoCell:ac withVideo:video];
    } else {
        ThePicture *pic = self.album.pictures[indexPath.row];
        [self configureCell:ac withImageData:pic.data];
    }
    return ac;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.vMode == YES) {
        //Video will play
    } else {
        ThePicture *picture = self.album.pictures[indexPath.row];
        if (self.album.pictures.count == 1) {
            //Can't delete if only one picture left, pop alert to delete album
        } else {
            [self popAlertWithPicture:picture title:@"What would you like to do?" andMessage:@""]; //share/delete etc.
        }
    }
}

// D.R.Y. this doesn't need to be in two VCs

- (void)configureVideoCell:(ArchivesCollectionViewCell *)cell withVideo:(TheVideo *)video {
    cell.videoURL = video.url;
    [cell setUpWebView];
}

- (void)configureCell:(ArchivesCollectionViewCell *)cell withImageData:(NSData *)data {
    
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSURL *picURL = [NSURL URLWithString:dataString];
    UIImage *cahcedImage = [[CachedImage sharedInstance]imageForKey:(NSString *)picURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (cahcedImage) {
            cell.theImageView.image = [cahcedImage resize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)];
        } else {
            cell.theImageView.image = [[UIImage imageWithData:data]resize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)];
            [[CachedImage sharedInstance]setImage:[[UIImage imageWithData:data]resize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)] forKey:(NSString *)picURL];
        }
    });
}

//Move to detail VC

- (void)popAlertWithPicture:(ThePicture *)picture title:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[MediaController sharedInstance]removePicture:picture];
        [self.collectionView reloadData];
    }];
    
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareContent:picture];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertCon addAction:delete];
    [alertCon addAction:share];
    [alertCon addAction:cancel];
    
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)shareContent:(ThePicture *)picture {
    
    //convert pic to uiimage
    UIImage *image = [self imageFromPicture:picture];
    if (image) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    } else {
        NSLog(@"COULD NOT GET IMAGE %s", __PRETTY_FUNCTION__);
    }
}

- (UIImage *)imageFromPicture:(ThePicture *)picture {
    if (picture.data) {
        return [UIImage imageWithData:picture.data];
    } else {
        NSLog(@"Something went wrong");
        return nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
