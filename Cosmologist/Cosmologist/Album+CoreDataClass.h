//
//  Album+CoreDataClass.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

NS_ASSUME_NONNULL_BEGIN

@interface Album : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Album+CoreDataProperties.h"
