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
#import "DescriptionPresenter.h"
#import "TimeZoneHelper.h" //utils
#import "LoadingAnimationView.h"

@import WebKit;

@interface MainViewController () <UIWebViewDelegate, DescriptionPresenterDelegate>

//MARK: Properties (nonatomic = fast, non-thread safe property)

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *pictureTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageOrVideoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *webViewURL;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSTimer *labelTimer;

//Custom classes
@property (nonatomic, strong) DescriptionPresenter *descPresenter;
@property (nonatomic, strong) LoadingAnimationView *loadingView;
           
//Typewriter effect
@property (nonatomic, strong) NSString *typingText;
@property (nonatomic, strong) NSTimer *typingTimer;
@property (nonatomic, assign) NSInteger typingIndex;

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
    
    //May not need if AFNetworking sends task to bg thread
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    //});
    
    //[self youtubeThumbnailTest];
    //[self deleteYoutubeTest];
    
    //TODO tweak UI / presentation
    //[self loadingViewSetup];
    
    [self descriptionPresenterSetup];
}

- (void)loadingViewSetup {
    if (self.loadingView == nil) {
        //TODO update frame, this is just for test
        self.loadingView = [[LoadingAnimationView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, self.view.frame.size.height / 3)];
        self.loadingView.hidden = YES;
        [self.view addSubview:self.loadingView];
    }
}

//TODO top navigation light mode/ dark mode

#pragma mark desc. delegate + setup
//NOTE: Mixing code and storyboards is generally not the best practice, but for this case it's okay.
- (void)descriptionPresenterSetup {
    if (self.descPresenter == nil) {
        self.descPresenter = [[DescriptionPresenter alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, self.view.frame.size.height - 200)];
        self.descPresenter.delegate = self;
        self.descPresenter.hidden = YES;
        [self.view addSubview:self.descPresenter];
    }
    [self descriptionShowHideHandler:NO]; //If reappearing, hide
//    [self getImageData];
    [self labelTimerSetup];
    
    UIImage *image = [[CachedImage sharedInstance]imageForKey:@"lastImageURLKey"];
    if (image != nil) {
        //Set then check if need to refresh or type is now video
        [self setImage:image];
        self.pictureTitle.text = [TimeZoneHelper lastTitle];
        self.descriptionString = [TimeZoneHelper lastDescription];
    } else {
        [self getImageData];
    }
}

- (void)handleDismiss {
    [self descriptionShowHideHandler:NO];
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
//    NSString *urlOne = @"https://www.youtube.com/watch?v=FEmoqRp8_dw";
    NSString *urlTwo = @"https://www.youtube.com/watch?v=pKSVYwl6-Mk";
    NSString *urlThree = @"https://www.youtube.com/watch?v=_X7i1ALXh8E";
//    [[MediaController sharedInstance]addURLtoAlbum:urlOne about:@"One" andCreateNew:YES];
    [[MediaController sharedInstance]addURLtoAlbum:urlTwo about:@"Two" andCreateNew:NO];
    [[MediaController sharedInstance]addURLtoAlbum:urlThree about:@"Three" andCreateNew:NO];
}

- (void)deleteYoutubeTest {
    AlbumV *theAlbum = [[MediaController sharedInstance]videoAlbums][0];
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

//TODO, cache image then clear every 24 hours (but check to see if URL is different since sometimes they update the API late

//Use Eastern time (NASA's API uses this to change image every 24 hrs)
//Store current day in defaults, if different day, or current time is after midnight mark, fetch new data

//NSLocalized Strings for desc.

//FLOW

//Fetch image / video from cache regardless, if within 24 hours
//Check if needs updates in the background
//Update and refresh if needed

- (void)hideShowLoadingViewOnMainThread:(BOOL)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadingView.hidden = hide;
    });
}

- (void)getImageData {
    
    //Key should be hidden in .gitignore file but it's free and a test so just for future reference
    NSString *urlString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/apod?api_key=%@", NASA_API_KEY];
    
    //[self hideShowLoadingViewOnMainThread:NO];
    [[NasaDataController sharedInstance]getNasaInfoWithURL:(NSURL *)urlString andCompletion:^(NSArray *nasaArray) {
        
        //Can just grab first element of array since they'll be one, if not one we'll log it and see what's happening

        for (NSDictionary *dictionary in nasaArray) {
            NasaData *dataClass = [[NasaData alloc]initWithDictionary:dictionary];
            
            NSURL *urlString = [NSURL URLWithString:dataClass.urlString];
            NSData *pictureData = [NSData dataWithContentsOfURL:urlString];
            NSLog(@"DATA CLASS %@", dataClass);
            
            //[self hideShowLoadingViewOnMainThread:YES];
            
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
                
                [TimeZoneHelper setTitleInDefaults:dataClass.title];
                [TimeZoneHelper setDescriptionInDefaults:dataClass.explanation];
            }
        }
    }];
}

- (void)setImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self typeWriterEffectWithText:@"Image of the day"];
        self.pictureView.image = image;
        [self.activityIndicator stopAnimating];
    });
    
    [[CachedImage sharedInstance]setImage:image forKey:@"lastImageURLKey"];
}

- (void)descriptionShowHideHandler:(BOOL)show {
    [self dimHandlerForDescriptionPresentation:show];
    self.descPresenter.hidden = !show;
    [self.descPresenter setDescriptionText:self.descriptionString];
}

- (void)dimHandlerForDescriptionPresentation:(BOOL)dim {
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[DescriptionPresenter class]]) {
            view.alpha = dim == YES ? 0.7 : 1;
        }
    }
}


- (IBAction)labelTapped:(id)sender {
    [self descriptionShowHideHandler:YES];
    
    //TODO discard this after test
    
//    DescriptionViewController *descVC = [self newFromStoryboard];
//    [descVC setString:self.descriptionString];
//    [self presentViewController:descVC animated:YES completion:nil];
}

//Modal pop would be better

//Use subview, don't need to leave main view
- (DescriptionViewController *)newFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"Description"];
}

//use webview to play youtube videos

//TODO check if URL is different from last URL and use cached image if not, create custom loading icon and fetch new one if it is

//TODO for video as well
- (NSString *)cachedURLImage {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"lastImage"];
}

//TODO call
- (void)checkImageCacheAndLoadLastBeforeRequest {
    if (![self cachedURLImage]) {
        //fetch
        return;
    }
    UIImage *cachedImage = [[CachedImage sharedInstance]imageForKey:[self cachedURLImage]];
    if (cachedImage) {
        //Set UIImageView then make call to see if updated
    } else {
        //Just make call
    }
}

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
   // self.imageOrVideoLabel.text = @"Video of the day!";
    
    [self typeWriterEffectWithText:@"Video of the day"];
}

- (void)typeWriterEffectWithText:(NSString *)text {
    self.typingText = text;
    self.typingIndex = 1;
    self.typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(type) userInfo:nil repeats:YES];
    
}

- (void)type {
    if ([self.typingText length] >= self.typingIndex) {
        self.imageOrVideoLabel.text = [NSString stringWithFormat:@"%@", [self.typingText substringToIndex:self.typingIndex++]];
    } else {
        [self.typingTimer invalidate];
    }
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
