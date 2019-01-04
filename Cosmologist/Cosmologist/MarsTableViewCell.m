//
//  MarsTableViewCell.m
//  Cosmologist
//
//  Created by Ethan Hess on 8/5/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "MarsTableViewCell.h"
#import "CachedImage.h"

@implementation MarsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
- (void)setImageWithMarsData:(MarsData *)theData { //do outside of cell?
    if (theData.imageURLString) {
        UIImage *theImage = [[CachedImage sharedInstance]imageForKey:theData.imageURLString];
        if (theImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.marsImageView.image = theImage;
            });
        } else {
            
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:theData.imageURLString]];
        UIImage *imageFromData = [UIImage imageWithData:imageData];
        UIImage *scaledImage = [UIImage imageWithData:[self compressedImageData:imageFromData]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.marsImageView.image = scaledImage;
        });
            
        [[CachedImage sharedInstance]setImage:imageFromData forKey:theData.imageURLString];
        }
    }
}

//Make table view scroll smoothly

-(NSData *)compressedImageData:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    float compressionRate = 10;
    while (imageData.length > 1024)
    {
        if (compressionRate > 0.5)
        {
            compressionRate = compressionRate - 0.5;
            imageData = UIImageJPEGRepresentation(image, compressionRate / 10);
        }
        else
        {
            return imageData;
        }
    }
    return imageData;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.marsImageView.image = nil;
}

@end
