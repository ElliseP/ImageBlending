//
//  PhotoLibraryTool.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/9.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "PhotoLibraryTool.h"
#import <Photos/Photos.h>
#import "ToolMacroes.h"

@interface PhotoLibraryTool ()

@property (nonatomic,strong) PHCachingImageManager * cacheManager;

@end

@implementation PhotoLibraryTool

#pragma mark life cycle

- (void)dealloc{
    _photoLibraryNames = nil;
    _photoLibraryAssets = nil;
    _photoLibraryFirstImage = nil;
}

+ (instancetype)sharedInstance{
    static PhotoLibraryTool * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.cacheManager = [[PHCachingImageManager alloc] init];
        self.photoLibraryNames = [[NSMutableArray alloc] init];
        self.photoLibraryAssets = [[NSMutableArray alloc] init];
        self.photoLibraryFirstImage = [[NSMutableArray alloc] init];
        [self getLibraryAsset];
    }
    return self;
}

#pragma mark get photos

- (void)getLibraryAsset{
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHFetchResult *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    if (cameraRoll.count) {
        [self.photoLibraryAssets addObject:cameraRoll];
        [self.photoLibraryNames addObject:[NSString stringWithFormat:@"%@",@"CAMERA ROLL"]];
        PHFetchOptions * options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:cameraRoll[0] options:options];
        PHAsset * asset = result[0];
        PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        option.resizeMode = PHImageRequestOptionsResizeModeExact;
        option.synchronous = YES;
        
        WS(weakSelf, self);
        [self.cacheManager requestImageForAsset:asset targetSize:CGSizeMake(kSCREEN_WIDTH, 200) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [weakSelf.photoLibraryFirstImage addObject:result];
        }];
    }
    
    if (topLevelUserCollections.count) {
        for (PHCollection * collection in topLevelUserCollections) {
            [self.photoLibraryNames addObject:collection.localizedTitle];
            PHFetchOptions * options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)collection options:options];
            PHAsset * asset = result[0];
            PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
            option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
            option.resizeMode = PHImageRequestOptionsResizeModeExact;
            option.synchronous = YES;
            
            WS(weakSelf, self);
            [self.cacheManager requestImageForAsset:asset targetSize:CGSizeMake(kSCREEN_WIDTH, 200) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [weakSelf.photoLibraryFirstImage addObject:result];
            }];
        }
        [self.photoLibraryAssets addObject:topLevelUserCollections];
    }
}

@end
