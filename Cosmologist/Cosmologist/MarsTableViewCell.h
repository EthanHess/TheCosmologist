//
//  MarsTableViewCell.h
//  Cosmologist
//
//  Created by Ethan Hess on 8/5/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *marsImageView;

@end
