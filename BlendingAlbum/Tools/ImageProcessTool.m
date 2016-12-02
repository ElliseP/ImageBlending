//
//  ImageProcessTool.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/14.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "ImageProcessTool.h"
#import "cv_imagesdk.h"
#import "STImageTool.h"
#import <SVProgressHUD.h>
#import "ToolMacroes.h"
#import <OpenGLES/ES2/gl.h>

@implementation ImageProcessTool

+ (instancetype)sharedInstance{
    static ImageProcessTool * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineHeight*width/height;
    CGFloat targetHeight = defineHeight;
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageFromImage:(UIImage *)image atFrame:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage * resultImage = [UIImage imageWithCGImage:imageRef];
    return resultImage;
}

- (UIImage *)imageBlending{
    CGFloat width = self.backgroundImage.size.width;
    CGFloat height = self.backgroundImage.size.height;
    __block cv_result_t result;
    __block UIImage * resultImage = nil;
    
   // dispatch_async(dispatch_get_main_queue(), ^{
        unsigned char * originalcImage = (unsigned char *)malloc(width * height * 4);
        [STImageTool drawBGRAfromImage:self.backgroundImage cImage:originalcImage];
        
        unsigned char * frontcImage = (unsigned char *)malloc(width * height * 4);
        UIImage * fImage = [STImageTool getCustomSizeImage:[self imageByApplyingAlpha:0.1f image:self.foregroundImage] size:CGSizeMake(width, height)];
        [STImageTool drawBGRAfromImage:fImage cImage:frontcImage];
        
        UIImage *maskImage = [UIImage imageNamed:@"maskPossionBlending@2x.png"];
        maskImage = [STImageTool getCustomSizeImage:maskImage size:CGSizeMake(width, height)];
        unsigned char *maskCImage = (unsigned char*)malloc(maskImage.size.width * maskImage.size.height * 1);
        [STImageTool drawGrayfromImage:maskImage cImage:maskCImage];
        
        unsigned char *outBGRAImage  = (unsigned char *)malloc(width * height * 4);
        result = cv_imagesdk_possion_blending(originalcImage, CV_PIX_FMT_BGRA8888, width, height, width *4, frontcImage, CV_PIX_FMT_BGRA8888, width, height, width * 4, maskCImage, CV_PIX_FMT_GRAY8, width, height, width, outBGRAImage, CV_PIX_FMT_BGRA8888, width, height, width * 4);
        NSLog(@"Blending Finish");
        
        free(originalcImage);
        free(frontcImage);
        free(maskCImage);
        
        if (result ==CV_OK) {
            resultImage = [STImageTool geImagefromBGRA:outBGRAImage imageSize:CGSizeMake(width, height)];
            UIImageWriteToSavedPhotosAlbum(resultImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            free(outBGRAImage);
        }
   // });
   return resultImage;
}

- (void)switchImage{
    UIImage * img = self.backgroundImage;
    self.backgroundImage = self.foregroundImage;
    self.foregroundImage = img;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)addImage{
    UIImage * resultImage = [self addImage:0.5];
    return resultImage;
}

- (UIImage *)addImage:(CGFloat)backgroundAlpha{
    NSLog(@"begin time");
    CGFloat width = self.backgroundImage.size.width;
    CGFloat height = self.backgroundImage.size.height;
    
    NSLog(@"1");
    UIGraphicsBeginImageContext(self.backgroundImage.size);
    NSLog(@"2");
  //  UIImage * bImage = [self imageByApplyingAlpha:backgroundAlpha image:self.backgroundImage];
    [self.backgroundImage drawInRect:CGRectMake(0, 0, width, height) blendMode:kCGBlendModeNormal alpha:backgroundAlpha];
    NSLog(@"3");
   // UIImage * fImage = [self imageByApplyingAlpha:(1-backgroundAlpha) image:self.foregroundImage];
    [self.foregroundImage drawInRect:CGRectMake(0, 0, width, height) blendMode:kCGBlendModeNormal alpha:1-backgroundAlpha];
    NSLog(@"4");
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"5");
    UIGraphicsEndImageContext();
    NSLog(@"end time");
    
   // UIImageWriteToSavedPhotosAlbum(resultingImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
   
    return resultingImage;
}


- (UIImage *)capture:(UIView *) theView{
    // 创建一个context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH), theView.opaque, 0.0);
    
    //把当前的全部画面导入到栈顶context中并进行渲染
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 从当前context中创建一个新图片
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return img;
}

- (unsigned char *) convertUIImageToBitmapBGR8:(UIImage *) image {
    
    CGImageRef imageRef = image.CGImage;
    
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    
    if(!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imageRef);
    
    // Get a pointer to the data
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    
    unsigned char *newBitmap = NULL;
    
    if(bitmapData) {
        newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
        
        if(newBitmap) {	// Copy the data
            for(int i = 0,j = 0; i < bufferLength; i++) {
                if ((i+1)%4) {
                    newBitmap[j++] = bitmapData[i];
                }
            }
        }
        free(bitmapData);
        
    } else {
        NSLog(@"Error getting bitmap pixel data\n");
    }
    
    CGContextRelease(context);
    
    return newBitmap;
}

- (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef) image {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);	// RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}


@end
