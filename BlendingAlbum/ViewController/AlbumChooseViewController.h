//
//  AlbumChooseViewController.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    BackgroundPhoto = 0,
    ForegroundPhoto,
} PhotoType;

@interface AlbumChooseViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) PhotoType type;

- (instancetype)initWithType:(PhotoType)type;

@end
