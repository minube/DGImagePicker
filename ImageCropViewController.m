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
@synthesize topMask;
@synthesize rightMask;
@synthesize bottomMask;
@synthesize leftMask;
@synthesize imageView,imageToCrop;

- (id)initWithImage:(UIImage*)image{
    self = [super initWithNibName:@"ImageCropViewController" bundle:nil];
    if (self) {
        self.imageToCrop=image;
    }
    return self;
}
- (void)updateInsetsForScale:(CGFloat)scale{
    DebugLog(@"%f",scale);
    CGFloat fitScale;
    if(self.imageView.image.size.width>=self.imageView.image.size.height){
        fitScale=self.imageView.frame.size.height/self.imageView.image.size.height;
    }else {
        fitScale=self.imageView.frame.size.width/self.imageView.image.size.width;
    }
    CGFloat imageScaledHeight=self.imageView.image.size.height*fitScale;
    CGFloat imageScaledWidth=self.imageView.image.size.width*fitScale;
    CGRect cropRectangle=CGRectMake(self.leftMask.frame.size.width, self.topMask.frame.size.height, self.scrollView.frame.size.width-self.leftMask.frame.size.width-self.rightMask.frame.size.width, self.scrollView.frame.size.height-self.topMask.frame.size.height-self.bottomMask.frame.size.height);
    
    CGFloat verticalOffset=(((imageScaledHeight-self.scrollView.frame.size.height)/scale)+self.topMask.frame.size.width+self.bottomMask.frame.size.width)/2;;
    CGFloat horizontalOffset=(((imageScaledWidth-self.scrollView.frame.size.width)/scale)+self.leftMask.frame.size.width+self.rightMask.frame.size.width)/2;
    DebugLog(@"%f %f - %f %f",verticalOffset,horizontalOffset,imageScaledWidth,imageScaledHeight);
    verticalOffset=verticalOffset>0.0?verticalOffset:0.0;
    horizontalOffset=horizontalOffset>0.0?horizontalOffset:0.0;
    
    LogFrame(cropRectangle);
    DebugLog(@"%f %f %f %f",verticalOffset,horizontalOffset,horizontalOffset,verticalOffset);
    //self.scrollView.contentInset=UIEdgeInsetsMake(verticalOffset,horizontalOffset,horizontalOffset,verticalOffset);
    self.scrollView.contentInset=UIEdgeInsetsMake(53, horizontalOffset, 53, horizontalOffset);
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
    [self updateInsetsForScale:0.0];
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [self setTopMask:nil];
    [self setRightMask:nil];
    [self setBottomMask:nil];
    [self setLeftMask:nil];
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
    [topMask release];
    [rightMask release];
    [bottomMask release];
    [leftMask release];
    [super dealloc];
}
- (IBAction)cancelButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    LogMethod();
    [self updateInsetsForScale:scale];
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
 
}

- (IBAction)confirmButtonAction:(id)sender {
}
@end
