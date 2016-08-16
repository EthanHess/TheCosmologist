//
//  AsteroidTableViewCell.h
//  Cosmologist
//
//  Created by Ethan Hess on 8/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsteroidData.h"

@interface AsteroidTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *urlButton;
@property (strong, nonatomic) IBOutlet UILabel *diameterLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *milesKMSegControl;

@property (nonatomic, strong) AsteroidData *data; //to change seg control and grab values from within

@end
