//
//  SignViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SignViewController.h"
#import "TeacherNotifiedCell.h"
#import "SignClassViewController.h"

@interface SignViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *signArr;
@property (nonatomic, strong) UICollectionView *signCollectionView;
@property (nonatomic, strong) UIImageView  *headImgView;

@end

@implementation SignViewController

- (NSMutableArray *)signArr {
    if (!_signArr) {
        _signArr = [NSMutableArray array];
    }
    return _signArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    self.view.backgroundColor = backColor;
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"头像",@"头像",@"头像",@"头像", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级",@"九年级二班",@"六年级三班",@"四年级八班", nil];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        
        NSDictionary *dic = @{@"img":img,@"title":title};
        [self.signArr addObject:dic];
    }
    [self makeSignViewControllerUI];
}

- (void)makeSignViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.signCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.signCollectionView.backgroundColor = backColor;
    self.signCollectionView.delegate = self;
    self.signCollectionView.dataSource = self;
    [self.view addSubview:self.signCollectionView];
    
    [self.signCollectionView registerClass:[TeacherNotifiedCell class] forCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.signCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.signArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.signArr objectAtIndex:indexPath.row];
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
    SignClassViewController *signClassVC = [[SignClassViewController alloc] init];
    [self.navigationController pushViewController:signClassVC animated:YES];
    
}

@end
