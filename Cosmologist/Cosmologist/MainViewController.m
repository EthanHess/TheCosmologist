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
#import "DescriptionViewController.h"
#import "CachedImage.h"
#import "Album+CoreDataClass.h"
#import "AlbumV+CoreDataClass.h"

@import WebKit;

@interface MainViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *pictureTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageOrVideoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webViewURL;
@property (nonatomic, strong) NSString *descriptionString;


@end

@implementation MainViewController
    
#pragma Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self renderBarButtonNicely];
    
    [self.activityIndicator setHidesWhenStopped:YES];
    [self.activityIndicator startAnimating];
    self.pictureTitle.text = @"Loading";
    
    self.pictureTitle.layer.cornerRadius = 40;
    self.pictureTitle.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.pictureTitle.layer.borderWidth = 2;
    
    [self getImageData];
    
    //May not need if AFNetworking sends task to bg thread
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    //});
}

- (void)renderBarButtonNicely {
    UIImage *image = [[UIImage imageNamed:@"mainGalaxy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftBarButton.image = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.hidden = YES;
    
    SWRevealViewController *revealController = self.revealViewController;
    if (revealController) {
        [self.leftBarButton setTarget:self.revealViewController];
        [self.leftBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)getImageData {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/apod?api_key=%@", NASA_API_KEY];
    
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)urlString andCompletion:^(NSArray *nasaArray) {
        
        //Can just grab first element of array since they'll be one, if not one we'll log it and see what's happening

        for (NSDictionary *dictionary in nasaArray) {
            NasaData *dataClass = [[NasaData alloc]initWithDictionary:dictionary];
            
            NSURL *urlString = [NSURL URLWithString:dataClass.urlString];
            NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
            NSLog(@"DATA CLASS %@", dataClass);
            
            if ([dataClass.mediaType isEqualToString:@"video"]) {
                self.descriptionString = dataClass.explanation;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setUpViewForVideoWithURLString:urlString andTitle:dataClass.title];
                    [self.activityIndicator stopAnimating];
                });
            } else {
                UIImage *imageFromData = [UIImage imageWithData:pictureData];
                [self setImage:imageFromData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pictureTitle.text = dataClass.title;
                    self.descriptionString = dataClass.explanation;
                });
            }
        }
    }];
}

- (void)setImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pictureView.image = image;
        [self.activityIndicator stopAnimating];
    });
}

- (IBAction)labelTapped:(id)sender {
    DescriptionViewController *descVC = [self newFromStoryboard];
    [descVC setString:self.descriptionString];
    [self presentViewController:descVC animated:YES completion:nil]; 
}

//Modal pop would be better
- (DescriptionViewController *)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"Description"];
}

//use webview to play youtube videos

- (void)setUpViewForVideoWithURLString:(NSURL *)urlString andTitle:(NSString *)title {
    
    self.webViewURL = urlString.absoluteString;
    self.webView.hidden = NO;
    self.webView.delegate = self;

    CGFloat width = self.pictureView.frame.size.width;
    CGFloat height = self.pictureView.frame.size.height;
    
    NSString *htmlString = [NSString stringWithFormat:@"<iframe width=\"%f\" height=\"%f\" src=\"%@/\" frameborder=\"0\" allowfullscreen></iframe>", width, height, (NSString *)urlString];

    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.webView.mediaPlaybackRequiresUserAction = NO;
    self.webView.allowsInlineMediaPlayback = YES;
    [self.webView setContentMode:UIViewContentModeScaleAspectFit];
    
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
            Album *album = [[[MediaController sharedInstance]albums]lastObject];
            //Can DRY (one line)
            if (album != nil && album.pictures.count < 11) {
                [[MediaController sharedInstance]addPictureToAlbum:image about:self.descriptionString new:NO];
            } else {
                //Add to new album here
                [[MediaController sharedInstance]addPictureToAlbum:image about:self.descriptionString new:YES];
            }
        } else {
            if (!self.webViewURL) {
                NSLog(@"No Web View"); //Alert, also make sure it's checking for desc. string
                return;
            }
            AlbumV *vAlbum = [[[MediaController sharedInstance]videoAlbums]lastObject];
            if (vAlbum != nil && vAlbum.videos.count < 11) {
                [[MediaController sharedInstance]addURLtoAlbum:self.webViewURL about:self.descriptionString andCreateNew:NO];
            } else {
                [[MediaController sharedInstance]addURLtoAlbum:self.webViewURL about:self.descriptionString andCreateNew:YES];
            }
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

- (void)onlySavingImagesAlert {
    UIAlertController *imageAlertController = [UIAlertController alertControllerWithTitle:@"Only saving images for now" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [imageAlertController addAction:okayAction];
    [self presentViewController:imageAlertController animated:YES completion:nil];
}

#pragma WebView

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"WEB STRING: %@", webView.request.URL.absoluteString);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"ERROR %@", error);
}

- (void)shareContent {
    //add pop up to add title and cosmologist mark
    UIImage *image = self.pictureView.image;
    if (image != nil) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    } else if (self.webViewURL != nil) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[self.webViewURL] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    } else {
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
