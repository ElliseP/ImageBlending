//
//  UIView+Extension.h
//  NewProjectTool
//
//  Created by  霍秋亮 on 15/9/29.
//  Copyright © 2015年 huohuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, lineViewType){
    LineViewTypeNone   = 0,
    LineViewTypeTop    = 1,
    LineViewTypeLeft   = 1<<1,
    LineViewTypeBottom = 1<<2,
    LineViewTypeRight  = 1<<3,
    LineViewTypeAll    = 1<<4,
};

typedef void(^UIViewCategoryNormalBlock)(UIView *view);

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

/** UIView加边框及边框颜色*/
- (void)addLineWithLineType:(lineViewType)type color:(UIColor*)color lineWidth:(CGFloat)width;

/** UIView 添加背景色或者图片*/
- (instancetype)addsetBackgroundImageName:(NSString *)str;


@end
