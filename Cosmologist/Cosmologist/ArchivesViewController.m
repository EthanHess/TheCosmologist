//
//  ArchivesViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ArchivesViewController.h"
#import "CachedImage.h"
#import "UIImage+Resize.h"
#import "AlbumDetailViewController.h"

@interface ArchivesViewController ()

@property (nonatomic, strong) Album *selectedAlbum;
@property (nonatomic) BOOL videoMode;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *videosBarButton;

@end

@implementation ArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData]; //move?
    
    if ([[MediaController sharedInstance]videoAlbums].count > 0) {
        AlbumV *videoAlbum = [[MediaController sharedInstance]videoAlbums][0];
        Video *first = videoAlbum.videos[0];
        NSLog(@"--- VA --- %@", videoAlbum.name);
        NSLog(@"--- FA --- FU %@ %@", first.about, first.url);
    }
    
    self.videoMode = NO;
    [self barButtonTitle];
}


- (void)barButtonTitle {
    NSString *theTitle = self.videoMode == YES ? @"Videos" : @"Images";
    [self.videosBarButton setTitle:theTitle];
}

- (IBAction)videoImageToggle:(id)sender {
    self.videoMode = !self.videoMode;
    [self barButtonTitle];
    [self refresh];
}

- (void)refresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory warning received");
}

//TODO update for video mode, most are YouTube URLS
//Will also want to save description

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Check if nil?
    ArchivesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //Does this need to be safer?
    if (self.videoMode == NO) {
        Album *album = [[MediaController sharedInstance]albums][indexPath.row];
        NSData *data = album.pictures[0].data; //first for cover?
        [self configureCell:cell withImageData:data];
    } else {
        AlbumV *videoAlbum = [[MediaController sharedInstance]videoAlbums][indexPath.row];
        Video *theVideo = videoAlbum.videos[0];
        [self configureCell:cell withVideoURL:theVideo.url andAbout:theVideo.about];
    }
    
    return cell;
}

//TODO, consider doing inside of cell or having two separate cells

- (void)configureCell:(ArchivesCollectionViewCell *)cell withVideoURL:(NSString *)theURL andAbout:(NSString *)about {
    
}

- (void)configureCell:(ArchivesCollectionViewCell *)cell withImageData:(NSData *)data {
    
    //Resizing images but perhaps should store separate thumbnails to make fetching faster, collection view is a bit choppy
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *albumArray = self.videoMode == NO ? [[MediaController sharedInstance]albums] : [[MediaController sharedInstance]videoAlbums];
    return albumArray != nil ? albumArray.count : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.videoMode == NO) {
        Album *album = [[MediaController sharedInstance] albums][indexPath.row];
        [self popAlertWthAlbum:album title:@"Options" andMessage:@"What would you like to do?"];
    } else {
        AlbumV *videoAlbum = [[MediaController sharedInstance] videoAlbums][indexPath.row];
        NSLog(@"SELECTED VIDEO ALBUM %@", videoAlbum);
    }
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    [UIView animateWithDuration:1 animations:^{
//        
//        attributes.size = CGSizeMake(300, 300);
//        
//    }];
//}

- (void)popAlertWthAlbum:(Album *)album title:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[MediaController sharedInstance]removeAlbum:album];
        [self.collectionView reloadData];
    }];
    
    UIAlertAction *view = [UIAlertAction actionWithTitle:@"View" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAlbum:album];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertCon addAction:delete];
    [alertCon addAction:view];
    [alertCon addAction:cancel];
    
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)goToAlbum:(Album *)album {
    self.selectedAlbum = album;
    [self performSegueWithIdentifier:@"toDetail" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        AlbumDetailViewController *dvc = [segue destinationViewController];
        dvc.album = self.selectedAlbum;
    }
}


@end
