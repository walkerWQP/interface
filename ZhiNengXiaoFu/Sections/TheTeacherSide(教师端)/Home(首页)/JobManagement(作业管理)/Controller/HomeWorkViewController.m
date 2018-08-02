//
//  HomeWorkViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "ClassDetailsCell.h"
#import "PublishJobViewController.h"
#import "JobDetailsViewController.h"

@interface HomeWorkViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeWorkViewController

- (NSMutableArray *)homeWorkArr {
    if (!_homeWorkArr) {
        _homeWorkArr = [NSMutableArray array];
    }
    return _homeWorkArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭作业";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
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
        [self.homeWorkArr addObject:dic];
    }
    
    [self makeHomeWorkViewControllerUI];
    
}

- (void)makeHomeWorkViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.homeWorkCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.homeWorkCollectionView.backgroundColor = backColor;
    self.homeWorkCollectionView.delegate = self;
    self.homeWorkCollectionView.dataSource = self;
    [self.view addSubview:self.homeWorkCollectionView];
    
    [self.homeWorkCollectionView registerClass:[ClassDetailsCell class] forCellWithReuseIdentifier:ClassDetailsCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.homeWorkCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeWorkArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.homeWorkArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    ClassDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassDetailsCell_CollectionView forIndexPath:indexPath];
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
    JobDetailsViewController *jobDetailsVC = [[JobDetailsViewController alloc] init];
    [self.navigationController pushViewController:jobDetailsVC animated:YES];
}

- (void)rightBtn:(UIButton *)sender {
    
    NSLog(@"点击发布通知");
    PublishJobViewController *publishJobVC = [[PublishJobViewController alloc] init];
    [self.navigationController pushViewController:publishJobVC animated:YES];
    
}

@end
