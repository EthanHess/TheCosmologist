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
    //[self.thePlayer loadWithVideoId:@"3CccfnRpPtM"];
    [self.thePlayer loadWithVideoId:videoID];
    
    //[self.thePlayer playVideo];
    //Stop?
    
//    self.theImageView.hidden = YES;
//    self.theWebView.hidden = NO;
//    if (self.theWebView == nil) {
//        self.theWebView = [[UIWebView alloc]initWithFrame:self.contentView.bounds];
//        self.theWebView.delegate = self;
//        CGFloat width = self.contentView.frame.size.width;
//        CGFloat height = self.contentView.frame.size.height;
//        NSString *htmlString = [NSString stringWithFormat:@"<iframe width=\"%f\" height=\"%f\" src=\"%@/\" frameborder=\"0\" allowfullscreen></iframe>", width, height, (NSString *)self.videoURL];
//        [self.theWebView loadHTMLString:htmlString baseURL:nil];
//        self.theWebView.mediaPlaybackRequiresUserAction = NO;
//        self.theWebView.allowsInlineMediaPlayback = YES;
//        [self.theWebView setContentMode:UIViewContentModeScaleAspectFit];
//        [self.contentView addSubview:self.theWebView];
//    }
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
