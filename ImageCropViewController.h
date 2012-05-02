//
//  ImageCropViewController.h
//  minube
//
//  Created by Daniel García on 25/4/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCropViewController : UIViewController<UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *topMask;
@property (retain, nonatomic) IBOutlet UIView *rightMask;
@property (retain, nonatomic) IBOutlet UIView *bottomMask;
@property (retain, nonatomic) IBOutlet UIView *leftMask;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)confirmButtonAction:(id)sender;
- (id)initWithImage:(UIImage*)image;
@end
