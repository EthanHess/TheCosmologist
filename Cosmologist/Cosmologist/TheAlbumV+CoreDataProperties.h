//
//  TheAlbumV+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/6/19.
//
//

#import "TheAlbumV+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TheAlbumV (CoreDataProperties)

+ (NSFetchRequest<TheAlbumV *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<TheVideo *> *videos;

@end

@interface TheAlbumV (CoreDataGeneratedAccessors)

- (void)insertObject:(TheVideo *)value inVideosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVideosAtIndex:(NSUInteger)idx;
- (void)insertVideos:(NSArray<TheVideo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVideosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVideosAtIndex:(NSUInteger)idx withObject:(TheVideo *)value;
- (void)replaceVideosAtIndexes:(NSIndexSet *)indexes withVideos:(NSArray<TheVideo *> *)values;
- (void)addVideosObject:(TheVideo *)value;
- (void)removeVideosObject:(TheVideo *)value;
- (void)addVideos:(NSOrderedSet<TheVideo *> *)values;
- (void)removeVideos:(NSOrderedSet<TheVideo *> *)values;

@end

NS_ASSUME_NONNULL_END
