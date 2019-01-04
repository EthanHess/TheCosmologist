//
//  SoundCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/29/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "SoundCell.h"
#import "Constants.h"

@implementation SoundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.soundPlayButton.layer.cornerRadius = 10;
    self.soundStopButton.layer.cornerRadius = 10;
    
    self.soundPlayButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.soundPlayButton.layer.borderWidth = 2;
    
    self.soundStopButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.soundStopButton.layer.borderWidth = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)playSound:(id)sender {
    //NASA's beta version requires sound cloud api key
    NSString *fullUrlString = [NSString stringWithFormat:@"%@%@%@", self.soundURL, CLIENT_PREFIX, SOUND_CLOUD_CLIENT_ID];
    NSURL *fullUrl = [NSURL URLWithString:fullUrlString];
    [self playAudioFileAtURL:fullUrl];
}

- (IBAction)stopPlaying:(id)sender {
    [self.player replaceCurrentItemWithPlayerItem:nil]; 
}

- (void)playAudioFileAtURL:(NSURL *)url {
    if (url) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL: url];
        self.player = [AVPlayer playerWithPlayerItem: item];
        [self.player play];
    } else {
        NSLog(@"Something went wrong");
    }
}

@end
