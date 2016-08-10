//
//  MainViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "NasaDataController.h"
#import "NasaData.h"
@import WebKit;

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *pictureTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageOrVideoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

//add activity view controller

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [self getImageData];
//        
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self getImageData];
        
    });
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealController = self.revealViewController;
    
    if (revealController) {
        
        [self.leftBarButton setTarget:self.revealViewController];
        [self.leftBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        //[self getImageData];
    }
    
}

- (void)getImageData {
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)@"" andCompletion:^(NSArray *nasaArray) {
        
        //NSLog(@"ARRAY %@", nasaArray);
        
        for (NSDictionary *dictionary in nasaArray) {
            
            //NSLog(@"DICTIONARY %@", dictionary);
            
            NasaData *dataClass = [[NasaData alloc]initWithDictionary:dictionary];
            
            //NSURL *urlString = [NSURL URLWithString:dataClass.hdurlString];
            
            NSURL *urlString = [NSURL URLWithString:dataClass.urlString];
            
            NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
            
            if ([dataClass.mediaType isEqualToString:@"video"]) {
                
                [self setUpViewForVideoWithURLString:urlString andTitle:dataClass.title];
            }
            
            else {
                
                self.pictureView.image = [UIImage imageWithData:pictureData];
                self.pictureTitle.text = dataClass.title;
            }
        }
    }];
    
}

- (void)setUpViewForPicture {
    
    
    
}

//use webview to play youtube videos

- (void)setUpViewForVideoWithURLString:(NSURL *)urlString andTitle:(NSString *)title {
    

    CGFloat width = self.pictureView.frame.size.width;
    CGFloat height = self.pictureView.frame.size.height;
    
    NSString *htmlString = [NSString stringWithFormat:@"<iframe width=\"%f\" height=\"%f\" src=\"%@/\" frameborder=\"0\" allowfullscreen></iframe>", width, height, (NSString *)urlString];

    
    [_webView loadHTMLString:htmlString baseURL:nil];
    _webView.mediaPlaybackRequiresUserAction = NO;
    _webView.allowsInlineMediaPlayback = YES;
    [_webView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    self.pictureTitle.text = title;
    self.imageOrVideoLabel.text = @"Video of the day!"; 
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
