//
//  MNImagePicker.m
//  minube
//
//  Created by Daniel García on 20/3/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import "DGImagePicker.h"
#import "CustomImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface DGImagePicker(){
}
@property (assign,nonatomic) id presentedPicker;
@property (assign,nonatomic) UIView* frontView;
@property (assign,nonatomic) UIView* backView;
@property (retain,nonatomic) CameraOverlayView *cameraOverlay;
@property (retain,nonatomic) UIImagePickerController *cameraPicker;
@property (retain,nonatomic) AGImagePickerController *galleryPicker;
@property (copy,nonatomic) DGIPDidSuccess successBlock;
@property (copy,nonatomic) DGIPDidFail failureBlock;
- (void)cameraOverlayViewGalleryButtonPressed:(CameraOverlayView *)cameraOverlayView;
- (void)cameraOverlayView:(CameraOverlayView *)cameraOverlayView lastPictureFromGalleryLoaded:(UIImage *)lastPictureFromGallery;
- (void)cameraOverlayViewDidDisappearFromScreen:(CameraOverlayView *)cameraOverlayView;
- (void)cameraOverlayViewGalleryButtonPressed:(CameraOverlayView *)cameraOverlayView AnimationDuration:(CGFloat)duration;
- (void)galleryCameraButtonPressedWithAnimationDuration:(CGFloat)duration;
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end
@implementation DGImagePicker
@synthesize successBlock,failureBlock;
@synthesize cameraPicker,cameraOverlay,galleryPicker;
@synthesize frontView,backView;
@synthesize presentedPicker;
- (DGImagePicker *)initWithDelegate:(id)delegate successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock
{
    return [self initWithDelegate:delegate assetsType:DGAssetsTypeAll successBlock:_successBlock failureBlock:_failureBlock];
}
- (DGImagePicker *)initWithDelegate:(id)delegate assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock
{
    return [self initWithDelegate:delegate maxItems:nil assetsType:assetsType successBlock:_successBlock failureBlock:_failureBlock];
}
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock
{
    return [self initWithDelegate:delegate maxItems:maxItems assetsType:DGAssetsTypeAll successBlock:_successBlock failureBlock:_failureBlock];
}
- (DGImagePicker *)initWithDelegate:(id)delegate maxItems:(NSNumber *)maxItems assetsType:(DGAssetsType)assetsType successBlock:(DGIPDidSuccess)_successBlock failureBlock:(DGIPDidFail)_failureBlock
{    
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        self.failureBlock=_failureBlock;
        self.successBlock=_successBlock;
        BOOL photoAndVideoCamera=NO;
        
        self.galleryPicker= [[[AGImagePickerController alloc]initWithDelegate:self failureBlock:nil successBlock:nil maximumNumberOfPhotos:0 shouldChangeStatusBarStyle:NO toolbarItemsForSelection:nil andShouldDisplaySelectionInformation:NO]autorelease];             
        switch (assetsType) {
            case DGAssetsTypeOnlyPhotos:
                photoAndVideoCamera=NO;
                self.galleryPicker.assetsFilter=[ALAssetsFilter allPhotos];
                break;
            case DGAssetsTypeOnlyVideos:
                photoAndVideoCamera=NO;
                self.galleryPicker.assetsFilter=[ALAssetsFilter allVideos];
                break;
            case DGAssetsTypeAll:
            default:
                photoAndVideoCamera=YES;
                self.galleryPicker.assetsFilter=[ALAssetsFilter allAssets];
                break;
        }
        if(maxItems)
            self.galleryPicker.maximumNumberOfPhotos=[maxItems intValue];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.cameraOverlay=[[[CameraOverlayView alloc]initWithFrame:self.view.frame]autorelease]; 
            self.cameraOverlay.delegate=self;
            [self.cameraOverlay updateLastPhotoTaken];
            self.cameraPicker= [[[CustomImagePickerController alloc] init]autorelease];
            self.cameraPicker.delegate = self;
            self.cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.cameraPicker.cameraOverlayView = self.cameraOverlay;        
            self.cameraPicker.showsCameraControls=NO;
            self.cameraPicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
            self.cameraOverlay.cameraPicker=self.cameraPicker;
            // Gallery to Camera Switch
            self.galleryPicker.toolbarRightButton=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(galleryCameraButtonPressed)]autorelease];
            self.cameraOverlay.photoAndVideo=photoAndVideoCamera;
        }                
        if(self.cameraPicker){
            self.presentedPicker=self.cameraPicker;
            [self.view addSubview:self.cameraPicker.view];
        }else{
            self.presentedPicker=self.galleryPicker;
            [self.view addSubview:self.galleryPicker.view];
        }        
    }
    return self;
}
-(void)loadView{
    CGRect viewFrame=[[UIScreen mainScreen] bounds];
    self.view=[[[UIView alloc]initWithFrame:viewFrame]autorelease];    
    self.wantsFullScreenLayout=YES;
}
- (void)viewDidLoad{
    [super viewDidLoad];
}
- (void)galleryCameraButtonPressed{
    [self galleryCameraButtonPressedWithAnimationDuration:0.8];
}
- (void)galleryCameraButtonPressedWithAnimationDuration:(CGFloat)duration{
    [UIView transitionFromView:self.galleryPicker.view toView:self.cameraPicker.view duration:duration options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        if(finished){
            self.presentedPicker=self.cameraPicker;            
        }
    }];
    
}
- (void)cameraOverlayViewGalleryButtonPressed:(CameraOverlayView *)cameraOverlayView{
    [self cameraOverlayViewGalleryButtonPressed:cameraOverlayView AnimationDuration:0.8];
}
- (void)cameraOverlayViewGalleryButtonPressed:(CameraOverlayView *)cameraOverlayView AnimationDuration:(CGFloat)duration{
    [UIView transitionFromView:self.cameraPicker.view toView:self.galleryPicker.view duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        if(finished){
            self.presentedPicker=self.galleryPicker;                                 
        }
    }];    
}
- (void) presentCameraPicker{
    if(![self.presentedPicker isKindOfClass:[self.cameraPicker class]] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        [self galleryCameraButtonPressedWithAnimationDuration:0.0];
}
- (void) presentGalleryPicker{
    if(![self.presentedPicker isKindOfClass:[self.galleryPicker class]])
        [self cameraOverlayViewGalleryButtonPressed:self.cameraOverlay AnimationDuration:0.0];
}

-(void)cameraCancel{    
    if(self.failureBlock){
        self.failureBlock(nil);
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSArray *infoArray=nil;
    if(info){        
        if([[info objectForKey:@"UIImagePickerControllerMediaType"]isEqualToString:@"public.image"]){
            infoArray=[NSArray arrayWithObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
        }else if([[info objectForKey:@"UIImagePickerControllerMediaType"]isEqualToString:@"public.movie"]){
            NSString *videoFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
            if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoFilePath))
            {
                UISaveVideoAtPathToSavedPhotosAlbum(videoFilePath, self, @selector(video:didFinishSavingWithError:contextInfo:), videoFilePath);
            } 
        }
    }
    if(self.successBlock){
        self.successBlock(infoArray);
    }
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"Finished saving video with error: %@", error);
}
- (void)agImagePickerController:(AGImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    if(self.successBlock){
        self.successBlock(info);
    }
}
- (void)agImagePickerController:(AGImagePickerController *)picker didFail:(NSError *)error{
    if(self.failureBlock){
        self.failureBlock(error);
    }
}

- (void)cameraOverlayView:(CameraOverlayView *)cameraOverlayView lastPictureFromGalleryLoaded:(UIImage *)lastPictureFromGallery{
 
}
- (void)cameraOverlayViewDidDisappearFromScreen:(CameraOverlayView *)cameraOverlayView{
}
-(void)viewWillAppear:(BOOL)animated{ 
    [super viewWillAppear:animated];    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];    
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.cameraOverlay resetOriginalState];
}
-(void)dealloc{
    [cameraOverlay release];
    [cameraPicker release];
    [galleryPicker release];
    [super dealloc];
}
@end
