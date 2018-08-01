//
//  JobManagementViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JobManagementViewController.h"
#import "TeacherNotifiedCell.h"
#import "HomeWorkViewController.h"

@interface JobManagementViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation JobManagementViewController

- (NSMutableArray *)jobManagementArr {
    if (!_jobManagementArr) {
        _jobManagementArr = [NSMutableArray array];
    }
    return _jobManagementArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业管理";
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"头像",@"头像",@"头像",@"头像", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级",@"九年级二班",@"六年级三班",@"四年级八班", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        
        NSDictionary *dic = @{@"img":img,@"title":title};
        [self.jobManagementArr addObject:dic];
    }
    [self makeJobManagementViewControllerUI];
    
}

- (void)makeJobManagementViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.jobManagementCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.jobManagementCollectionView.backgroundColor = backColor;
    self.jobManagementCollectionView.delegate = self;
    self.jobManagementCollectionView.dataSource = self;
    [self.view addSubview:self.jobManagementCollectionView];
    
    [self.jobManagementCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.jobManagementCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.jobManagementArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.jobManagementArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    TeacherNotifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.classLabel.text = [dic objectForKey:@"title"];
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
    
    NSLog(@"%ld",(long)indexPath.row);
    HomeWorkViewController *homeWorkVC = [[HomeWorkViewController alloc] init];
    [self.navigationController pushViewController:homeWorkVC animated:YES];
    
}


@end
