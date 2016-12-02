//
//  ShapeChooseView.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/10.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "ShapeChooseView.h"

@implementation ShapeChooseView

#pragma mark life cycle

- (void)dealloc{
    _squareButton = nil;
    _originalButton = nil;
    _movingView1 = nil;
    _movingView2 = nil;
    _squareButtonBlock = nil;
    _originalButtonBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.squareButton];
        [self addSubview:self.originalButton];
        [self addSubview:self.movingView1];
        [self addSubview:self.movingView2];
    }
    return self;
}

- (void)layoutSubviews{
    WS(weakSelf, self);
    [self.squareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.mas_equalTo(CGRectGetWidth(weakSelf.frame)/2);
    }];
    
    [self.originalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.mas_equalTo(CGRectGetWidth(weakSelf.frame)/2);
    }];
    
    [self.movingView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(weakSelf.squareButton.mas_centerX);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(100);
    }];
    
    [self.movingView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(weakSelf.originalButton.mas_centerX);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark event action 

- (void)squareButtonClicked{
    [self.squareButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.originalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.movingView1.hidden = NO;
    self.movingView2.hidden = YES;
    
    if (self.squareButtonBlock) {
        self.squareButtonBlock();
    }
}

- (void)originalButtonClicked{
    [self.originalButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.squareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.movingView1.hidden = YES;
    self.movingView2.hidden = NO;
    
    if (self.originalButtonBlock) {
        self.originalButtonBlock();
    }
}

#pragma mark getters and setters

- (UIButton *)squareButton{
    if (!_squareButton) {
        _squareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _squareButton.backgroundColor = [UIColor clearColor];
        _squareButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        _squareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_squareButton setTitle:@"SQUARE" forState:UIControlStateNormal];
        [_squareButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_squareButton addTarget:self action:@selector(squareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _squareButton;
}

- (UIButton *)originalButton{
    if (!_originalButton) {
        _originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalButton.backgroundColor = [UIColor clearColor];
        _originalButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        _originalButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_originalButton setTitle:@"ORIGINAL" forState:UIControlStateNormal];
        [_originalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_originalButton addTarget:self action:@selector(originalButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _originalButton;
}

- (UIView *)movingView1{
    if (!_movingView1) {
        _movingView1 = [[UIView alloc] init];
        _movingView1.backgroundColor = [UIColor yellowColor];
    }
    return _movingView1;
}

- (UIView *)movingView2{
    if (!_movingView2) {
        _movingView2 = [[UIView alloc] init];
        _movingView2.backgroundColor = [UIColor yellowColor];
        _movingView2.hidden = YES;
    }
    return _movingView2;
}


@end
