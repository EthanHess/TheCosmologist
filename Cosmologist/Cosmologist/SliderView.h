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
- (void)updateMapViewWithIndex:(NSInteger)index;

@end

@interface SliderView : UIView

@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UISlider *blueSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;

@property (nonatomic) float redValue;
@property (nonatomic) float greenValue;
@property (nonatomic) float blueValue;

@property (nonatomic, strong) id <SliderValueUpdatedDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;


@end
