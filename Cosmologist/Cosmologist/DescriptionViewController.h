//
//  DescriptionViewController.h
//  Cosmologist
//
//  Created by Ethan Hess on 10/5/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

//Can discard this class

@interface DescriptionViewController : UIViewController <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

- (void)setString:(NSString *)descString; 

@end
