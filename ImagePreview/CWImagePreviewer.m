//
//  CWImagePreviewer.m
//  coldjoke-ios-client
//
//  Created by iOS on 14-2-17.
//  Copyright (c) 2014年 Coldworks. All rights reserved.
//

#import "CWImagePreviewer.h"
#import "CWImageContainerView.h"

@interface CWImagePreviewer()<CWImageContainerViewDelegate>
{
    BOOL saveImageToAlbumSucceeded;
}

@property (nonatomic, strong) CWImageContainerView *imageContainerView;

@end

@implementation CWImagePreviewer

- (void)previewImageView:(UIImageView *)imageView{
    UIImage *image = imageView.image;
    CGRect frame = [imageView convertRect:imageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    [self previewImage:image withFrame:frame];
}

- (void)previewImage:(UIImage *)image withFrame:(CGRect)frame
{
    _originImage = image;
    _originFrame = frame;
    
    [self hideStatusBar];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.imageContainerView];
    
    self.imageContainerView.imageView.image = image;
    
    [self scaleImage:image withFrame:frame];
}

- (void)scaleImage:(UIImage *)image withFrame:(CGRect)frame
{
    [self hideSaveImageButton];
    
    CGFloat originImageWith = image.size.width;
    CGFloat originImageHeight = image.size.height;
    
    CGFloat calculatedWidth = SCREENWIDTH;
    CGFloat calculatedHeight = calculatedWidth / originImageWith * originImageHeight;
    
    self.imageContainerView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.imageContainerView.zoomScrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.imageContainerView.zoomScrollView.contentSize = CGSizeMake(calculatedWidth, calculatedHeight);
    self.imageContainerView.imageView.frame = frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (calculatedHeight <= SCREENHEIGHT) {
            self.imageContainerView.imageView.frame = CGRectMake(0, (SCREENHEIGHT - calculatedHeight)/2, calculatedWidth, calculatedHeight);
        }
        else{
            self.imageContainerView.imageView.frame = CGRectMake(0, 0, calculatedWidth, calculatedHeight);
        }
        
    } completion:^(BOOL finished) {
        [self performSelector:@selector(showSaveImageButton) withObject:nil afterDelay:0.01];
    }];
}

- (void)hideSaveImageButton
{
    [self.imageContainerView hideSaveImageButton];
}

- (void)showSaveImageButton
{
    [self.imageContainerView showSaveImageButton];
}

- (void)showStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)hideStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark - Property
- (CWImageContainerView *)imageContainerView
{
    if (_imageContainerView == nil) {
        _imageContainerView = [[CWImageContainerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _imageContainerView.delegate = self;
    }
    return _imageContainerView;
}


#pragma mark - CWImageContainerViewDelegate Methods
- (void)dismissImageDidTap:(UIGestureRecognizer *)gesture
{
    [self showStatusBar];
    
    // 防止回到主界面的时候才显示出 Status Bar
    double delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.imageContainerView removeFromSuperview];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.imageContainerView.imageView.frame];
        imageView.image = self.originImage;
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:imageView];
        
        [UIView animateWithDuration:0.25 animations:^{
            imageView.frame = self.originFrame;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    });

}

- (void)saveImageDidTap:(UIButton *)button{
    if (!saveImageToAlbumSucceeded)
    {
        UIImageWriteToSavedPhotosAlbum(self.originImage, nil, nil, nil);
        [self imageDidSaveToAlbum];
        saveImageToAlbumSucceeded = YES;
    }
    else
    {
        [self imageHasBeenSavedOnce];
    }

}
- (void)imageDidSaveToAlbum
{
    NSLog(@"Image saved succeeded!");
    
}

- (void)imageHasBeenSavedOnce
{
    NSLog(@"Image has been saved once!");
}

@end
