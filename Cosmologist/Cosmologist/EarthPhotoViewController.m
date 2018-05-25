//
//  EarthPhotoViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/19/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "EarthPhotoViewController.h"
#import "LocationManagerController.h"
#import "NasaDataController.h"
#import "Constants.h"

@interface EarthPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (nonatomic) CLLocationCoordinate2D location;
@end

@implementation EarthPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    
    [LocationManagerController sharedInstance]; 
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.leftButton setTarget: self.revealViewController];
        [self.leftButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInfo) name:LOCATION_READY_NOTIFICATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self renderBarButtonNicely];
    
    [self.activityView setHidesWhenStopped:YES]; 
    [self.activityView startAnimating];
}

- (void)renderBarButtonNicely {
    
    UIImage *image = [[UIImage imageNamed:@"earthButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftButton.image = image;
}

- (void)getInfo {
    
    [[LocationManagerController sharedInstance]getCurrentLocationWithCompletion:^(CLLocationCoordinate2D currentLocation, BOOL success) {
        
        if (success) {
            
            self.location = currentLocation;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            
            NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/earth/imagery?lon=%f&lat=%f&date=%@&cloud_score=True&api_key=%@", currentLocation.longitude, currentLocation.latitude, dateString, NASA_API_KEY];
            
            [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)urlString andCompletion:^(NSArray *nasaArray) {
                
                if (nasaArray.count > 0) {
                
                for (NSDictionary *dictionary in nasaArray) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setUpViewsWithDictionary:dictionary];
                    });
                }
                } else {
                    NSLog(@"NO NASA ARRAY %s", __PRETTY_FUNCTION__);
                }
            }];
        }
    }];
}

- (void)setUpViewsWithDictionary:(NSDictionary *)dictionary {
    
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.activityView stopAnimating];
    self.pictureImageView.image = [UIImage imageWithData:data];
    [self popAlert:@"This is what you look like to NASA! Rain or shine..." andMessage:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//TODO, have global function for alert

- (void)popAlert:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okayAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
