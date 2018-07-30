//
//  TeacherNotifiedViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherNotifiedViewController.h"
#import "TeacherNotifiedCell.h"
#import "ClassDetailsViewController.h"

@interface TeacherNotifiedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@end

@implementation TeacherNotifiedViewController

- (NSMutableArray *)teacherNotifiedArr {
    if (!_teacherNotifiedArr) {
        _teacherNotifiedArr = [NSMutableArray array];
    }
    return _teacherNotifiedArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班级列表";
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"头像",@"头像",@"头像",@"头像", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级",@"九年级二班",@"六年级三班",@"四年级八班", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        
        NSDictionary *dic = @{@"img":img,@"title":title};
        [self.teacherNotifiedArr addObject:dic];
    }
    [self makeTeacherNotifiedViewControllerUI];
   
    
}

- (void)makeTeacherNotifiedViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.teacherNotifiedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.teacherNotifiedCollectionView.backgroundColor = backColor;
    self.teacherNotifiedCollectionView.delegate = self;
    self.teacherNotifiedCollectionView.dataSource = self;
    [self.view addSubview:self.teacherNotifiedCollectionView];
    
    [self.teacherNotifiedCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.teacherNotifiedCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.teacherNotifiedArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.teacherNotifiedArr objectAtIndex:indexPath.row];
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
    
    NSLog(@"%ld",indexPath.row);
    ClassDetailsViewController *ClassDetailsVC = [[ClassDetailsViewController alloc] init];
    [self.navigationController pushViewController:ClassDetailsVC animated:YES];
}

@end
