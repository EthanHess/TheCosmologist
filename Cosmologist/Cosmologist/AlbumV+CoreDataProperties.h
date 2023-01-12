//
//  AlbumV+CoreDataProperties.h
//  Cosmologist
//
//  Created by Ethan Hess on 1/12/23.
//  Copyright © 2023 Ethan Hess. All rights reserved.
//
//

#import "AlbumV+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AlbumV (CoreDataProperties)

+ (NSFetchRequest<AlbumV *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

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
