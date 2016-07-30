//
//  SoundCell.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/29/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

static NSString *const SOUND_CLOUD_CLIENT_ID = @"";
static NSString *const CLIENT_PREFIX = @"?client_id=";

@interface SoundCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *soundTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *soundDescLabel;
@property (strong, nonatomic) IBOutlet UIButton *soundPlayButton;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *soundURL;

- (IBAction)playSound:(id)sender;

@end
