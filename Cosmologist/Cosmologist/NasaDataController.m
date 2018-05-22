//
//  NasaDataController.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "NasaDataController.h"

@implementation NasaDataController

+ (NasaDataController *)sharedInstance {
    static NasaDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [NasaDataController new];
    });
    
    return sharedInstance;
    
}


- (void)getNasaInfoWithURL:(NSURL *)url andCompletion:(void (^)(NSArray *nasaArray))completion {
    
    NSString *urlString = (NSString *)url;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            
            NSDictionary *resultDictionary = result;
            NSMutableArray *temporaryArray = [[NSMutableArray alloc]init];
            [temporaryArray addObject:resultDictionary];
            
            completion(temporaryArray);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"--- ERROR FETCHING DATA --- %@", error.localizedDescription);
        }];
}

@end
