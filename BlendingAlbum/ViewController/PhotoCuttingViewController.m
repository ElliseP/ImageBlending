//
//  PhotoCuttingViewController.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/10.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "PhotoCuttingViewController.h"
#import "ShapeChooseView.h"
#import "ImageProcessTool.h"
#import "BlendingViewController.h"

@interface PhotoCuttingViewController ()

@property (nonatomic,strong) UIButton * chooseButton;

@property (nonatomic,strong) UIButton * cancelButton;

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) ShapeChooseView * shapeChooseView;

@property (nonatomic,strong) UIImage * image;

@property (nonatomic,assign) PhotoType type;

@property (nonatomic,strong) CAShapeLayer * maskLayer;

@property (nonatomic,assign) BOOL isSquare;

@end

@implementation PhotoCuttingViewController

#pragma mark life cycle

- (void)dealloc{
    _chooseButton = nil;
    _cancelButton = nil;
    _scrollView = nil;
    _image = nil;
    _shapeChooseView = nil;
    _imageView = nil;
}

- (instancetype)initWithImage:(UIImage *)image type:(PhotoType)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.scale = image.size.width/image.size.height;
        self.isSquare = YES;
        self.image = image;
        NSLog(@"%f   %f",self.image.size.width,self.image.size.height);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view.layer addSublayer:self.maskLayer];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.chooseButton];
    [self.view addSubview:self.shapeChooseView];
    
    WS(weakSelf, self);
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(100);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(-20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-100);
        make.centerY.mas_equalTo(weakSelf.cancelButton.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"contentOffset: %f  %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

#pragma mark event action

- (void)chooseButtonClicked{
    UIImage * img = [[UIImage alloc] init];
    if (self.isSquare) {
        if (self.scale < 1) {
            // CGFloat height = 300*self.image.size.height/self.image.size.width;
            img = [[ImageProcessTool sharedInstance] imageFromImage:self.image atFrame:CGRectMake(0, (self.scrollView.contentOffset.y + 20) * self.image.size.width / 300, self.image.size.width , self.image.size.width)];
            NSLog(@"crop %f  %f",img.size.width,img.size.height);
        }else{
            //  CGFloat width = self.image.size.width*300/self.image.size.height;
            img = [[ImageProcessTool sharedInstance] imageFromImage:self.image atFrame:CGRectMake(self.scrollView.contentOffset.x * self.image.size.height / 300, 0, self.image.size.height , self.image.size.height)];
        }
    }else{
        img = self.image;
    }
    
    if (self.type == BackgroundPhoto) {
        [ImageProcessTool sharedInstance].backgroundImage = img;
    }else{
        [ImageProcessTool sharedInstance].foregroundImage = img;
    }
    
    BlendingViewController * vc = [[BlendingViewController alloc] init];
    if ([ImageProcessTool sharedInstance].backgroundImage) {
        [vc.photoChooseView.backgroundButton setImage:[ImageProcessTool sharedInstance].backgroundImage forState:UIControlStateNormal];
        vc.photoChooseView.backgroundButton.backgroundColor = [UIColor blackColor];
        vc.imageView.image = [ImageProcessTool sharedInstance].backgroundImage;
        vc.photoChooseView.frontButton.hidden = NO;
    }
    if ([ImageProcessTool sharedInstance].foregroundImage) {
        [vc.photoChooseView.frontButton setImage:[ImageProcessTool sharedInstance].foregroundImage forState:UIControlStateNormal];
        vc.photoChooseView.frontButton.backgroundColor = [UIColor blackColor];
        [vc.photoChooseView addSwipeGesture];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.backgroundColor = [UIColor clearColor];
        [_chooseButton setImage:[UIImage imageNamed:@"icon_yes_crop_trim"] forState:UIControlStateNormal];
        [_chooseButton addTarget:self action:@selector(chooseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setImage:[UIImage imageNamed:@"btn_cancel"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.maximumZoomScale = 2.f;
        _scrollView.minimumZoomScale = 1.f;
#warning need to calculate
        if (self.scale < 1) {
            _scrollView.contentSize = CGSizeMake(300, 300*self.image.size.height/self.image.size.width+347);
            _scrollView.contentOffset = CGPointMake(0, (300*self.image.size.height/self.image.size.width-300)/2);
        }else{
            _scrollView.contentSize = CGSizeMake(self.image.size.width*300/self.image.size.height+75, 300);
            _scrollView.contentOffset = CGPointMake((self.image.size.width*300/self.image.size.height-300)/2, 0);
        }
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        if (self.scale < 1) {
            _imageView.frame = CGRectMake(40, 80, 300, 300*self.image.size.height/self.image.size.width);
        }else{
            _imageView.frame = CGRectMake(40, 80, self.image.size.width*300/self.image.size.height, 300);
        }
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizesSubviews = YES;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _imageView;
}

- (ShapeChooseView *)shapeChooseView{
    if (!_shapeChooseView) {
        _shapeChooseView = [[ShapeChooseView alloc] initWithFrame:CGRectMake(40, 395, 295, 60)];
        WS(weakSelf, self);
        _shapeChooseView.squareButtonBlock = ^{
            weakSelf.isSquare = YES;
            [UIView animateWithDuration:0.2f animations:^{
                if (weakSelf.scale < 1) {
                    weakSelf.scrollView.contentSize = CGSizeMake(300, 300*self.image.size.height/self.image.size.width+347);
                    weakSelf.scrollView.contentOffset = CGPointMake(0, (300*self.image.size.height/self.image.size.width-300)/2);
                    weakSelf.imageView.frame = CGRectMake(40, 80, 300, 300*self.image.size.height/self.image.size.width);
                }else{
                    weakSelf.scrollView.contentSize = CGSizeMake(self.image.size.width*300/self.image.size.height+75, 300);
                    weakSelf.scrollView.contentOffset = CGPointMake((self.image.size.width*300/self.image.size.height-300)/2, 0);
                    weakSelf.imageView.frame = CGRectMake(40, 100, self.image.size.width*300/self.image.size.height, 300);
                }
                weakSelf.shapeChooseView.frame = CGRectMake(40, 395, 295, 60);
                
                CGMutablePathRef path = CGPathCreateMutable();
                CGRect maskRect = CGRectZero;
                maskRect = CGRectMake(40, 100, 300, 300);
                CGPathAddRect(path, nil, weakSelf.view.bounds);
                CGPathAddRect(path, nil, maskRect);
                [weakSelf.maskLayer setPath:path];
            }];
        };
        _shapeChooseView.originalButtonBlock = ^{
            weakSelf.isSquare = NO;
           [UIView animateWithDuration:0.2f animations:^{
               if (weakSelf.scale < 1) {
                   weakSelf.scrollView.contentSize = CGSizeMake(250, 250*self.image.size.height/self.image.size.width);
                   weakSelf.imageView.frame = CGRectMake(62.5, 20, 250, 250*self.image.size.height/self.image.size.width);
                   weakSelf.shapeChooseView.frame = CGRectMake(40, 30+250*self.image.size.height/self.image.size.width, 295, 60);
                   
                   CGMutablePathRef path = CGPathCreateMutable();
                   CGRect maskRect = CGRectMake(62.5, 40, 250, 250*self.image.size.height/self.image.size.width);
                   CGPathAddRect(path, nil, weakSelf.view.bounds);
                   CGPathAddRect(path, nil, maskRect);
                   [weakSelf.maskLayer setPath:path];
               }else{
                   weakSelf.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, weakSelf.image.size.height * kSCREEN_WIDTH / weakSelf.image.size.width);
                   weakSelf.imageView.frame = CGRectMake(0, 80, kSCREEN_WIDTH, weakSelf.image.size.height * kSCREEN_WIDTH / weakSelf.image.size.width);
                   weakSelf.shapeChooseView.frame = CGRectMake(40, 90+weakSelf.image.size.height * kSCREEN_WIDTH / weakSelf.image.size.width, 295, 60);
                   
                   CGMutablePathRef path = CGPathCreateMutable();
                   CGRect maskRect = CGRectMake(0, 100, kSCREEN_WIDTH, weakSelf.image.size.height * kSCREEN_WIDTH / weakSelf.image.size.width);
                   CGPathAddRect(path, nil, weakSelf.view.bounds);
                   CGPathAddRect(path, nil, maskRect);
                   [weakSelf.maskLayer setPath:path];
               }
           }];
        };
    }
    return _shapeChooseView;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [[CAShapeLayer alloc] init];
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect maskRect = CGRectZero;
        maskRect = CGRectMake(40, 100, 300, 300);
        CGPathAddRect(path, nil, self.view.bounds);
        CGPathAddRect(path, nil, maskRect);
        [_maskLayer setFillRule:kCAFillRuleEvenOdd];
        [_maskLayer setPath:path];
        [_maskLayer setFillColor:[[UIColor blackColor] CGColor]];
        _maskLayer.opacity = 0.5f;
    }
    return _maskLayer;
}

@end
