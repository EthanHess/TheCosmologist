//
//  AsteroidTableViewCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/15/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "AsteroidTableViewCell.h"

@implementation AsteroidTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)milesOrKilometersInDiameter:(id)sender {
    
    switch (self.milesKMSegControl.selectedSegmentIndex) {
            
        case 0:
            
            self.diameterLabel.text = [self diameterString:self.data.estimatedDiameterMilesMax];
            
            break;
            
        case 1:
            
            self.diameterLabel.text = [self diameterString:self.data.estimatedDiameterKilometersMax];
            
            break;
            
        default:
            break;
    }
}

- (IBAction)openURL:(id)sender {
    
    NSURL* urlToOpen = [NSURL URLWithString:[self.urlButton titleForState:UIControlStateNormal]];
    
    if ([[UIApplication sharedApplication]canOpenURL:urlToOpen]) {
        [[UIApplication sharedApplication]openURL:urlToOpen]; 
    }
}

- (NSString *)diameterString:(NSString *)doubleValueString {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:[doubleValueString floatValue]]];
    
    return numberString;
    
}

@end
