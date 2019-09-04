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
    
}

- (void)setUpMultiple:(NSInteger)count {
    if (count > 2) {
        
    } else {
        
    }
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

}

@end
