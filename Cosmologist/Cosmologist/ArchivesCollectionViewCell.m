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

- (void)setUpWebView {
    if (!self.videoURL) {
        return;
    }
    
    NSString *videoID = [self cutYoutubeURLforIDOnly:self.videoURL];
    
    self.thePlayer = [[YTPlayerView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.thePlayer];
    [self.thePlayer loadWithVideoId:videoID];
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
