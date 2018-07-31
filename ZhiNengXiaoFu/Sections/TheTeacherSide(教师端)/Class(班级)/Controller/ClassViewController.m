//
//  ClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassViewController.h"
#import "TeacherNotifiedCell.h"
#import "TheClassInformationViewController.h"

@interface ClassViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *classArr;
@property (nonatomic, strong) UICollectionView *classCollectionView;
@property (nonatomic, strong) UIImageView  *headImgView;

@end

@implementation ClassViewController

- (NSMutableArray *)classArr {
    if (!_classArr) {
        self.classArr = [@[]mutableCopy];
    }
    return _classArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"班级";
   
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"头像",@"头像",@"头像",@"头像", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级",@"九年级二班",@"六年级三班",@"四年级八班", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        
        NSDictionary *dic = @{@"img":img,@"title":title};
        [self.classArr addObject:dic];
    }
    
    [self makeClassViewControllerUI];
    
}

- (void)makeClassViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.classCollectionView.backgroundColor = backColor;
    self.classCollectionView.delegate = self;
    self.classCollectionView.dataSource = self;
    [self.view addSubview:self.classCollectionView];
    
    [self.classCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.classCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.classArr objectAtIndex:indexPath.row];
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
    TheClassInformationViewController *theClassInformationVC = [TheClassInformationViewController new];
    [self.navigationController pushViewController:theClassInformationVC animated:YES];
    
}



@end
