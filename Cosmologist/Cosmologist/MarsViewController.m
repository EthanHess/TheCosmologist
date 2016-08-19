//
//  MarsViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MarsViewController.h"
#import "NasaDataController.h"
#import "MarsData.h"
#import "MarsTableViewCell.h"
#import "Constants.h"
#import "MarsDetailViewController.h"

@interface MarsViewController ()

@property (nonatomic, strong) NSArray *marsDataArray;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, strong) NSData *dataToSend;

@end

@implementation MarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.leftBarButton setTarget: self.revealViewController];
        [self.leftBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [self getNasaInfoAtIndex:0];
    });
}

- (void)getNasaInfoAtIndex:(NSInteger)index {
    
    //main url string for pages
    
    NSString *mainString = [NSString stringWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=%ld&api_key=%@", (long)index, NASA_API_KEY];
    

    
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)mainString andCompletion:^(NSArray *nasaArray) {
        
        //NSLog(@"%@", nasaArray);
        
        if (nasaArray) {
            
            self.marsDataArray = [self parseSearchResultsData:nasaArray];
            
            NSLog(@"DATA ARRAY %@", _marsDataArray);
        }
        
        else {
            
            NSLog(@"Something went wrong");
        }
        
    }];
    
}

- (NSArray *)parseSearchResultsData:(NSArray *)arrayToParse {
    
    NSMutableArray *mutableDataArray = [NSMutableArray new];
    
    for (NSDictionary *dictionary in arrayToParse) {
        
        NSArray *dictArray = dictionary[@"photos"];
        
        NSLog(@"DICTARRAY: %@", dictArray);
        
        for (NSDictionary *dict in dictArray) {
            
            MarsData *marsData = [[MarsData alloc]initWithDictionary:dict];
            
            [mutableDataArray addObject:marsData];
            
            _marsDataArray = mutableDataArray;
            
        }
    }
    
    [_tableView reloadData];
    
    return mutableDataArray;
}

#pragma Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _marsDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"marsCell"];
    
    //get priority queue so table view doesn't freeze
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        MarsData *data = _marsDataArray[indexPath.row];
    
        NSURL *urlString = [NSURL URLWithString:data.imageURLString];
    
        NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
                   
        cell.marsImageView.image = [UIImage imageWithData:pictureData];
        cell.dateLabel.text = data.landingDateString;
        
    });
        
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:true];
    
    MarsData *data = _marsDataArray[indexPath.row];
    
    NSURL *urlString = [NSURL URLWithString:data.imageURLString];
    
    NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
    
    _dataToSend = pictureData;
    
    [self performSegueWithIdentifier:@"detailSegue" sender:nil]; //self?
}

- (IBAction)segmentTapped:(id)sender {
    
    NSInteger page = self.segControl.selectedSegmentIndex;
    
    [self getNasaInfoAtIndex:page]; 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        MarsDetailViewController *dvc = [segue destinationViewController];
        
        dvc.picData = _dataToSend;
    }
    
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

#pragma UNUSED RESOURCES

//other nasa urls, might use in future

//    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=%@", NASA_API_KEY];

//others

//    NSString *stringTwo = [NSString stringWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=%@", NASA_API_KEY];

//    NSString *stringFour = [NSString stringWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=%@", NASA_API_KEY];


@end
