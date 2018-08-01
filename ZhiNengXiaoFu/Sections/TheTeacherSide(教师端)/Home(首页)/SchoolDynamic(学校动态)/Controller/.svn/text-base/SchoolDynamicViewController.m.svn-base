//
//  SchoolDynamicViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDynamicViewController.h"
#import "SchoolDynamicCellCell.h"
#import "SchoolInformationViewController.h"

@interface SchoolDynamicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *schoolDynamicCollectionView;
@property (nonatomic, strong) NSMutableArray  *schoolDynamicArr;
@property (nonatomic, strong) UIImageView  *headImgView;

@end

@implementation SchoolDynamicViewController

- (NSMutableArray *)schoolDynamicArr {
    if (!_schoolDynamicArr) {
        _schoolDynamicArr = [NSMutableArray array];
    }
    return _schoolDynamicArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校动态";
   
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"通知图标",@"通知图标",@"通知图标",@"通知图标", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级通知",@"九年级通知",@"六年级通知",@"四年级八班通知", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"英语作业通知",@"英语",@"数学成绩查询",@"春游计划通知", nil];
    NSMutableArray *timeArr       = [NSMutableArray arrayWithObjects:@"2018-09-01",@"2018-09-02",@"2018-09-03",@"2018-09-04", nil];
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        NSString *content = [contentArr objectAtIndex:i];
        NSString *time    = [timeArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"title":title,@"content":content,@"time":time};
        [self.schoolDynamicArr addObject:dic];
    }
    
    [self makeSchoolDynamicViewControllerUI];
    
}

- (void)makeSchoolDynamicViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.schoolDynamicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.schoolDynamicCollectionView.backgroundColor = backColor;
    self.schoolDynamicCollectionView.delegate = self;
    self.schoolDynamicCollectionView.dataSource = self;
    [self.view addSubview:self.schoolDynamicCollectionView];
    
    [self.schoolDynamicCollectionView registerClass:[SchoolDynamicCellCell class] forCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.schoolDynamicCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
    
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.schoolDynamicArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = [self.schoolDynamicArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    SchoolDynamicCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.subjectsLabel.text = [dic objectForKey:@"content"];
    cell.timeLabel.text = [dic objectForKey:@"time"];
    
    gridcell = cell;
    
    
    
    return gridcell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, 70);
  
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    SchoolInformationViewController *schoolInformationVC = [[SchoolInformationViewController alloc] init];
    [self.navigationController pushViewController:schoolInformationVC animated:YES];
}


@end
