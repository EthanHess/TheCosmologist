//
//  Video+CoreDataProperties.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
//
//

#import "Video+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) AlbumV *albumV;

@end

NS_ASSUME_NONNULL_END
