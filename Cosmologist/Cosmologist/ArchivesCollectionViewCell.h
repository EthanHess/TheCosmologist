//
//  ArchivesCollectionViewCell.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>
@import WebKit;

@interface ArchivesCollectionViewCell : UICollectionViewCell <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) UIWebView *theWebView; //For test, make IBOutlet just for consistency?
@property (strong, nonatomic) NSString *videoURL;
@property (strong, nonatomic) YTPlayerView *thePlayer;

- (void)setUpWebView; 

@end
