//
//  CWImagePreviewer.h
//  coldjoke-ios-client
//
//  Created by iOS on 14-2-17.
//  Copyright (c) 2014年 Coldworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWImagePreviewer : NSObject
{
    CGRect _originFrame;
    UIImage *_originImage;
}

@property (readonly) CGRect originFrame;
@property (nonatomic, strong, readonly) UIImage *originImage;

- (void)previewImageView:(UIImageView *)imageView;

@end
