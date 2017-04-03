//
//  ArchivesViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ArchivesViewController.h"
#import "CachedImage.h"

@interface ArchivesViewController ()

@end

@implementation ArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"Memory warning received");
}

//add current product module to model?

//for MVP keep as is but add iCarousel for fancy collection view

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ArchivesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Picture *picture = [[MediaController sharedInstance] pictures][indexPath.row];
    
    [self configureCell:cell withImageData:picture.data];
    
    return cell;
}

//- (void)organizeArray {
//    
//    NSMutableArray *array = [[[MediaController sharedInstance]pictures] mutableCopy];
//    
//    if (array.count > 10) {
//        
//        
//        
//    }
//}

- (void)configureCell:(ArchivesCollectionViewCell *)cell withImageData:(NSData *)data {
    
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSURL *picURL = [NSURL URLWithString:dataString];
    
    UIImage *cahcedImage = [[CachedImage sharedInstance]imageForKey:(NSString *)picURL];
    
    if (cahcedImage) {
        
        cell.theImageView.image = cahcedImage;
    }
    
    else {
    
        cell.theImageView.image = [UIImage imageWithData:data];
        [[CachedImage sharedInstance]setImage:[UIImage imageWithData:data] forKey:(NSString *)picURL];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[[MediaController sharedInstance] pictures]count];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Picture *picture = [[MediaController sharedInstance] pictures][indexPath.row];
    
    [self popAlertWithPicture:picture title:@"Options" andMessage:@"What would you like to do with this picture?"];
    
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

- (void)popAlertWithPicture:(Picture *)picture title:(NSString *)title andMessage:(NSString *)message {
    
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

- (void)shareContent:(Picture *)picture {
    
    //convert pic to uiimage

    UIImage *image = [self imageFromPicture:picture];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (UIImage *)imageFromPicture:(Picture *)picture {
    
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
