//
//  HomeWorkViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "ClassDetailsCell.h"
#import "HomeWorkModel.h"
#import "PublishJobViewController.h"
#import "WorkDetailsViewController.h"

@interface HomeWorkViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *zanwushuju;
@property (nonatomic, assign) NSInteger   page;

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
    
    self.title = self.titleStr;
    self.page = 1;
    [self getWorkHomeWorkListData];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    [self makeHomeWorkViewControllerUI];
    
}

- (void)getWorkHomeWorkListData {
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key,@"class_id":self.ID,@"page":[NSString stringWithFormat:@"%ld",self.page]};
    [[HttpRequestManager sharedSingleton] POST:workHomeWorkList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.homeWorkArr = [HomeWorkModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.homeWorkArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                
                [self.homeWorkCollectionView reloadData];
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
    
    
    UICollectionViewCell *gridcell = nil;
    ClassDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassDetailsCell_CollectionView forIndexPath:indexPath];
    HomeWorkModel  *model = [self.homeWorkArr objectAtIndex:indexPath.row];
    cell.headImgView.image = [UIImage imageNamed:@"通知图标"];
    cell.titleLabel.text = model.title;
//    cell.subjectsLabel.text = model.abstract;
    cell.timeLabel.text = model.create_time;
    [cell.delegateBtn addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
    gridcell = cell;
    return gridcell;
    
}

- (void)delegateBtn : (UIButton *)sender {
    NSLog(@"删除"); //workDeleteHomeWork
    
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSLog(@"%@",indexPaths);
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
    
     HomeWorkModel  *model = [self.homeWorkArr objectAtIndex:indexPath.row];
    
    WorkDetailsViewController *workDetailsVC = [[WorkDetailsViewController alloc] init];
    workDetailsVC.workId = model.ID;
    [self.navigationController pushViewController:workDetailsVC animated:YES];
}

- (void)rightBtn:(UIButton *)sender {
    
    NSLog(@"点击发布通知");
    PublishJobViewController *publishJobVC = [[PublishJobViewController alloc] init];
    publishJobVC.classID = self.ID;
    [self.navigationController pushViewController:publishJobVC animated:YES];
    
}

@end
