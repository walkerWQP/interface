//
//  TomorrowViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TomorrowViewController.h"
#import "OngoingCell.h"

@interface TomorrowViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *tomorrowArr;
@property (nonatomic, strong) UICollectionView *tomorrowCollectionView;

@end

@implementation TomorrowViewController

- (NSMutableArray *)tomorrowArr {
    if (!_tomorrowArr) {
        _tomorrowArr = [NSMutableArray array];
    }
   return _tomorrowArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"教师端活动管理banner", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级运动会", nil];
    NSMutableArray *timeArr       = [NSMutableArray arrayWithObjects:@"活动日期:2018.08.30-2018.09.10", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        NSString *time    = [timeArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"title":title,@"time":time};
        [self.tomorrowArr addObject:dic];
    }
    [self makeTomorrowViewControllerUI];
}

- (void)makeTomorrowViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tomorrowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.tomorrowCollectionView.backgroundColor = backColor;
    self.tomorrowCollectionView.delegate = self;
    self.tomorrowCollectionView.dataSource = self;
    [self.view addSubview:self.tomorrowCollectionView];
    
    [self.tomorrowCollectionView registerClass:[OngoingCell class] forCellWithReuseIdentifier:OngoingCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tomorrowArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.tomorrowArr objectAtIndex:indexPath.row];
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
