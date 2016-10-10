//
//  CreditsViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/10/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "CreditsViewController.h"
#import "SWRevealViewController.h"

@interface CreditsViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (strong, nonatomic) IBOutlet UILabel *SWRLabel;
@property (strong, nonatomic) IBOutlet UILabel *NASALabel;

@end

@implementation CreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.leftBarButton setTarget: self.revealViewController];
        [self.leftBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self setUpViews];
}

- (void)setUpViews {
    
    NSString *customStringOne = @"A special thanks to SWRevealController";
    
    [self configureSWRLabel:customStringOne];
    
    NSString *customStringTwo = @"Also a special thanks to NASA for their awesome API";
    
    [self configureNasaLabel:customStringTwo];
    
}

- (void)configureSWRLabel:(NSString *)string {
    
    NSMutableAttributedString *customAttStrOne = [[NSMutableAttributedString alloc]initWithString:string];
    
    [customAttStrOne addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(20, 18)];
    
    self.SWRLabel.attributedText = customAttStrOne;
    
}

- (void)configureNasaLabel:(NSString *)string {
    
    NSMutableAttributedString *customAttStrTwo = [[NSMutableAttributedString alloc]initWithString:string];
    
    [customAttStrTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(25, 4)];
    
    self.NASALabel.attributedText = customAttStrTwo;
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
