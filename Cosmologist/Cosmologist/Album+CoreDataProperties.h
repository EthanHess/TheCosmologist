//
//  Album+CoreDataProperties.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
//
//

#import "Album+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Album (CoreDataProperties)

+ (NSFetchRequest<Album *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

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
