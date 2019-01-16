//
//  Picture+CoreDataProperties.h
//  
//
//  Created by Ethan Hess on 1/15/19.
//
//

#import "Picture+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

+ (NSFetchRequest<Picture *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) Album *album;

@end

NS_ASSUME_NONNULL_END
