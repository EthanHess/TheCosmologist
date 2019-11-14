//
//  AlbumV+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 11/13/19.
//
//

#import "AlbumV+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AlbumV (CoreDataProperties)

+ (NSFetchRequest<AlbumV *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<Video *> *videos;

@end

@interface AlbumV (CoreDataGeneratedAccessors)

- (void)insertObject:(Video *)value inVideosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVideosAtIndex:(NSUInteger)idx;
- (void)insertVideos:(NSArray<Video *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVideosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVideosAtIndex:(NSUInteger)idx withObject:(Video *)value;
- (void)replaceVideosAtIndexes:(NSIndexSet *)indexes withVideos:(NSArray<Video *> *)values;
- (void)addVideosObject:(Video *)value;
- (void)removeVideosObject:(Video *)value;
- (void)addVideos:(NSOrderedSet<Video *> *)values;
- (void)removeVideos:(NSOrderedSet<Video *> *)values;

@end

NS_ASSUME_NONNULL_END
