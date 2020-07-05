//
//  DescriptionPresenter.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/5/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import "DescriptionPresenter.h"

@interface DescriptionPresenter()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *dismissButton;

@end

@implementation DescriptionPresenter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self congifureViews];
    }
    return self;
}

- (void)congifureViews {
    
}

- (void)setDescriptionText:(NSString *)descriptionText {
    //TODO animate on
}

@end
