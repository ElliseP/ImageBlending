//
//  UIView+Extension.m
//  NewProjectTool
//
//  Created by  霍秋亮 on 15/9/29.
//  Copyright © 2015年 huohuo. All rights reserved.
//

#import "UIView+Extension.h"
#import "UIImage+Extension.h"
#import <objc/runtime.h>
// 定义静态常量字符串
#define UIViewstaticConstString(__string)               static const char * __string = #__string;


@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
    
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)addLineWithLineType:(lineViewType)type color:(UIColor*)color lineWidth:(CGFloat)width{

    if (type &LineViewTypeTop) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), width);
        [self.layer addSublayer:layer];
    }
    if (type & LineViewTypeLeft) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, 0, width, CGRectGetHeight(self.bounds));
        [self.layer addSublayer:layer];

    }
    if (type & LineViewTypeBottom) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), width);
        [self.layer addSublayer:layer];

    }
    if (type & LineViewTypeRight) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(CGRectGetWidth(self.bounds), 0, width, CGRectGetHeight(self.bounds));
        [self.layer addSublayer:layer];
    }
    if (type&LineViewTypeAll) {
        //四边
        UIView   *frameView = [[UIView alloc] initWithFrame:self.bounds] ;
        frameView.layer.borderWidth = width;
        frameView.layer.borderColor = color.CGColor;
        [self addSubview:frameView];
    }


}
- (instancetype)addsetBackgroundImageName:(NSString *)str{
    
    UIImage *image = [UIImage imageWithFileName:str];
    self.layer.contents = (id)image.CGImage;
    return self;
}

@end



















