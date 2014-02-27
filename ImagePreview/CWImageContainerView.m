//
//  CWImageContainerView.m
//  coldjoke-ios-client
//
//  Created by iOS on 14-2-17.
//  Copyright (c) 2014年 Coldworks. All rights reserved.
//
#define PADDING 10
#import "CWImageContainerView.h"

@interface CWImageContainerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *saveImageButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation CWImageContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.zoomScrollView];
    [self.zoomScrollView addSubview:self.imageView];
    [self addSubview:self.saveImageButton];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)showSaveImageButton
{
    self.saveImageButton.hidden = NO;
}

- (void)hideSaveImageButton
{
    self.saveImageButton.hidden = YES;
}


#pragma mark - Property
- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentView.backgroundColor = [UIColor blackColor];
    }
    return _contentView;
}

- (UIScrollView *)zoomScrollView
{
    if (_zoomScrollView == nil) {
        _zoomScrollView = [[UIScrollView alloc]init];
        _zoomScrollView.delegate = self;
        _zoomScrollView.minimumZoomScale = 1.0;
        _zoomScrollView.maximumZoomScale = 3.0;
        
    }
    return _zoomScrollView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}


- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPreviewImage:)];
    }
    return _tapGestureRecognizer;
}

- (UIButton *)saveImageButton
{
    if (_saveImageButton == nil) {
        _saveImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveImageButton.frame = CGRectMake(PADDING, SCREENHEIGHT - PADDING - 35, 50, 25);
        _saveImageButton.hidden = YES;
        [_saveImageButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveImageButton addTarget:self action:@selector(saveImageToAlbum:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveImageButton;
}

#pragma mark - Actions

- (void)dismissPreviewImage:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(dismissImageDidTap:)]) {
        [self.delegate dismissImageDidTap:gesture];
    }
}

- (void)saveImageToAlbum:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(saveImageDidTap:)]) {
        [self.delegate saveImageDidTap:button];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

@end
