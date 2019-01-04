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

@interface DetailViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSArray *soundDataArary; 

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ) {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
    [self renderBarButton]; 
}
    
- (void)renderBarButton {
    UIImage *image = [[UIImage imageNamed:@"soundIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.sideBarButton.image = image;
}

- (void)refreshTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)getData {
    
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
        [self refreshTable];
    }];
}

- (void)playAudioFileAtURL:(NSURL *)url {
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL: url];
    self.player = [AVPlayer playerWithPlayerItem: item];
    [self.player play];
}

#pragma Datasource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.soundDataArary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"soundCell"];
    SoundData *data = self.soundDataArary[indexPath.row];
    
    cell.soundTitleLabel.text = data.title;
    cell.soundURL = [NSURL URLWithString:data.streamURL];
    
    if (![data.soundDescription isKindOfClass:[NSNull class]]) {
        cell.soundDescLabel.text = data.soundDescription;
    } else {
        cell.soundDescLabel.text = @"No description available."; 
    }
    
    return cell;
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
