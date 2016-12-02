//
//  PhotoViewController.h
//  ImageSDK
//
//  Created by Ellise on 16/9/5.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseViewController.h"
#import <Photos/Photos.h>
#import "AlbumChooseViewController.h"

@interface PhotoViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) PHAssetCollection * photoAsset;

- (instancetype)initWithAlbumAsset:(PHAssetCollection *)photoAsset albumName:(NSString *)albumName type:(PhotoType)type;

@end
