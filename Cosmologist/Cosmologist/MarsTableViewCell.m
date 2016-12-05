//
//  MarsTableViewCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/5/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MarsTableViewCell.h"

@implementation MarsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
- (void)setImageWithMarsData:(MarsData *)theData {
    
    if (theData.imageURLString) {
        
        self.marsImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:theData.imageURLString]]]; 
    }
}

@end
