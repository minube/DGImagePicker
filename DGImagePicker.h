//
//  DGImagePicker.h
//  
//  Created by Daniel García on 20/3/12.
//  Copyright (c) 2012. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DGImagePickerConstants.h"
#import "CameraOverlayView.h"
#import "AGImagePickerController.h"
typedef enum{
    DGAssetsTypeAll = 0,
    DGAssetsTypeOnlyPhotos,
    DGAssetsTypeOnlyVideos
}DGAssetsType;
typedef void (^DGIPDidSuccess)(NSArray *info);
typedef void (^DGIPDidFail)(NSError *error);
@interface DGImagePicker : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,AGImagePickerControllerDelegate,CameraOverlayViewDelegate>{
    
}
@property (retain,nonatomic) NSArray *selectedAssetsURLS;
- (DGImagePicker *)initWithDelegate:(id)delegate successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems assetsType:(DGAssetsType)assetsType showPreview:(BOOL)showPreview successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (void)agImagePickerController:(AGImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)agImagePickerController:(AGImagePickerController *)picker didFail:(NSError *)error;
- (void) presentCameraPicker;
- (void) presentGalleryPicker;
@end;
