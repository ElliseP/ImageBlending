//
//  BlendingViewController.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseViewController.h"
#import "PhotoChooseView.h"
#import "FunctionButtonView.h"

@interface BlendingViewController : BaseViewController<PhotoChooseViewDelegate,FunctionButtonViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) PhotoChooseView * photoChooseView;

@property (nonatomic,strong) UIImageView *imageView;

@end
