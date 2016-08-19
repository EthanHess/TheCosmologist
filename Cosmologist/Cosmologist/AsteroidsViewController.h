//
//  AsteroidsViewController.h
//  Cosmologist
//
//  Created by Ethan Hess on 8/12/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface AsteroidsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDate *now;
@property (nonatomic, strong) NSDate *inTwentyFour;
@property (nonatomic, strong) NSString *dateOne;
@property (nonatomic, strong) NSString *dateTwo;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;


@end
