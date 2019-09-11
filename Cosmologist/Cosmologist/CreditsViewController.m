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
    if (revealViewController) {
        [self.leftBarButton setTarget: self.revealViewController];
        [self.leftBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setUpViews];
    [self renderBarButtonNicely];
}

- (void)renderBarButtonNicely {
    UIImage *image = [[UIImage imageNamed:@"creditsButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftBarButton.image = image;
}


- (void)setUpViews {
    
    self.NASALabel.alpha = 0;
    self.SWRLabel.alpha = 0;
    
    [self animateViewsIn];
    
    NSString *customStringOne = @"Frameworks: SWRevealController, API: NASA (The one and only)";
    [self configureSWRLabel:customStringOne];

    NSString *customStringTwo = @"Image credits: Pixabay";
    [self configureNasaLabel:customStringTwo];
}

- (void)animateViewsIn {
    [UIView animateWithDuration:1.5 animations:^{
        self.SWRLabel.alpha = 1;
    }];
    [UIView animateWithDuration:2.5 animations:^{
        self.NASALabel.alpha = 1;
    }];
}

- (void)configureSWRLabel:(NSString *)string {
    NSMutableAttributedString *customAttStrOne = [[NSMutableAttributedString alloc]initWithString:string];
    [customAttStrOne addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, string.length)];
    [customAttStrOne addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:21] range:NSMakeRange(0, string.length)];
    self.SWRLabel.attributedText = customAttStrOne;
}

- (void)configureNasaLabel:(NSString *)string {
    NSMutableAttributedString *customAttStrTwo = [[NSMutableAttributedString alloc]initWithString:string];
    [customAttStrTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length)];
    [customAttStrTwo addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:21] range:NSMakeRange(0, string.length)];
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
