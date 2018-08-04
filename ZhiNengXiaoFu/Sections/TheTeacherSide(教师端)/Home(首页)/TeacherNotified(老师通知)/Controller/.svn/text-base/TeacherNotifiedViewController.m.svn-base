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
#import "TeacherNotifiedModel.h"

@interface TeacherNotifiedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView * zanwushuju;

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
    
    [self getClassData];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    [self makeTeacherNotifiedViewControllerUI];
    

    
}

- (void)getClassData {
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.teacherNotifiedArr = [TeacherNotifiedModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.teacherNotifiedArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                
                [self.teacherNotifiedCollectionView reloadData];
            }
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
    
    UICollectionViewCell *gridcell = nil;
    TeacherNotifiedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeacherNotifiedCell_CollectionView forIndexPath:indexPath];
    TeacherNotifiedModel *model = [self.teacherNotifiedArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
    cell.classLabel.text = model.name;
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
    
    TeacherNotifiedModel *model = [self.teacherNotifiedArr objectAtIndex:indexPath.row];
    
    ClassDetailsViewController *ClassDetailsVC = [[ClassDetailsViewController alloc] init];
    ClassDetailsVC.titleStr = model.name;
    ClassDetailsVC.ID       = model.ID;
    [self.navigationController pushViewController:ClassDetailsVC animated:YES];
}

@end
