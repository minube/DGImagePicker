//
//  ImageLibraryAssetManager.h
//  JSoto
//
//  Created by Javier Soto on 2/15/12.
//  Copyright (c) 2012 JSoto, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImageLibraryAssetPhotoRetrieveBlock)(UIImage *thumbnail, UIImage *fullResolutionImage);

@interface ImageLibraryAssetManager : NSObject

+ (void)loadLastPhotoTakenWithCallback:(ImageLibraryAssetPhotoRetrieveBlock)block;

@end
