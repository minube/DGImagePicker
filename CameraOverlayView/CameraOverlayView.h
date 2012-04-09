//
//  CameraOverlayView.h
//  JSoto
//
//  Created by Javier Soto on 2/20/12.
//  Copyright (c) 2012 JSoto, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraOverlayView;

@protocol CameraOverlayViewDelegate <NSObject>
- (void)cameraOverlayViewGalleryButtonPressed:(CameraOverlayView *)cameraOverlayView;
- (void)cameraOverlayView:(CameraOverlayView *)cameraOverlayView lastPictureFromGalleryLoaded:(UIImage *)lastPictureFromGallery;
@optional
- (void)cameraCancel;
- (void)cameraOverlayViewDidDisappearFromScreen:(CameraOverlayView *)cameraOverlayView;
@end

@interface CameraOverlayView : UIView

@property (nonatomic,assign) UIImagePickerController *cameraPicker;
@property (nonatomic, assign) id<CameraOverlayViewDelegate> delegate;

- (void)updateLastPhotoTaken;
- (void)controlsHidden:(BOOL)hidden;
- (void)resetOriginalState;
@end
