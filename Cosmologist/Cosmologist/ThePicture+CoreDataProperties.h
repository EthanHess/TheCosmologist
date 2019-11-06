//
//  ThePicture+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "ThePicture+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ThePicture (CoreDataProperties)

+ (NSFetchRequest<ThePicture *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) TheAlbum *album;

@end

NS_ASSUME_NONNULL_END
