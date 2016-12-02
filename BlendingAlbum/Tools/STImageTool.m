//
//  STImageTool.m
//  STImage
//
//  Created by huoqiuliang on 15/10/27.
//  Copyright © 2015年 sensetime. All rights reserved.
//

#import "STImageTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation STImageTool

+ (void)drawBGRAfromImage:(UIImage *)image cImage:(unsigned char *)cImage{
    CGImageRef cgImage = [image CGImage];
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    int iWidth = image.size.width;
    int iHeight = image.size.height;
    int iBytesPerPixel = 4;
    int iBytesPerRow = iBytesPerPixel * iWidth;
    int iBitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(cImage,
                                                 iWidth,
                                                 iHeight,
                                                 iBitsPerComponent,
                                                 iBytesPerRow,
                                                 colorspace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst
                                                 );
    CGRect rect = CGRectMake(0 , 0 , iWidth , iHeight);
    CGContextDrawImage(context , rect ,cgImage);
    CGColorSpaceRelease(colorspace);
    CGContextRelease(context);
    
}
+ (void)drawGrayfromImage:(UIImage *)image cImage:(unsigned char *)cImage{
    CGImageRef cgImage = [image CGImage];
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
    
    int iWidth = image.size.width;
    int iHeight = image.size.height;
    int iBytesPerPixel = 1;
    int iBytesPerRow = iBytesPerPixel * iWidth;
    int iBitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(cImage,
                                                 iWidth,
                                                 iHeight,
                                                 iBitsPerComponent,
                                                 iBytesPerRow,
                                                 colorspace,
                                                 kCGImageAlphaNone
                                                 );
    
    if (context == NULL) {
        return ;
    }
    CGRect rect = CGRectMake(0 , 0 , iWidth , iHeight);
    CGContextDrawImage(context , rect ,cgImage);
    CGColorSpaceRelease(colorspace);
    CGContextRelease(context);
}



+(UIImage *)getCustomSizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width,size.height));
    
    [image drawInRect:CGRectMake(0, 0, size.width , size.height)];
    UIImage *customSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return customSizeImage;
}


+ (UIImage *)geImagefromBGRA:(unsigned char *)BGRAimage imageSize:(CGSize)size{
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    int iBitsPerComponent = 8;
    int iBytesPerPixel = 4;
    int iBytesPerRow = iBytesPerPixel * size.width;
    CGContextRef context = CGBitmapContextCreate(BGRAimage,
                                                 size.width,
                                                 size.height,
                                                 iBitsPerComponent,
                                                 iBytesPerRow,
                                                 colorspace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);

    
    CGImageRef iOffscreen = CGBitmapContextCreateImage(context);
    
    UIImage* image = [UIImage imageWithCGImage: iOffscreen];
    CGColorSpaceRelease(colorspace);
    CGContextRelease(context);
    
    return image;
}


+ (BOOL)judgingCameraState{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请在隐私设置中打开相机授权" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        
        NSLog(@"哈哈哈哈");

        return NO;
    }
    return YES;
}

+ (BOOL)judgingPhotoLibraryState{
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请在隐私设置中打开相机授权" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;
}
@end
