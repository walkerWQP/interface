//
//  SchoolNoticeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolNoticeViewController.h"
#import "ClassDetailsCell.h"
#import "ClassDetailsModel.h"
#import "NoticeViewController.h"
#import "TongZhiDetailsViewController.h"

@interface SchoolNoticeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger     page;
@property (nonatomic, strong) UIImageView * zanwushuju;
@property (nonatomic, strong) NSMutableArray  *schoolNoticeArr;
@property (nonatomic, strong) UICollectionView *schoolNoticeCollectionView;
@property (nonatomic, strong) UIImageView  *headImgView;


@end

@implementation SchoolNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校通知";
    self.page  = 1;
    [self getNoticeListData];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self mkeSchoolNoticeViewControllerUI];
    
}

- (void)getNoticeListData {
    
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key, @"page":[NSString stringWithFormat:@"%ld",self.page],@"is_school":@"1"};
    [[HttpRequestManager sharedSingleton] POST:noticeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.schoolNoticeArr = [ClassDetailsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.schoolNoticeArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                
                [self.schoolNoticeCollectionView reloadData];
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

- (void)mkeSchoolNoticeViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.schoolNoticeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT) collectionViewLayout:layout];
    self.schoolNoticeCollectionView.backgroundColor = backColor;
    self.schoolNoticeCollectionView.delegate = self;
    self.schoolNoticeCollectionView.dataSource = self;
    [self.view addSubview:self.schoolNoticeCollectionView];
    
    [self.schoolNoticeCollectionView registerClass:[ClassDetailsCell class] forCellWithReuseIdentifier:ClassDetailsCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.schoolNoticeCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.schoolNoticeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDetailsModel *model = [self.schoolNoticeArr objectAtIndex:indexPath.row];
    
    UICollectionViewCell *gridcell = nil;
    ClassDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassDetailsCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:@"通知图标"];
    cell.titleLabel.text = model.title;
    //    cell.subjectsLabel.text = model.abstract;
    cell.timeLabel.text = model.create_time;
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
    ClassDetailsModel *model = [self.schoolNoticeArr objectAtIndex:indexPath.row];
    TongZhiDetailsViewController *tongZhiDetailsVC = [[TongZhiDetailsViewController alloc] init];
    tongZhiDetailsVC.tongZhiId = model.ID;
    [self.navigationController pushViewController:tongZhiDetailsVC animated:YES];
    
}




@end
