//
//  DetailViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "DetailViewController.h"
#import "SWRevealViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NasaDataController.h"
#import "SoundData.h"
#import "SoundCell.h"
#import "Constants.h"

//eventually move to constants file

//static NSString *const SOUND_CLOUD_CLIENT_ID = @"dfc6b54ca340285a93ce49a4cb3e6a6d";

@interface DetailViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSArray *soundDataArary; 

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/sounds?q=apollo&api_key=%@", NASA_API_KEY];
    
    NSURL *url = (NSURL *)urlString;
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:url andCompletion:^(NSArray *nasaArray) {
        
        for (NSDictionary *dictionary in nasaArray) {
            
            NSArray *dictArray = dictionary[@"results"];
            
            NSMutableArray *mutableDataArray = [NSMutableArray new];
            
            for (NSDictionary *dict in dictArray) {
                
                SoundData *data = [[SoundData alloc]initWithDictionary:dict];
                
                [mutableDataArray addObject:data];
                
                self.soundDataArary = mutableDataArray;
                
            }
            
        };
        
        [_tableView reloadData];
        
    }];
}

//require soundcloud api access to play NASA sound files until API is updated

- (void)playAudioFileAtURL:(NSURL *)url {
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL: url];
    self.player = [AVPlayer playerWithPlayerItem: item];
    
    [self.player play];
    
}

#pragma Datasource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _soundDataArary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"soundCell"];
    
    SoundData *data = _soundDataArary[indexPath.row];
    
    cell.soundTitleLabel.text = data.title;
    cell.soundURL = [NSURL URLWithString:data.streamURL];
    
    if (![data.soundDescription isKindOfClass:[NSNull class]]) {
        cell.soundDescLabel.text = data.soundDescription;
    } else {
        cell.soundDescLabel.text = @"No description available."; 
    }
    
    
    return cell;
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
