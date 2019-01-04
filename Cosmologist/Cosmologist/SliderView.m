//
//  SliderView.m
//  Cosmologist
//
//  Created by Ethan Hess on 11/6/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "SliderView.h"

@implementation SliderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.redValue = self.redSlider.value;
    self.greenValue = self.greenSlider.value;
    self.blueValue = self.blueSlider.value;
    self.doneButton.layer.cornerRadius = 10;
}


- (IBAction)dismissSelf:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        [self setHidden:YES];
    }];
}


- (IBAction)redValueChanged:(UISlider *)sender {
    self.redValue = sender.value;
    [self.delegate updateColorWithRed:_redValue green:_greenValue blue:_blueValue];
}

- (IBAction)greenValueChanged:(UISlider *)sender {
    self.greenValue = sender.value;
    [self.delegate updateColorWithRed:_redValue green:_greenValue blue:_blueValue];
}

- (IBAction)blueValueChanged:(UISlider *)sender {
    self.blueValue = sender.value;
    [self.delegate updateColorWithRed:_redValue green:_greenValue blue:_blueValue];
}

@end
