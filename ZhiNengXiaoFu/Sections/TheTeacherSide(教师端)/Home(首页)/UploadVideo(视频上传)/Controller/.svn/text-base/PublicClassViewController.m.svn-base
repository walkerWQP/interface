//
//  PublicClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PublicClassViewController.h"
#import "PublicClassCell.h"
#import "VideoSettingsViewController.h"

@interface PublicClassViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *publicClassArr;
@property (nonatomic, strong) UICollectionView *publicClassCollectionView;

@end

@implementation PublicClassViewController

- (NSMutableArray *)publicClassArr {
    if (!_publicClassArr) {
        _publicClassArr = [NSMutableArray array];
    }
    return _publicClassArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"教师端活动管理banner",@"教师端活动管理banner",@"教师端活动管理banner",@"教师端活动管理banner", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"七年级运动会",@"九年级运动会",@"六年级运动会",@"四年级八班运动会", nil];
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *content   = [contentArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"content":content};
        [self.publicClassArr addObject:dic];
    }
    [self makePublicClassViewControllerUI];
}

- (void)makePublicClassViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.publicClassCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.publicClassCollectionView.backgroundColor = backColor;
    self.publicClassCollectionView.delegate = self;
    self.publicClassCollectionView.dataSource = self;
    [self.view addSubview:self.publicClassCollectionView];
    
    [self.publicClassCollectionView registerClass:[PublicClassCell class] forCellWithReuseIdentifier:PublicClassCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.publicClassArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.publicClassArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    PublicClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublicClassCell_CollectionView forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.contentLabel.text = [dic objectForKey:@"content"];
    [cell.playBtn addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.setUpBtn addTarget:self action:@selector(setUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    gridcell = cell;
    return gridcell;
    
}

- (void)playBtn : (UIButton *)sender {
    NSLog(@"点击播放按钮");
}

- (void)setUpBtn : (UIButton *)sender {
    NSLog(@"点击设置");
    VideoSettingsViewController *videoSettingsVC = [[VideoSettingsViewController alloc] init];
    [self.navigationController pushViewController:videoSettingsVC animated:YES];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3 + 50);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
}

@end
