//
//  AlbumTableViewCell.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/9.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "AlbumTableViewCell.h"
#import "ToolMacroes.h"
#import <Masonry.h>

@implementation AlbumTableViewCell

#pragma mark life cycle

- (void)dealloc{
    _backgroundImageView = nil;
    _libraryNameLabel = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backgroundImageView];
        [self.contentView addSubview:self.libraryNameLabel];
        
        WS(weakSelf, self);
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.contentView.mas_right).with.offset(0);
            make.top.equalTo(weakSelf.contentView.mas_top).with.offset(0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
        }];
        
        [self.libraryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).with.offset(60);
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(30);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}

#pragma mark getters and setters

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

- (UILabel *)libraryNameLabel{
    if (!_libraryNameLabel) {
        _libraryNameLabel = [[UILabel alloc] init];
        _libraryNameLabel.backgroundColor = [UIColor clearColor];
        _libraryNameLabel.font = [UIFont systemFontOfSize:18.f];
        _libraryNameLabel.textAlignment = NSTextAlignmentLeft;
        _libraryNameLabel.textColor = [UIColor lightGrayColor];
        _libraryNameLabel.numberOfLines = 0;
    }
    return _libraryNameLabel;
}

@end
