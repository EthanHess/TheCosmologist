//
//  Album+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "Album+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Album (CoreDataProperties)

+ (NSFetchRequest<Album *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<Picture *> *pictures;

@end

@interface Album (CoreDataGeneratedAccessors)

- (void)insertObject:(Picture *)value inPicturesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPicturesAtIndex:(NSUInteger)idx;
- (void)insertPictures:(NSArray<Picture *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePicturesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPicturesAtIndex:(NSUInteger)idx withObject:(Picture *)value;
- (void)replacePicturesAtIndexes:(NSIndexSet *)indexes withPictures:(NSArray<Picture *> *)values;
- (void)addPicturesObject:(Picture *)value;
- (void)removePicturesObject:(Picture *)value;
- (void)addPictures:(NSOrderedSet<Picture *> *)values;
- (void)removePictures:(NSOrderedSet<Picture *> *)values;

@end

NS_ASSUME_NONNULL_END
