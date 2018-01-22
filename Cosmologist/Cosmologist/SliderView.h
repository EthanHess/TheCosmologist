//
//  SliderView.h
//  Cosmologist
//
//  Created by Ethan Hess on 11/6/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderValueUpdatedDelegate <NSObject>

@required

- (void)updateColorWithRed:(float)red green:(float)green blue:(float)blue;

@end

@interface SliderView : UIView

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
    
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (nonatomic) float redValue;
@property (nonatomic) float greenValue;
@property (nonatomic) float blueValue;

@property (nonatomic, weak) id <SliderValueUpdatedDelegate> delegate;



@end
