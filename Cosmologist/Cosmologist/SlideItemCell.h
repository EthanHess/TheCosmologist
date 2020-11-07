//
//  SlideItemCell.h
//  Cosmologist
//
//  Created by Ethan Hess on 11/6/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *theLabel;

@end

NS_ASSUME_NONNULL_END
