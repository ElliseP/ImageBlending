//
//  PhotoCollectionViewCell.m
//  ImageSDK
//
//  Created by Ellise on 16/9/5.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

#pragma mark - life cycle

- (void)dealloc{
    _photoView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoView];
    }
    return self;
}

- (void)layoutSubviews {
    WS(weakSelf, self);
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
}

#pragma mark - getters and setters

- (UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
    }
    return _photoView;
}

- (void)setImg:(UIImage *)img {
    self.photoView.image = img;
}

@end
