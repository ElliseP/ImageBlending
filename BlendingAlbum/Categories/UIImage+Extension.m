//
//  UIImage+Extension.m
//  图片裁剪
//
//  Created by  霍秋亮 on 15/8/8.
//  Copyright (c) 2015年 huohuo. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color{
    CGFloat borderW = border;

    UIImage *oldImage = [UIImage imageNamed:name];
    
    CGFloat imageW =  oldImage.size.width + 2 * borderW;
    CGFloat imageH =  oldImage.size.height + 2 * borderW;
    
    //设置新的图片尺寸
    CGFloat circirW = imageW >imageH ? imageH:imageW;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirW, circirW), NO, 0.0);
    
    //画大圆
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circirW, circirW)];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    [color set];
    CGContextFillPath(ctx);
    CGRect clipR = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    
    [clipPath addClip];
    
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
+ (instancetype)imageWithCaptureView:(UIView *)view{
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype )imageWithFileName:(NSString *)name{
    
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    
    if ([components count] >=2) {
        NSUInteger lastIndex = components.count -1;
        extension =[components objectAtIndex:lastIndex];
        name = [name substringToIndex:(name.length - (extension.length +1))];
    }
    //如果为Retain 屏幕且存在对应图片，则返回Retain 图片，否则查找普通图片
    
    if ([UIScreen mainScreen].scale ==2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:extension];
        if (path !=nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale ==3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:extension];
        if (path !=nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}

- (UIImage *)imageScaleToSize:(CGSize)size{
    //创建一个bitmap的context，并把它设置为当前正在使用的额context
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
