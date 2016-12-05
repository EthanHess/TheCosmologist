//
//  AsteroidsViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/12/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "AsteroidsViewController.h"
#import "NasaDataController.h"
#import "Constants.h"
#import "AsteroidData.h"
#import "AsteroidTableViewCell.h"

@interface AsteroidsViewController ()

@property (nonatomic, strong) NSArray *asteroidDataArray;

@end

@implementation AsteroidsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.leftBarButton setTarget: self.revealViewController];
        [self.leftBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated]; 
    
    self.now = [NSDate date];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *aDayFromNow = [calendar dateByAddingComponents:dayComponent toDate:self.now options:0];
    
    self.inTwentyFour = aDayFromNow;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self getData];
    });
    
    [self makeBarButtonLookNice]; 
}
    
- (void)makeBarButtonLookNice {
    
    UIImage *image = [[UIImage imageNamed:@"asteroidIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftBarButton.image = image;
}

- (void)getData {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _dateOne = [dateFormatter stringFromDate:self.now];
    _dateTwo = [dateFormatter stringFromDate:self.inTwentyFour];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/neo/rest/v1/feed?start_date=%@&end_date=%@&api_key=%@", _dateOne, _dateTwo, NASA_API_KEY];
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)urlString andCompletion:^(NSArray *nasaArray) {
        
        self.asteroidDataArray = [self parseArray:nasaArray];
        
        [_tableView reloadData];
        
    }];
}

- (NSArray *)parseArray:(NSArray *)arrayToParse {
        
        NSMutableArray *mutableDataArray = [NSMutableArray new];
        
        for (NSDictionary *dictionary in arrayToParse) {
            
            NSArray *dictArray = dictionary[@"near_earth_objects"][_dateOne];
            
            //NSLog(@"DICTARRAY: %@", dictArray);
            
            for (NSDictionary *dict in dictArray) {
                
                AsteroidData *aData = [[AsteroidData alloc]initWithDictionary:dict];
                
                NSLog(@"DATA ARRAY %@", aData);
                
                [mutableDataArray addObject:aData];
            }
        }
        
        
        return mutableDataArray;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AsteroidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //clear out views for dequeing
    
    cell.nameLabel.text = @"";
    cell.diameterLabel.text = @"";
    [cell.urlButton setTitle:@"" forState:UIControlStateNormal];
    
    //get the info
    
    AsteroidData *asteroid = _asteroidDataArray[indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    cell.nameLabel.text = asteroid.name;
    [cell.urlButton setTitle:asteroid.jplURL forState:UIControlStateNormal];
    cell.data = asteroid;
        
    }); 
    
    //cell.diameterLabel.text = asteroid.estimatedDiameterMilesMax;
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _asteroidDataArray.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
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
