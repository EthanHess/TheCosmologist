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
        self.backgroundColor = [UIColor blackColor];
        [self viewStylizer:self]; 
    }
    return self;
}

- (CGRect)textFrame {
    return CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 80);
}

- (CGRect)buttonFrame {
    return CGRectMake(10, self.frame.size.height - 60, self.frame.size.width - 20, 40);
}

- (void)congifureViews {
    if (self.textView == nil) {
        self.textView = [[UITextView alloc]initWithFrame:[self textFrame]];
        self.textView.editable = NO;
        self.textView.textAlignment = NSTextAlignmentCenter;
        self.textView.textColor = [UIColor whiteColor];
        self.textView.backgroundColor = [UIColor blackColor];
        [self viewStylizer:self.textView];
        [self addSubview:self.textView];
    }
    if (self.dismissButton == nil) {
        self.dismissButton = [[UIButton alloc]initWithFrame:[self buttonFrame]];
        [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissTapped) forControlEvents:UIControlEventTouchUpInside];
        [self viewStylizer:self.dismissButton];
        [self addSubview:self.dismissButton];
    }
}

- (void)viewStylizer:(UIView *)theView {
    theView.layer.masksToBounds = YES;
    theView.layer.cornerRadius = 5;
    theView.layer.borderColor = [[UIColor whiteColor]CGColor];
    theView.layer.borderWidth = 1;
}

- (void)dismissTapped {
    [self.delegate handleDismiss];
}

- (void)setDescriptionText:(NSString *)descriptionText {
    self.textView.text = descriptionText;
}

@end
