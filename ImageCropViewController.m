//
//  ImageCropViewController.m
//  minube
//
//  Created by Daniel García on 25/4/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import "ImageCropViewController.h"

@interface ImageCropViewController ()
@property (retain,nonatomic) UIImage *imageToCrop;
@end

@implementation ImageCropViewController
@synthesize scrollView;
@synthesize imageView,imageToCrop;

- (id)initWithImage:(UIImage*)image{
    self = [super initWithNibName:@"ImageCropViewController" bundle:nil];
    if (self) {
        self.imageToCrop=image;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image=self.imageToCrop;
    self.navigationController.navigationBarHidden=YES;
    self.scrollView.delegate=self;    
    self.scrollView.minimumZoomScale=self.imageView.image.scale;
    self.scrollView.maximumZoomScale=3.0f;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageToCrop release];
    [imageView release];
    [scrollView release];
    [super dealloc];
}
- (IBAction)cancelButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    LogMethod();
    return self.imageView;
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    LogMethod();
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    LogMethod();
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
self.imageView.image.size
    LogMethod();
}

- (IBAction)confirmButtonAction:(id)sender {
}
@end
