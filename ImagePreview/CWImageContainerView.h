//
//  CWImageContainerView.h
//  coldjoke-ios-client
//
//  Created by iOS on 14-2-17.
//  Copyright (c) 2014年 Coldworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@protocol CWImageContainerViewDelegate;
@interface CWImageContainerView : UIView

@property (nonatomic, strong) UIScrollView *zoomScrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) id<CWImageContainerViewDelegate>delegate;

- (void)showSaveImageButton;
- (void)hideSaveImageButton;

@end

@protocol CWImageContainerViewDelegate <NSObject>

- (void)dismissImageDidTap:(UIGestureRecognizer *)gesture;
- (void)saveImageDidTap:(UIButton *)button;

@end