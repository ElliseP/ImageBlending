//
//  PhotoCollectionViewCell.h
//  ImageSDK
//
//  Created by Ellise on 16/9/5.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ToolMacroes.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * photoView;

- (void)setImg:(UIImage *)img;

@end
