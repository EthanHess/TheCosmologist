//
//  Video+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "Video+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) AlbumV *albumV;

@end

NS_ASSUME_NONNULL_END
