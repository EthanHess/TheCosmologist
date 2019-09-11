//
//  ArchivesCollectionViewCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 9/30/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ArchivesCollectionViewCell.h"

@implementation ArchivesCollectionViewCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"-- Did awake from Nib --");
}

- (void)setUpMultiple:(NSInteger)count {
    if (count > 2) {
        [self multiSetup:NO andCount:3];
    } else {
        [self multiSetup:NO andCount:2];
    }
}

- (void)multiSetup:(BOOL)remove andCount:(NSInteger)count {
    if (remove == YES) {
        if (self.multiImageOne != nil) {
            [self.multiImageOne removeFromSuperview];
            self.multiImageOne = nil;
        }
        if (self.multiImageTwo != nil) {
            [self.multiImageTwo removeFromSuperview];
            self.multiImageTwo = nil;
        }
        if (self.multiImageThree != nil) {
            [self.multiImageThree removeFromSuperview];
            self.multiImageThree = nil;
        }
    } else { //TODO deck of cards effect
        CGFloat parentWidth = self.theImageView.frame.size.width;
        CGFloat parentHeight = self.theImageView.frame.size.height;
        if (count > 2) {
            CGFloat dimensionThreeWidth = parentWidth - 60;
            CGFloat dimensionThreeHeight = parentHeight - 60;
            self.multiImageOne = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, dimensionThreeWidth, dimensionThreeHeight)];
            self.multiImageOne.image = [self fromData:self.firstData];
            [self.theImageView addSubview:self.multiImageOne];
            self.multiImageTwo = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, dimensionThreeWidth, dimensionThreeHeight)];
            self.multiImageTwo.image = [self fromData:self.secondData];
            [self.theImageView addSubview:self.multiImageTwo];
            self.multiImageThree = [[UIImageView alloc]initWithFrame:CGRectMake(45, 45, dimensionThreeWidth, dimensionThreeHeight)];
            self.multiImageThree.image = [self fromData:self.thirdData];
            [self.theImageView addSubview:self.multiImageThree];
        } else {
            CGFloat dimensionTwoWidth = parentWidth - 60; //TODO update
            CGFloat dimensionTwoHeight = parentHeight - 60;
            self.multiImageOne = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, dimensionTwoWidth, dimensionTwoHeight)];
            self.multiImageOne.image = [self fromData:self.firstData];
            [self.theImageView addSubview:self.multiImageOne];
            self.multiImageTwo = [[UIImageView alloc]initWithFrame:CGRectMake(40, 40, dimensionTwoWidth, dimensionTwoHeight)];
            self.multiImageTwo.image = [self fromData:self.secondData];
            [self.theImageView addSubview:self.multiImageTwo];
        }
    }
}

- (UIImage *)fromData:(NSData *)data {
    if (!data) {
        return [UIImage imageNamed:@"earthButton"]; //default
    }
    UIImage *imageToReturn = [UIImage imageWithData:data];
    return imageToReturn != nil ? imageToReturn : [UIImage imageNamed:@"earthButton"];
}

- (void)childIVStyle:(UIImageView *)iv {
    iv.layer.cornerRadius = 5;
    iv.layer.masksToBounds = YES; //Border color ?
}

- (NSString *)cutYoutubeURLforIDOnly:(NSString *)fullURlString {
    return [fullURlString stringByReplacingOccurrencesOfString:@"https://www.youtube.com/watch?v=" withString:@""];
}

- (NSString *)cutYoutubeEmbedURL:(NSString *)fullUrlString {
    return [fullUrlString stringByReplacingOccurrencesOfString:@"https://www.youtube.com/embed/" withString:@""];
}

- (void)setUpWebView {
    if (!self.videoURL) {
        return;
    }
    
    NSString *videoID = @"";
    if ([self.videoURL containsString:@"watch"]) {
        videoID = [self cutYoutubeURLforIDOnly:self.videoURL];
    }
    if ([self.videoURL containsString:@"embed"]) {
        videoID = [self cutYoutubeEmbedURL:self.videoURL];
    }
    
    self.thePlayer = [[YTPlayerView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.thePlayer];
    [self.thePlayer loadWithVideoId:videoID];
}

- (void)clearPlayerForImageModeIfExists {
    if (self.thePlayer != nil) {
        [self.thePlayer removeFromSuperview];
        self.thePlayer = nil;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"WEB STRING: %@", webView.request.URL.absoluteString);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"ERROR %@", error);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self multiSetup:YES andCount:0];
}

@end
