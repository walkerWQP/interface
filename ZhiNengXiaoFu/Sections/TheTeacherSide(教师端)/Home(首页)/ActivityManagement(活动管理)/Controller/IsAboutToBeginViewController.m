//
//  IsAboutToBeginViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "IsAboutToBeginViewController.h"
#import "OngoingCell.h"

@interface IsAboutToBeginViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *isAboutToBeginArr;
@property (nonatomic, strong) UICollectionView *isAboutToBeginCollectionView;

@end

@implementation IsAboutToBeginViewController

- (NSMutableArray *)isAboutToBeginArr {
    if (!_isAboutToBeginArr) {
        _isAboutToBeginArr = [NSMutableArray array];
    }
    return _isAboutToBeginArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"homepagelunbo3", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"九年级运动会", nil];
    NSMutableArray *timeArr       = [NSMutableArray arrayWithObjects:@"活动日期:2018.08.10-2018.08.13", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        NSString *time    = [timeArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"title":title,@"time":time};
        [self.isAboutToBeginArr addObject:dic];
    }
    [self makeIsAboutToBeginViewControllerUI];
}

- (void)makeIsAboutToBeginViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.isAboutToBeginCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.isAboutToBeginCollectionView.backgroundColor = backColor;
    self.isAboutToBeginCollectionView.delegate = self;
    self.isAboutToBeginCollectionView.dataSource = self;
    [self.view addSubview:self.isAboutToBeginCollectionView];
    
    [self.isAboutToBeginCollectionView registerClass:[OngoingCell class] forCellWithReuseIdentifier:OngoingCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.isAboutToBeginArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.isAboutToBeginArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    OngoingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OngoingCell_CollectionView forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.timeLabel.text = [dic objectForKey:@"time"];
    cell.detailsLabel.text = [dic objectForKey:@"title"];
    gridcell = cell;
    return gridcell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
}

@end
