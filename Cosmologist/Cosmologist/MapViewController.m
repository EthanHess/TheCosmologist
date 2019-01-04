//
//  MapViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/16/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MapViewController.h"

#import "SWRevealViewController.h"
#import "NasaDataController.h"
#import "ISSModel.h"
#import "UIImage+Resize.h"
#import "StationAnnotation.h"
#import "SliderView.h"

@import MapKit;

@interface MapViewController () <MKMapViewDelegate, SliderValueUpdatedDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (strong, nonatomic) IBOutlet SliderView *sliderView;

@property (nonatomic, strong) ISSModel *theModel;

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
    
    self.sliderView.hidden = YES;
    self.sliderView.delegate = self;
    
    [self ISSTest];
    
    self.mapView.alpha = 0.8;
    self.mapView.mapType = MKMapTypeHybrid;
    self.view.backgroundColor = [UIColor redColor]; //make configurable
    
    [self renderTheButtonNicely]; 
}
    
- (void)renderTheButtonNicely {
    UIImage *image = [[UIImage imageNamed:@"spaceStationIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftBarButton.image = image;
}

- (void)ISSTest {
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)@"http://api.open-notify.org/iss-now.json"andCompletion:^(NSArray *nasaArray) {
        NSLog(@"ISS TEST! %@", nasaArray);
        NSDictionary *infoDict = nasaArray[0];
        ISSModel *theModel = [[ISSModel alloc]initializeWithDictionary:infoDict];
        [self setUpMapViewWithISSInfo:theModel];
        self.theModel = theModel; //might not need this
    }];
}

- (void)setUpMapViewWithISSInfo:(ISSModel *)theModel {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 50;
    span.longitudeDelta = 50;
    
    region.span = span;
    region.center.latitude = theModel.latitude;
    region.center.longitude = theModel.longitude;
    
    [self.mapView setRegion:region];
    
    StationAnnotation *anno = [[StationAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake(theModel.latitude, theModel.longitude)];
    
    [self.mapView addAnnotation:anno];
    
}

- (IBAction)rightBarButtonTapped:(id)sender {
    [self fadeInSliderView];
}

- (void)fadeInSliderView {
    [UIView animateWithDuration:1.5 animations:^{
        self.sliderView.hidden = NO;
    }];
}

    
- (void)updateColorWithRed:(float)red green:(float)green blue:(float)blue {
    
    float redToUpdate = red * 255;
    float greenToUpdate = green * 255;
    float blueToUpdate = blue * 255;
    
    UIColor *newBackgroundColor = [UIColor colorWithRed:(redToUpdate / 255) green:(greenToUpdate / 255) blue:(blueToUpdate / 255) alpha:1];
    
    //Make sure not already on main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = newBackgroundColor;
    });
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKAnnotationView *annView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"theAnnotation"];
    
    annView.center = self.view.center;
    
    //config image
    CGSize newSize = CGSizeMake(100, 100);
    
    UIImage *spaceStationPic = [UIImage imageNamed:@"spaceStation"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-20, -20, 80, 80)];
    imageView.image = [spaceStationPic resize:newSize];
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    imageView.layer.masksToBounds = YES;
    
    [annView addSubview:imageView];
    
    return annView;
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
