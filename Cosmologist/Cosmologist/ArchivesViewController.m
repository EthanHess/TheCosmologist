//
//  ArchivesViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/26/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ArchivesViewController.h"

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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ArchivesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Picture *picture = [[MediaController sharedInstance] pictures][indexPath.row];
    
    [self configureCell:cell withImageData:picture.data];
    
    return cell;
}

- (void)configureCell:(ArchivesCollectionViewCell *)cell withImageData:(NSData *)data {
    
    cell.theImageView.image = [UIImage imageWithData:data];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[[MediaController sharedInstance] pictures]count];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Picture *picture = [[MediaController sharedInstance] pictures][indexPath.row];
    
    [self popAlertWithPicture:picture title:@"Options" andMessage:@"What would you like to do with this picture?"];
    
}

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
