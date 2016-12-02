//
//  ShapeChooseView.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/10.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseView.h"

typedef void(^SquareButtonBlock)();

typedef void(^OriginalButtonBlock)();

@interface ShapeChooseView : BaseView

@property (nonatomic,strong) UIButton * squareButton;

@property (nonatomic,strong) UIButton * originalButton;

@property (nonatomic,strong) UIView * movingView1;

@property (nonatomic,strong) UIView * movingView2;

@property (nonatomic,copy) SquareButtonBlock squareButtonBlock;

@property (nonatomic,copy) OriginalButtonBlock originalButtonBlock;

@end
