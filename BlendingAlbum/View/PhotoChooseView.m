//
//  PhotoChooseView.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "PhotoChooseView.h"
#import "ImageProcessTool.h"

@interface PhotoChooseView ()

@property (nonatomic,strong) UISwipeGestureRecognizer * swipeGesture;
//
//@property (nonatomic,strong) UIScrollView * backgroundScrollView;
//
//@property (nonatomic,strong) UIView * photoButtonView;

@end

@implementation PhotoChooseView

#pragma mark life cycle 

- (void)dealloc{
    _backgroundButton = nil;
    _frontButton = nil;
    _swipeGesture = nil;
    _delegate = nil;
//    _backgroundScrollView = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
       
        [self addSubview:self.backgroundButton];
        [self addSubview:self.frontButton];
//        [self.backgroundScrollView addSubview:self.photoButtonView];
//        [self.photoButtonView addSubview:self.backgroundButton];
        
//        WS(weakSelf, self);
//        [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakSelf.mas_left).with.offset(0);
//            make.right.equalTo(weakSelf.mas_right).with.offset(0);
//            make.top.equalTo(weakSelf.mas_top).with.offset(0);
//            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
//        }];
//        
//        [self.photoButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(weakSelf.backgroundScrollView.mas_right).with.offset(0);
//            make.top.equalTo(weakSelf.backgroundScrollView.mas_top).with.offset(0);
//            make.bottom.equalTo(weakSelf.backgroundScrollView.mas_bottom).with.offset(0);
//            make.width.mas_equalTo(kSCREEN_WIDTH);
//        }];
    }
    return self;
}

- (void)layoutSubviews{
    self.backgroundButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    self.frontButton.frame = CGRectMake(CGRectGetWidth(self.frame)/2, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
}

#pragma mark private method

- (void)showFrontButton{
    [self addSubview:self.frontButton];
}

- (void)addSwipeGesture{
    [self addGestureRecognizer:self.swipeGesture];
}

#pragma mark event action

- (void)backgroundButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundButtonDidClicked)]) {
        [self.delegate backgroundButtonDidClicked];
    }
}

- (void)frontButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(frontButtonDidClicked)]) {
        [self.delegate frontButtonDidClicked];
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)ges{
    CGRect left = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    CGRect right = CGRectMake(CGRectGetWidth(self.frame)/2, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    if (ges.direction == UISwipeGestureRecognizerDirectionRight) {
        WS(weakSelf, self);
        [UIView animateWithDuration:0.1f animations:^{
            if (CGRectEqualToRect(weakSelf.backgroundButton.frame,left)) {
                weakSelf.backgroundButton.frame = right;
                weakSelf.frontButton.frame = left;
            }else{
                weakSelf.backgroundButton.frame = left;
                weakSelf.frontButton.frame = right;
            }
        }];
        [[ImageProcessTool sharedInstance] switchImage];
    }else if (ges.direction == UISwipeGestureRecognizerDirectionLeft){
        WS(weakSelf, self);
        [UIView animateWithDuration:0.1f animations:^{
            if (CGRectEqualToRect(weakSelf.backgroundButton.frame,right)) {
                weakSelf.backgroundButton.frame = left;
                weakSelf.frontButton.frame = right;
            }else{
                weakSelf.backgroundButton.frame = right;
                weakSelf.frontButton.frame = left;
            }
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageBlendingProcess)]) {
        [self.delegate imageBlendingProcess];
    }
}

#pragma mark getters and setters

- (UIButton *)backgroundButton{
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [UIColor whiteColor];
        _backgroundButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _backgroundButton.titleLabel.numberOfLines = 0;
        _backgroundButton.adjustsImageWhenHighlighted = NO;
        _backgroundButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _backgroundButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_backgroundButton setTitle:@"TAP TO CHOOSE BACKGROUND" forState:UIControlStateNormal];
        [_backgroundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backgroundButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}

- (UIButton *)frontButton{
    if (!_frontButton) {
        _frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _frontButton.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
        _frontButton.backgroundColor = [UIColor whiteColor];
        _frontButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _frontButton.titleLabel.numberOfLines = 0;
        _frontButton.adjustsImageWhenHighlighted = NO;
        _frontButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _frontButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _frontButton.hidden = YES;
        [_frontButton setTitle:@"TAP TO CHOOSE FOREGROUND" forState:UIControlStateNormal];
        [_frontButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_frontButton addTarget:self action:@selector(frontButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _frontButton;
}

- (UISwipeGestureRecognizer *)swipeGesture{
    if (!_swipeGesture) {
        _swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    }
    return _swipeGesture;
}
//
//- (UIView *)photoButtonView{
//    if (!_photoButtonView) {
//        _photoButtonView = [[UIView alloc] init];
//        _photoButtonView.backgroundColor = [UIColor greenColor];
//    }
//    return _photoButtonView;
//}
//
//- (UIScrollView *)backgroundScrollView{
//    if (!_backgroundScrollView) {
//        _backgroundScrollView = [[UIScrollView alloc] init];
//        _backgroundScrollView.backgroundColor = [UIColor whiteColor];
//        _backgroundScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH*2, CGRectGetHeight(self.frame));
//        _backgroundScrollView.contentOffset = CGPointMake(kSCREEN_WIDTH, 0);
//     //   _backgroundScrollView.scrollEnabled = NO;
//    }
//    return _backgroundScrollView;
//}

@end
