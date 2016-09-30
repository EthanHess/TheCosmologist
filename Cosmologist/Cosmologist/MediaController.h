//
//  MediaController.h
//  Cosmologist
//
//  Created by Ethan Hess on 9/28/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Picture.h"
#import "CoreDataStack.h"

@interface MediaController : NSObject

@property (nonatomic, strong) NSArray *pictures;

+ (MediaController *)sharedInstance;

- (void)addImage:(UIImage *)image;

- (void)removePicture:(Picture *)picture; 

@end
