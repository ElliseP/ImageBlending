//
//  AlbumChooseViewController.m
//  BlendingAlbum
//
//  Created by Ellise on 2016/11/8.
//  Copyright © 2016年 ellise. All rights reserved.
//

#import "AlbumChooseViewController.h"
#import <Photos/Photos.h>
#import "AlbumTableViewCell.h"
#import "PhotoLibraryTool.h"
#import "HeaderTitleView.h"
#import "PhotoViewController.h"

@interface AlbumChooseViewController ()<PHPhotoLibraryChangeObserver>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) HeaderTitleView * headerView;

@end

@implementation AlbumChooseViewController

#pragma mark life cycle

- (void)dealloc{
    _tableView = nil;
    _headerView = nil;
}

- (instancetype)initWithType:(PhotoType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.type == BackgroundPhoto ? @"BACKGROUND" : @"FOREGROUND";
    
    [self.view addSubview:self.tableView];
    //[self.view addSubview:self.headerView];
    
    WS(weakSelf, self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [PhotoLibraryTool sharedInstance].photoLibraryNames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"AlbumListCell";
    AlbumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AlbumTableViewCell alloc] init];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if ([PhotoLibraryTool sharedInstance].photoLibraryNames.count) {
        cell.libraryNameLabel.text = [[PhotoLibraryTool sharedInstance].photoLibraryNames objectAtIndex:indexPath.row];
        cell.backgroundImageView.image = [[PhotoLibraryTool sharedInstance].photoLibraryFirstImage objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) {
        PhotoViewController * vc = [[PhotoViewController alloc] initWithAlbumAsset:[[PhotoLibraryTool sharedInstance].photoLibraryAssets[1] objectAtIndex:indexPath.row-1] albumName:[PhotoLibraryTool sharedInstance].photoLibraryNames[indexPath.row] type:self.type];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
         PhotoViewController * vc = [[PhotoViewController alloc] initWithAlbumAsset:[[PhotoLibraryTool sharedInstance].photoLibraryAssets[0] objectAtIndex:indexPath.row] albumName:[PhotoLibraryTool sharedInstance].photoLibraryNames[indexPath.row] type:self.type];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

#pragma mark getters and setters

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HeaderTitleView *)headerView{
    if (!_headerView) {
        _headerView = [[HeaderTitleView alloc] init];
        _headerView.titleLabel.text = self.type == BackgroundPhoto? @"BACKGROUND" : @"FOREGROUND";
    }
    return _headerView;
}

@end
