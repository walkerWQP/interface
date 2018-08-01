//
//  HasBeenViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HasBeenViewController.h"
#import "TotalNumberCell.h"
#import "QianDaoViewController.h"

@interface HasBeenViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *hasBeenArr;
@property (nonatomic, strong) UICollectionView *hasBeenCollectionView;

@end

@implementation HasBeenViewController

- (NSMutableArray *)hasBeenArr {
    if(!_hasBeenArr) {
        _hasBeenArr = [NSMutableArray array];
    }
    return _hasBeenArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 总数
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像",@"头像", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞",@"上官云飞", nil];
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *content   = [contentArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"content":content};
        [self.hasBeenArr addObject:dic];
    }
    [self makeHasBeenViewControllerUI];
}

- (void)makeHasBeenViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.hasBeenCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 90) collectionViewLayout:layout];
    self.hasBeenCollectionView.backgroundColor = backColor;
    self.hasBeenCollectionView.delegate = self;
    self.hasBeenCollectionView.dataSource = self;
    [self.view addSubview:self.hasBeenCollectionView];
    
    [self.hasBeenCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hasBeenArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.hasBeenArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.nameLabel.text = [dic objectForKey:@"content"];
    gridcell = cell;
    return gridcell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake((APP_WIDTH - 45) / 3, APP_HEIGHT * 0.15);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    QianDaoViewController *qianDaoVC = [[QianDaoViewController alloc] init];
    [self.navigationController pushViewController:qianDaoVC animated:YES];
}

@end
