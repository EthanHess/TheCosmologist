//
//  MapViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/16/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;
#import "SWRevealViewController.h"
#import "NasaDataController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealController = self.revealViewController;
    
    if (revealController) {
        
        [self.leftBarButton setTarget:self.revealViewController];
        [self.leftBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self ISSTest];
}

//TODO: Add own VC with ISS tracking feature

- (void)ISSTest {
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)@"http://api.open-notify.org/iss-now.json"andCompletion:^(NSArray *nasaArray) {
        
        NSLog(@"ISS TEST! %@", nasaArray);
        
    }];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    
//}

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
