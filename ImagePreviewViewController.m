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
@end

@implementation ImagePreviewViewController
@synthesize previewImage=_previewImage;
- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.previewImage=image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *previewImageView=[[[UIImageView alloc]initWithImage:self.previewImage]autorelease];
    previewImageView.frame=self.view.frame;
    [self.view addSubview:previewImageView];
    self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-20, self.view.frame.size.width, self.view.frame.size.height);
    LogFrame(previewImageView.frame);
    LogFrame(self.view.frame);
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
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
    [_previewImage release];
    [super dealloc];
}
@end
