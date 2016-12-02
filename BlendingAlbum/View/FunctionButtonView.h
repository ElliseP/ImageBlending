//
//  FunctionButtonView.h
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BaseView.h"

@protocol FunctionButtonViewDelegate <NSObject>

- (void)maskButtonDidClicked;

- (void)toneButtonDidClicked;

@end

@interface FunctionButtonView : BaseView

@property (nonatomic,weak) id<FunctionButtonViewDelegate> delegate;

@property (nonatomic,strong) UIScrollView * backgroundScrollView;

@end
