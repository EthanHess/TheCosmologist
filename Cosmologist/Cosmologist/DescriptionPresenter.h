//
//  DescriptionPresenter.h
//  Cosmologist
//
//  Created by Ethan Hess on 7/5/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DescriptionPresenterDelegate <NSObject>

@required

- (void)handleDismiss;

@end

@interface DescriptionPresenter : UIView

@property (nonatomic, weak) id <DescriptionPresenterDelegate> delegate;

- (void)setDescriptionText:(NSString *)descriptionText; 

@end

NS_ASSUME_NONNULL_END
