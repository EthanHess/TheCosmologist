//
//  TheVideo+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheVideo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TheVideo (CoreDataProperties)

+ (NSFetchRequest<TheVideo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) TheAlbumV *albumV;

@end

NS_ASSUME_NONNULL_END
