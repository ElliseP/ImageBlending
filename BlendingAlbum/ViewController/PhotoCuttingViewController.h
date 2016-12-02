//
//  PhotoCuttingViewController.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/10.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseViewController.h"
#import "AlbumChooseViewController.h"

@interface PhotoCuttingViewController : BaseViewController<UIScrollViewDelegate>

- (instancetype)initWithImage:(UIImage *)image type:(PhotoType)type;

@end
