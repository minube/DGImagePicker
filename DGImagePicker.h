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
typedef void (^DGIPDidSuccess)(NSArray *info);
typedef void (^DGIPDidFail)(NSError *error);
@interface DGImagePicker : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,AGImagePickerControllerDelegate,CameraOverlayViewDelegate>{
    
}
- (DGImagePicker *)initWithDelegate:(id)delegate successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock;
- (void)agImagePickerController:(AGImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)agImagePickerController:(AGImagePickerController *)picker didFail:(NSError *)error;
- (void) presentCameraPicker;
- (void) presentGalleryPicker;
@end;
