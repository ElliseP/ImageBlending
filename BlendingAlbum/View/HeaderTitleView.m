//
//  HeaderTitleView.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/9.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "HeaderTitleView.h"
#import "AppDelegate.h"

@implementation HeaderTitleView

#pragma mark life cycle 

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.titleLabel];
        
        WS(weakSelf, self);
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(20);
            make.top.equalTo(weakSelf.mas_top).with.offset(7);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-20);
            make.top.equalTo(weakSelf.mas_top).with.offset(7);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(7);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

#pragma mark event action

- (void)dismiss{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CurrentController navigationController] popViewControllerAnimated:YES];
    });
}

- (void)camera{
    
}

#pragma mark getters and setters

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor clearColor];
        [_leftButton setImage:[UIImage imageNamed:@"btn_top_back"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        [_rightButton setImage:[UIImage imageNamed:@"btn_camera@2x.png"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
