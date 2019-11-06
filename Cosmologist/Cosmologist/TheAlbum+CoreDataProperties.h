//
//  TheAlbum+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheAlbum+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TheAlbum (CoreDataProperties)

+ (NSFetchRequest<TheAlbum *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<ThePicture *> *pictures;

@end

@interface TheAlbum (CoreDataGeneratedAccessors)

- (void)insertObject:(ThePicture *)value inPicturesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPicturesAtIndex:(NSUInteger)idx;
- (void)insertPictures:(NSArray<ThePicture *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePicturesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPicturesAtIndex:(NSUInteger)idx withObject:(ThePicture *)value;
- (void)replacePicturesAtIndexes:(NSIndexSet *)indexes withPictures:(NSArray<ThePicture *> *)values;
- (void)addPicturesObject:(ThePicture *)value;
- (void)removePicturesObject:(ThePicture *)value;
- (void)addPictures:(NSOrderedSet<ThePicture *> *)values;
- (void)removePictures:(NSOrderedSet<ThePicture *> *)values;

@end

NS_ASSUME_NONNULL_END
