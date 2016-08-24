//
//  MarsDetailViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MarsDetailViewController.h"

@interface MarsDetailViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;

@end

@implementation MarsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@ PIC DATA", _picData);
    
    _scrollView.contentSize = CGSizeMake(800, 600);

    _theImageView.image = [UIImage imageWithData:_picData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
