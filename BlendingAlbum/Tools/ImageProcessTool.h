//
//  ImageProcessTool.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/14.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProcessTool : NSObject

+ (instancetype)sharedInstance;

- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;

- (UIImage *)imageFromImage:(UIImage *)image atFrame:(CGRect)rect;

- (UIImage *)imageBlending;

- (void)switchImage;

- (UIImage *)addImage;

- (UIImage *)addImage:(CGFloat)backgroundAlpha;

- (UIImage *)capture:(UIView *) theView;

@property (nonatomic,strong) UIImage * backgroundImage;

@property (nonatomic,strong) UIImage * foregroundImage;

@end
