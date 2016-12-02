//
//  UIImage+Extension.h
//  图片裁剪
//
//  Created by  霍秋亮 on 15/8/8.
//  Copyright (c) 2015年 huohuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  裁剪图片为圆形并且设置边框
 *
 *  @param name   图片名称
 *  @param border 圆环的宽度
 *  @param color  圆环的颜色
 *
 *  @return 新的UIimage
 */
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 *  @return 返回截取的图像
 */
+ (instancetype)imageWithCaptureView:(UIView *)view;
/**
 * 一次性加载@x,@2x,@3x的图片
 *
 *  @param name imageName
 *
 *  @return image
 */
+ (instancetype )imageWithFileName:(NSString *)name;

/**
 *  设置图片大小
 *
 *  @param size 图片的大小
 *
 */
- (UIImage *)imageScaleToSize:(CGSize)size;
/** 利用UIColor 生成UIImage */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
