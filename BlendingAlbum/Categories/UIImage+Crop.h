//
//  UIImage+Crop.h
//  beauty
//
//  Created by 肖伟华 on 15/10/15.
//  Copyright © 2016年 SenseTime All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

/** 缩小图片 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (UIImage *)cropImage:(UIImage *)image atRect:(CGRect) rect ;

// image 且原图
+ (UIImage *)circleImageWithImage:(UIImage *)imageOrigin borderWidth:(CGFloat)borderWidth bgColor:(UIColor *)bgColor;
@end
