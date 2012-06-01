//
//  ImagePreviewViewController.m
//  minube
//
//  Created by Daniel García on 27/05/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import "ImagePreviewViewController.h"

@interface ImagePreviewViewController ()
@property (retain,nonatomic) UIImage *previewImage;
@property (nonatomic, strong) BJImageCropper *imageCropper;
@end

@implementation ImagePreviewViewController
@synthesize imageCropper=_imageCropper;
@synthesize previewImage=_previewImage;
- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.previewImage=image;
    }
    return self;
}

- (void)updateDisplay {
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:self.imageCropper] && [keyPath isEqualToString:@"crop"]) {
        [self updateDisplay];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect viewFrame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-20, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame=viewFrame;
    LogFrame(viewFrame);
    /*
    UIImageView *previewImageView=[[[UIImageView alloc]initWithImage:self.previewImage]autorelease];
    previewImageView.frame=self.view.frame;
    [self.view addSubview:previewImageView];
    self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    LogFrame(previewImageView.frame);
    LogFrame(self.view.frame);
    */
    CGRect imagePreviewCropperFrame=viewFrame;
    LogFrame(imagePreviewCropperFrame);
    self.imageCropper = [[BJImageCropper alloc] initWithFrame:imagePreviewCropperFrame];
    self.imageCropper.image=self.previewImage;
//    self.imageCropper = [[BJImageCropper alloc] initWithImage:self.previewImage andMaxSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.imageCropper];
    self.imageCropper.center = self.view.center;
    self.imageCropper.imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imageCropper.imageView.layer.shadowRadius = 3.0f;
    self.imageCropper.imageView.layer.shadowOpacity = 0.8f;
    self.imageCropper.imageView.layer.shadowOffset = CGSizeMake(1, 1);    
    self.imageCropper.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.imageCropper addObserver:self forKeyPath:@"crop" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
    [_imageCropper release];
    [_previewImage release];
    [super dealloc];
}
@end
