//
//  BlendingViewController.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "BlendingViewController.h"
#import "AlbumChooseViewController.h"
#import "ImageProcessTool.h"

@interface BlendingViewController ()

@property (nonatomic,strong) FunctionButtonView * functionButtonView;

@property (nonatomic,strong) UIButton * saveButton;

@property (nonatomic,strong) UIImage * resultImage;

@property (nonatomic,strong) CAShapeLayer * maskLayer;

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,assign) CGFloat originalScale;

@property (nonatomic,assign) CGPoint beganPoint;

@property (nonatomic,assign) CGPoint movePoint;

@property (nonatomic,assign) CGFloat sliderValue;

@end

@implementation BlendingViewController

#pragma mark life cycle

- (void)dealloc{
    _photoChooseView = nil;
    _functionButtonView = nil;
    _imageView = nil;
    _saveButton = nil;
    _resultImage = nil;
    _maskLayer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalScale = 0.8;
    self.sliderValue = 0.5f;
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.photoChooseView];
    [self.view addSubview:self.functionButtonView];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.saveButton];
    
    WS(weakSelf, self);
    [self.photoChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.mas_equalTo(180);
    }];
    
    [self.functionButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.photoChooseView.mas_top).with.offset(0);
        make.top.equalTo(weakSelf.imageView.mas_bottom).with.offset(0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.height.mas_equalTo(375);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    if ([ImageProcessTool sharedInstance].backgroundImage && [ImageProcessTool sharedInstance].foregroundImage) {
         [SVProgressHUD show];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self imageBlendingProcess];
            [SVProgressHUD dismiss];
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark FunctionButtonViewDelegate

- (void)toneButtonDidClicked{
    UIView * sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, CGRectGetHeight(self.functionButtonView.frame))];
    sliderView.tag = 100;
    sliderView.backgroundColor = [UIColor lightGrayColor];
    
    UISlider * slider = [[UISlider alloc] init];
    slider.maximumValue = 1;
    slider.value = self.sliderValue;
    slider.minimumValue = 0;
    [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    
    UIButton * checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.backgroundColor = [UIColor yellowColor];
    checkButton.imageView.frame = CGRectMake(10, sliderView.frame.size.height/2-20, 30, 30);
    checkButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[checkButton setBackgroundImage:[UIImage imageNamed:@"btn_done"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [sliderView addSubview:slider];
    [sliderView addSubview:checkButton];
    [self.functionButtonView.backgroundScrollView addSubview:sliderView];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sliderView.mas_left).with.offset(50);
        make.centerY.mas_equalTo(sliderView.mas_centerY);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(50);
    }];
    
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_top).with.offset(0);
        make.bottom.equalTo(sliderView.mas_bottom).with.offset(0);
        make.right.equalTo(sliderView.mas_right).with.offset(0);
        make.width.mas_equalTo(50);
    }];
    
    WS(weakSelf, self);
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.functionButtonView.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)maskButtonDidClicked{
    UIView * sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, CGRectGetHeight(self.functionButtonView.frame))];
    sliderView.tag = 101;
    sliderView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton * squareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [squareButton setBackgroundImage:[UIImage imageNamed:@"icon_square_filled"] forState:UIControlStateNormal];
    [squareButton addTarget:self action:@selector(squareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [circleButton setBackgroundImage:[UIImage imageNamed:@"btn_brush_hard"] forState:UIControlStateNormal];
    [circleButton addTarget:self action:@selector(circleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.backgroundColor = [UIColor yellowColor];
    checkButton.imageView.frame = CGRectMake(10, sliderView.frame.size.height/2-20, 30, 30);
    checkButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[checkButton setBackgroundImage:[UIImage imageNamed:@"btn_done"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.functionButtonView.backgroundScrollView addSubview:sliderView];
    [sliderView addSubview:squareButton];
    [sliderView addSubview:circleButton];
    [sliderView addSubview:checkButton];
    
    [squareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sliderView.mas_left).with.offset(((kSCREEN_WIDTH-50)/2-20)/2);
        make.centerY.mas_equalTo(sliderView.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [circleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(checkButton.mas_left).with.offset(-((kSCREEN_WIDTH-50)/2-20)/2);
        make.centerY.mas_equalTo(sliderView.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_top).with.offset(0);
        make.bottom.equalTo(sliderView.mas_bottom).with.offset(0);
        make.right.equalTo(sliderView.mas_right).with.offset(0);
        make.width.mas_equalTo(50);
    }];
    
    WS(weakSelf, self);
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.functionButtonView.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark PhotoChooseViewDelegate

- (void)backgroundButtonDidClicked{
    AlbumChooseViewController * vc = [[AlbumChooseViewController alloc] initWithType:BackgroundPhoto];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)frontButtonDidClicked{
    AlbumChooseViewController * vc = [[AlbumChooseViewController alloc] initWithType:ForegroundPhoto];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imageBlendingProcess{
    WS(weakSelf, self);
    self.sliderValue = 0.5f;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.resultImage = [[ImageProcessTool sharedInstance] addImage];
       // weakSelf.imageView.image = weakSelf.resultImage;
        
        for (UIView * v in weakSelf.imageView.subviews) {
            [v removeFromSuperview];
        }
       
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kSCREEN_WIDTH/2, 50) radius:kSCREEN_WIDTH startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH);
        _maskLayer.path = path.CGPath;
        _maskLayer.position = CGPointMake(self.imageView.frame.size.width/2.f, self.imageView.frame.size.height/2.f);
        _maskLayer.fillColor = [UIColor whiteColor].CGColor;
        _maskLayer.position = self.view.center;
        
        UIView * frontView = [[UIView alloc] initWithFrame:self.imageView.bounds];
        frontView.backgroundColor = [UIColor blackColor];
        [self.imageView addSubview:frontView];
        frontView.layer.mask = self.maskLayer;
        frontView.layer.contents = (id)self.resultImage.CGImage;
        
        [weakSelf checkButtonClicked];
    });
}

#pragma mark private method

#pragma mark UIView Touch

#pragma mark event action

- (void)updateView{
    if ([ImageProcessTool sharedInstance].backgroundImage) {
        [self.photoChooseView.backgroundButton setImage:[ImageProcessTool sharedInstance].backgroundImage forState:UIControlStateNormal];
        self.photoChooseView.backgroundButton.backgroundColor = [UIColor blackColor];
        self.imageView.image = [ImageProcessTool sharedInstance].backgroundImage;
        self.photoChooseView.frontButton.hidden = NO;
    }
    if ([ImageProcessTool sharedInstance].foregroundImage) {
        [self.photoChooseView.frontButton setImage:[ImageProcessTool sharedInstance].foregroundImage forState:UIControlStateNormal];
        self.photoChooseView.frontButton.backgroundColor = [UIColor blackColor];
        [self.photoChooseView addSwipeGesture];
    }
   
}

- (void)saveButtonClicked{
    UIImage * saveImage = [[ImageProcessTool sharedInstance] capture:self.imageView];
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (void)checkButtonClicked{
    self.imageView.userInteractionEnabled = NO;
    WS(weakSelf, self);
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.functionButtonView.backgroundScrollView.contentOffset = CGPointMake(kSCREEN_WIDTH,0);
    }];
    
    for (UIView * v in self.functionButtonView.backgroundScrollView.subviews) {
        if (v.tag == 100 || v.tag == 101) {
            [v removeFromSuperview];
        }
    }
}

- (void)slider:(UISlider *)slider{
    CGFloat value = slider.value;
    self.sliderValue = value;
    
    WS(weakSelf, self);
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView * v in weakSelf.imageView.subviews) {
            if (v.tag == 102) {
                v.layer.contents = (id)[[ImageProcessTool sharedInstance] addImage:(1-value)].CGImage;
            }
        }
    });
}

- (void)squareButtonClicked{
    self.imageView.userInteractionEnabled = YES;
    
    for (UIView * v in self.imageView.subviews) {
        [v removeFromSuperview];
    }
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(75, 75, kSCREEN_WIDTH-150, kSCREEN_WIDTH-150) cornerRadius:1.5];
    _maskLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH);
    _maskLayer.path = path.CGPath;
    _maskLayer.position = CGPointMake(self.imageView.frame.size.width/2.f, self.imageView.frame.size.height/2.f);
    _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    _maskLayer.position = self.imageView.center;
    
    UIView * frontView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    frontView.backgroundColor = [UIColor blackColor];
    [self.imageView addSubview:frontView];
    frontView.layer.mask = self.maskLayer;
    frontView.tag = 102;
    frontView.layer.contents = (id)self.resultImage.CGImage;
    
    UIView * recognizerView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    recognizerView.backgroundColor = [UIColor clearColor];
    [self.imageView addSubview:recognizerView];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [recognizerView addGestureRecognizer:panRecognizer];
    UIPinchGestureRecognizer * pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleSquarePinch:)];
    [recognizerView addGestureRecognizer:pinchRecognizer];
}

- (void)circleButtonClicked{
    self.imageView.userInteractionEnabled = YES;
    
    for (UIView * v in self.imageView.subviews) {
        [v removeFromSuperview];
    }
    
  //  self.imageView.image = (id)[ImageProcessTool sharedInstance].backgroundImage;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kSCREEN_WIDTH/2, kSCREEN_WIDTH/2) radius:(kSCREEN_WIDTH-100)/2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH);
    _maskLayer.path = path.CGPath;
    _maskLayer.position = CGPointMake(self.imageView.frame.size.width/2.f,
                                      self.imageView.frame.size.height/2.f);
    _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    _maskLayer.position = self.imageView.center;

    UIView * frontView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    frontView.backgroundColor = [UIColor blackColor];
    [self.imageView addSubview:frontView];
    frontView.layer.mask = self.maskLayer;
    frontView.tag = 102;
    frontView.layer.contents = (id)self.resultImage.CGImage;
    
    UIView * recognizerView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    recognizerView.backgroundColor = [UIColor clearColor];
    [self.imageView addSubview:recognizerView];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [recognizerView addGestureRecognizer:panRecognizer];
    UIPinchGestureRecognizer * pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleCirclePinch:)];
    [recognizerView addGestureRecognizer:pinchRecognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    // 拖拽
    CGPoint translation = [recognizer translationInView:self.imageView];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.imageView];
    
    // 关闭CoreAnimation实时动画绘制(核心)
    [CATransaction setDisableActions:YES];
    _maskLayer.position = recognizer.view.center;
}

- (void)handleCirclePinch:(UIPinchGestureRecognizer *)recognizer{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kSCREEN_WIDTH/2, kSCREEN_WIDTH/2) radius:((kSCREEN_WIDTH-100)/2)*recognizer.scale startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    self.maskLayer.path = path.CGPath;
}

- (void)handleSquarePinch:(UIPinchGestureRecognizer *)recognizer{
     UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(75-((recognizer.scale-1)*(kSCREEN_WIDTH-150)/2), 75-((recognizer.scale-1)*(kSCREEN_WIDTH-150)/2), (kSCREEN_WIDTH-150)*recognizer.scale, (kSCREEN_WIDTH-150)*recognizer.scale) cornerRadius:1.5];
    self.maskLayer.path = path.CGPath;
}

#pragma mark getters and setters

- (PhotoChooseView *)photoChooseView{
    if (!_photoChooseView) {
        _photoChooseView = [[PhotoChooseView alloc] init];
        _photoChooseView.delegate = self;
    }
    return _photoChooseView;
}

- (FunctionButtonView *)functionButtonView{
    if (!_functionButtonView) {
        _functionButtonView = [[FunctionButtonView alloc] init];
        _functionButtonView.delegate = self;
    }
    return _functionButtonView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizesSubviews = YES;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self updateView];
    }
    return _imageView;
}

- (UIImage *)resultImage{
    if (!_resultImage) {
        _resultImage = [[UIImage alloc] init];
    }
    return _resultImage;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setImage:[UIImage imageNamed:@"btn_share.png"] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
    }
    return _maskLayer;
}


@end
