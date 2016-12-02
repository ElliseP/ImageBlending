//
//  PhotoLibraryTool.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/9.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoLibraryTool : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,strong) NSMutableArray * photoLibraryNames;

@property (nonatomic,strong) NSMutableArray * photoLibraryAssets;

@property (nonatomic,strong) NSMutableArray * photoLibraryFirstImage;

@end
