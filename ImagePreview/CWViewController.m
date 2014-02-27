//
//  CWViewController.m
//  ImagePreview
//
//  Created by iOS on 14-2-27.
//  Copyright (c) 2014年 iOS. All rights reserved.
//

#import "CWViewController.h"
#import "CWImagePreviewer.h"
@interface CWViewController ()

@property (nonatomic,strong)CWImagePreviewer *imagePreviewer;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UITapGestureRecognizer *tap;

@end

@implementation CWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.imageView addGestureRecognizer:self.tap];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageDidTap:(UITapGestureRecognizer *)gesture
{
    [self.imagePreviewer previewImageView:self.imageView];
}

#pragma mark - Property
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImage *image = [UIImage imageNamed:@"image.png"];
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake(50, 50, width/4, height/4);
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UITapGestureRecognizer *)tap
{
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidTap:)];
    }
    return  _tap;
}

- (CWImagePreviewer *)imagePreviewer
{
    if (_imagePreviewer == nil) {
        _imagePreviewer = [[CWImagePreviewer alloc] init];
    }
    return _imagePreviewer;
}
@end
