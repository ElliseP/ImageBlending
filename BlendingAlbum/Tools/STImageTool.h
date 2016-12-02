//
//  STImageTool.h
//  STImage
//
//  Created by huoqiuliang on 15/10/27.
//  Copyright © 2015年 sensetime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface STImageTool : NSObject

+ (void)drawBGRAfromImage:(UIImage *)image cImage:(unsigned char *)cImage;

/** UIImage转为灰度图*/
+ (void)drawGrayfromImage:(UIImage *)image cImage:(unsigned char *)cImage;


/** 重绘任意大小的图像*/
+(UIImage *)getCustomSizeImage:(UIImage *)image size:(CGSize)size;


+ (UIImage *)geImagefromBGRA:(unsigned char *)BGRAimage imageSize:(CGSize)size;


/** 判断相机的授权状态*/
+ (BOOL)judgingCameraState;
/** 判断相册的授权状态*/
+ (BOOL)judgingPhotoLibraryState;


@end
