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

@property (strong, nonatomic) NSData *firstData;
@property (strong, nonatomic) NSData *secondData;
@property (strong, nonatomic) NSData *thirdData;

@property (strong, nonatomic) UIImageView *multiImageOne;
@property (strong, nonatomic) UIImageView *multiImageTwo;
@property (strong, nonatomic) UIImageView *multiImageThree; //for multiple images in album

- (void)setUpWebView;
- (void)setUpMultiple:(NSInteger)count; //show first few images of album, deck of cards stlye :)
- (void)clearPlayerForImageModeIfExists;

@end
