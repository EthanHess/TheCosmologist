//
//  SoundCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/29/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "SoundCell.h"

@implementation SoundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
