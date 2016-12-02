//
//  PhotoChooseView.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseView.h"

@protocol PhotoChooseViewDelegate <NSObject>

- (void)backgroundButtonDidClicked;

- (void)frontButtonDidClicked;

- (void)imageBlendingProcess;

@end

@interface PhotoChooseView : BaseView

@property (nonatomic,weak) id<PhotoChooseViewDelegate> delegate;

@property (nonatomic,strong) UIButton * backgroundButton;

@property (nonatomic,strong) UIButton * frontButton;

- (void)showFrontButton;

- (void)addSwipeGesture;

@end
