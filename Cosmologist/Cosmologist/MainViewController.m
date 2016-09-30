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
#import "Constants.h"
@import WebKit;

@interface MainViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *pictureTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageOrVideoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webViewURL;


@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_activityIndicator setHidesWhenStopped:YES]; 
    [_activityIndicator startAnimating];
    self.pictureTitle.text = @"Loading";
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self getImageData];
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.hidden = YES;
    
    SWRevealViewController *revealController = self.revealViewController;
    
    if (revealController) {
        
        [self.leftBarButton setTarget:self.revealViewController];
        [self.leftBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        //[self getImageData];
    }
    
}

- (void)getImageData {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/apod?api_key=%@", NASA_API_KEY];
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)urlString andCompletion:^(NSArray *nasaArray) {
        
        //NSLog(@"ARRAY %@", nasaArray);
        
        for (NSDictionary *dictionary in nasaArray) {
            
            NasaData *dataClass = [[NasaData alloc]initWithDictionary:dictionary];
            
            //NSURL *urlString = [NSURL URLWithString:dataClass.hdurlString];
            
            NSURL *urlString = [NSURL URLWithString:dataClass.urlString];
            
            NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
            
            if ([dataClass.mediaType isEqualToString:@"video"]) {
                
                [self setUpViewForVideoWithURLString:urlString andTitle:dataClass.title];
                
                [_activityIndicator stopAnimating];
            }
            
            else {
                
                self.pictureView.image = [UIImage imageWithData:pictureData];
                self.pictureTitle.text = dataClass.title;
                
                [_activityIndicator stopAnimating];
            }
        }
    }];
}

- (void)setUpViewForPicture {
    
    
    
}

//use webview to play youtube videos

- (void)setUpViewForVideoWithURLString:(NSURL *)urlString andTitle:(NSString *)title {
    
    self.webViewURL = (NSString *)urlString;
    
    _webView.hidden = NO;
    _webView.delegate = self;

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


- (IBAction)optionsButtonTapped:(id)sender {
    
    [self popAlertWithString:@"Options" andMessage:@""];
    
}

- (void)popAlertWithString:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImage *image = self.pictureView.image;
        
        if (image != nil) {
            
            [[MediaController sharedInstance]addImage:image];
        
        } else {
        
            NSLog(@"Only saving images for now"); //add alert and be able to save videos too
        
        }
        
    }];
    
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self shareContent];
        
    }];
    
    UIAlertAction *seeAction = [UIAlertAction actionWithTitle:@"See Saved Content" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"archiveSegue" sender:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Nevermind" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:saveAction];
    [alertController addAction:shareAction];
    [alertController addAction:seeAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"WEB STRING: %@", webView.request.URL.absoluteString);
}

- (void)shareContent {
    
    //add pop up to add title and cosmologist mark
    
    UIImage *image = self.pictureView.image;
    
    if (image != nil) {
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
    else if (self.webViewURL != nil) {
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[self.webViewURL] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
    else {
        
        NSLog(@"nada...");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"Memory warning received");
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"archiveSegue"]) {
        
        
    }
}


@end
