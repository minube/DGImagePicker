//
//  MNImagePicker.h
//  minube
//
//  Created by Daniel García on 20/3/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraOverlayView.h"
#import "AGImagePickerController.h"
#import "SSPhotoCropperViewController.h"
typedef enum{
    DGAssetsTypeAll = 0,
    DGAssetsTypeOnlyPhotos,
    DGAssetsTypeOnlyVideos
}DGAssetsType;
typedef void (^DGIPDidSuccess)(NSArray *info);
typedef void (^DGIPDidFail)(NSError *error);
@interface DGImagePicker : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,AGImagePickerControllerDelegate,CameraOverlayViewDelegate,SSPhotoCropperDelegate>{
    
}
@property (retain,nonatomic) NSArray *selectedAssetsURLS;
- (DGImagePicker *)initWithDelegate:(id)delegate successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (void)agImagePickerController:(AGImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)agImagePickerController:(AGImagePickerController *)picker didFail:(NSError *)error;
- (void) presentCameraPicker;
- (void) presentGalleryPicker;
@end;
