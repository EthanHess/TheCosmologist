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

@import WebKit;

@interface MainViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *pictureTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageOrVideoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webViewURL;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSTimer *labelTimer;


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
    UIColor *theColor = [self shadowColorsForLabel][0];
    self.pictureTitle.layer.borderColor = [theColor CGColor];
    self.pictureTitle.textColor = theColor;
    self.pictureTitle.layer.borderWidth = 2;
    self.pictureTitle.layer.masksToBounds = NO;
    self.pictureTitle.clipsToBounds = YES;
    self.pictureTitle.numberOfLines = 0;
        
    [self getImageData];
    [self labelTimerSetup];
    
    //May not need if AFNetworking sends task to bg thread
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    //});
    
    //[self youtubeThumbnailTest];
    //[self deleteYoutubeTest];
}

- (void)labelTimerSetup {
    if (self.labelTimer == nil) {
        self.labelTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeLabelColor) userInfo:nil repeats:YES];
        //[self.labelTimer fire];
    }
}

- (void)changeLabelColor {
    int x = arc4random() % 8;
    UIColor *borderColor = [self shadowColorsForLabel][x];
    self.pictureTitle.layer.borderColor = borderColor.CGColor;
    self.pictureTitle.textColor = borderColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self labelPulsate];
    //[self addShadowToView:self.pictureTitle andColor:[self shadowColorsForLabel][0]];
}


- (void)labelPulsate {
    CABasicAnimation *pulsate = [CABasicAnimation animationWithKeyPath:@"transform"];
    pulsate.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    pulsate.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.75, .75, .75)];
    [pulsate setDuration:1.5];
    [pulsate setAutoreverses:YES];
    [pulsate setRepeatCount:HUGE_VALF];
    [self.pictureTitle.layer addAnimation:pulsate forKey:@"transform"];
}

- (void)addShadowToView:(UIView *)view andColor:(UIColor *)shadowColor {
    view.layer.shadowColor = shadowColor.CGColor;
    view.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 5.0;
    view.clipsToBounds = NO;
}

//TODO cycle through (will also use for SWReveal, make global?)
- (NSArray *)shadowColorsForLabel {
    UIColor *colorOne = [UIColor colorWithRed:124.0f/255.0f green:247.0f/255.0f blue:252.0f/255.0f alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:124.0f/255.0f green:252.0f/255.0f blue:230.0f/255.0f alpha:1.0];
    UIColor *colorThree = [UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:252.0f/255.0f alpha:1.0];
    UIColor *colorFour = [UIColor colorWithRed:13.0f/255.0f green:236.0f/255.0f blue:194.0f/255.0f alpha:1.0];
    UIColor *colorFive = [UIColor colorWithRed:13.0f/255.0f green:126.0f/255.0f blue:236.0f/255.0f alpha:1.0];
    UIColor *colorSix = [UIColor colorWithRed:176.0f/255.0f green:175.0f/255.0f blue:248.0f/255.0f alpha:1.0];
    UIColor *colorSeven = [UIColor colorWithRed:227.0f/255.0f green:175.0f/255.0f blue:248.0f/255.0f alpha:1.0];
    UIColor *colorEight = [UIColor colorWithRed:246.0f/255.0f green:101.0f/255.0f blue:159.0f/255.0f alpha:1.0];
    return @[colorOne, colorTwo, colorThree, colorFour, colorFive, colorSix, colorSeven, colorEight];
}

- (void)youtubeThumbnailTest {
    NSString *urlOne = @"https://www.youtube.com/watch?v=FEmoqRp8_dw";
    [[MediaController sharedInstance]addURLtoAlbum:urlOne about:@"One" andCreateNew:YES];
    dispatch_after(DISPATCH_TIME_NOW + 1, dispatch_get_main_queue(), ^{
        NSString *urlTwo = @"https://www.youtube.com/watch?v=pKSVYwl6-Mk";
        NSString *urlThree = @"https://www.youtube.com/watch?v=_X7i1ALXh8E";
        [[MediaController sharedInstance]addURLtoAlbum:urlTwo about:@"Two" andCreateNew:NO];
        [[MediaController sharedInstance]addURLtoAlbum:urlThree about:@"Three" andCreateNew:NO];
    });
}

- (void)deleteYoutubeTest {
    TheAlbumV *theAlbum = [[MediaController sharedInstance]videoAlbums][0];
    [[MediaController sharedInstance]removeVideoAlbum:theAlbum];
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
    
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    double dbVersion = [version doubleValue];
//    if (dbVersion < 1.04) {
//
//    } else {
//
//    }
    
    [self popAlertWithString:@"Options" andMessage:@""];
}

- (void)popAlertWithString:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImage *image = self.pictureView.image;
        if (image != nil) {
            TheAlbum *album = [[[MediaController sharedInstance]albums]lastObject];
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
            TheAlbumV *vAlbum = [[[MediaController sharedInstance]videoAlbums]lastObject];
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

//Do in disappear?
- (void)dealloc {
    if (self.labelTimer != nil) {
        [self.labelTimer invalidate];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"archiveSegue"]) {
        
    }
}


@end
