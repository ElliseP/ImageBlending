//
//  FunctionButtonView.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "FunctionButtonView.h"

@interface FunctionButtonView ()

@property (nonatomic,strong) UIButton * toneButton;

@property (nonatomic,strong) UIButton * maskButton;

@property (nonatomic,strong) UIView * functionView;

@end

@implementation FunctionButtonView

#pragma mark life cycle

- (void)dealloc{
    _toneButton = nil;
    _maskButton = nil;
    _functionView = nil;
    _backgroundScrollView = nil;
    _delegate = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.backgroundScrollView];
        [self.backgroundScrollView addSubview:self.functionView];
        [self.functionView addSubview:self.toneButton];
        [self.functionView addSubview:self.maskButton];
        
//        WS(weakSelf, self);
//        [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakSelf.mas_left).with.offset(0);
//            make.right.equalTo(weakSelf.mas_right).with.offset(0);
//            make.top.equalTo(weakSelf.mas_top).with.offset(0);
//            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
//        }];
    }
    return self;
}

- (void)layoutSubviews{
    self.backgroundScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.functionView.frame = CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, CGRectGetHeight(self.backgroundScrollView.frame));
    self.toneButton.frame = CGRectMake(kSCREEN_WIDTH/4-60, CGRectGetHeight(self.backgroundScrollView.frame)/2-25, 120, 50);
    self.maskButton.frame = CGRectMake(kSCREEN_WIDTH/4*3-60, CGRectGetHeight(self.backgroundScrollView.frame)/2-25, 120, 50);
    
}

#pragma mark event action

- (void)toneButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toneButtonDidClicked)]) {
        [self.delegate toneButtonDidClicked];
    }
}

- (void)maskButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(maskButtonDidClicked)]) {
        [self.delegate maskButtonDidClicked];
    }
}

#pragma mark getters and setters

- (UIButton *)toneButton{
    if (!_toneButton) {
        _toneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _toneButton.clipsToBounds = YES;
        [_toneButton setImage:[UIImage imageNamed:@"btn_color_adj"] forState:UIControlStateNormal];
        [_toneButton addTarget:self action:@selector(toneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toneButton;
}

- (UIButton *)maskButton{
    if (!_maskButton) {
        _maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maskButton setImage:[UIImage imageNamed:@"btn_mask"] forState:UIControlStateNormal];
        [_maskButton addTarget:self action:@selector(maskButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskButton;
}

- (UIScrollView *)backgroundScrollView{
    if (!_backgroundScrollView) {
        _backgroundScrollView = [[UIScrollView alloc] init];
        _backgroundScrollView.backgroundColor = [UIColor lightGrayColor];
        _backgroundScrollView.scrollEnabled = NO;
        _backgroundScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH*2, CGRectGetHeight(self.frame));
        _backgroundScrollView.contentOffset = CGPointMake(kSCREEN_WIDTH, 0);
    }
    return _backgroundScrollView;
}

- (UIView *)functionView{
    if (!_functionView) {
        _functionView = [[UIView alloc] init];
        _functionView.backgroundColor = [UIColor lightGrayColor];
    }
    return _functionView;
}

@end
