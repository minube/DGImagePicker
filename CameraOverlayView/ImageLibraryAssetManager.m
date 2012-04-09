//
//  ImageLibraryAssetManager.m
//  JSoto
//
//  Created by Javier Soto on 2/15/12.
//  Copyright (c) 2012 JSoto, Inc. All rights reserved.
//

#import "ImageLibraryAssetManager.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation ImageLibraryAssetManager

+ (void)loadLastPhotoTakenWithCallback:(ImageLibraryAssetPhotoRetrieveBlock)block
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    __block BOOL imageFound = NO;
    
    dispatch_queue_t currentQueue = dispatch_get_current_queue();
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:[group numberOfAssets]-1] options:0 usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
            if (alAsset)
            {
                *innerStop = YES;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                    
                    UIImage *thumbnail = [UIImage imageWithCGImage:[alAsset thumbnail]];
                    UIImage *fullScreenImage = [UIImage imageWithCGImage:[representation fullScreenImage]];
                    
                    imageFound = YES;
                    dispatch_async(currentQueue, ^{
                        block(thumbnail, fullScreenImage);
                    });
                });
            }
            else
            {
                if (!imageFound)
                {
                    NSLog(@"%s no image found", (char *)_cmd);
                    dispatch_async(currentQueue, ^{
                        block(nil, nil);
                    });
                }
            }
        }];
    } failureBlock: ^(NSError *error) {
        // Typically you should handle an error more gracefully than this.
        NSLog(@"%s error getting last image: %@", (char *)_cmd, error);
        block(nil, nil);
    }];
    [library release];
}

@end
