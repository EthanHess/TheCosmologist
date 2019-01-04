//
//  DescriptionViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 10/5/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@property (nonatomic) BOOL isPresenting;
@property (nonatomic, strong) NSString *descriptionString; 
@property (strong, nonatomic) IBOutlet UITextView *theTextView;

@end

@implementation DescriptionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        //TODO: implement
    }
    return self;
}


- (void)setString:(NSString *)descString {
    self.descriptionString = descString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isPresenting = YES;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.transitioningDelegate = self;
    self.view.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.3];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self blurEffect];
    
    if (self.descriptionString) {
        self.theTextView.text = self.descriptionString;
    } else {
        NSLog(@"No string, darn it.");
    }
}

- (void)blurEffect {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view insertSubview:blurEffectView atIndex:0];
}

#pragma Delegation 

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.isPresenting = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.isPresenting == YES) {
        [containerView addSubview:[toViewController view]];
        toViewController.view.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [[fromViewController view]removeFromSuperview];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
