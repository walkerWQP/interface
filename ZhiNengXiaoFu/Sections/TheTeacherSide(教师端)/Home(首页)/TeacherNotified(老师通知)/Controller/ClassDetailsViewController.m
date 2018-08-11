//
//  ClassDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassDetailsViewController.h"
#import "ClassDetailsCell.h"
#import "ClassDetailsModel.h"
#import "NoticeViewController.h"
#import "ClassNoticeViewController.h"
#import "TongZhiDetailsViewController.h"

@interface ClassDetailsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger     page;
@property (nonatomic, strong) UIImageView * zanwushuju;


@end

@implementation ClassDetailsViewController

- (NSMutableArray *)classDetailsArr {
    if (!_classDetailsArr) {
        _classDetailsArr = [NSMutableArray array];
    }
    return _classDetailsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    self.page  = 1;
    [self makeClassDetailsViewControllerUI];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    //下拉刷新
    self.classDetailsCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.classDetailsCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.classDetailsCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.classDetailsCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.classDetailsArr removeAllObjects];
    [self getNoticeListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getNoticeListData:self.page];
}

- (void)getNoticeListData:(NSInteger)page {
    
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key, @"page":[NSString stringWithFormat:@"%ld",page], @"is_school":@"0",@"class_id":self.ID};
    [[HttpRequestManager sharedSingleton] POST:noticeListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.classDetailsCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.classDetailsCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [ClassDetailsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ClassDetailsModel *model in arr) {
                [self.classDetailsArr addObject:model];
            }
            if (self.classDetailsArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.classDetailsCollectionView reloadData];
            }
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)makeClassDetailsViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.classDetailsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - 70) collectionViewLayout:layout];
    self.classDetailsCollectionView.backgroundColor = backColor;
    self.classDetailsCollectionView.delegate = self;
    self.classDetailsCollectionView.dataSource = self;
    [self.view addSubview:self.classDetailsCollectionView];
    
    [self.classDetailsCollectionView registerClass:[ClassDetailsCell class] forCellWithReuseIdentifier:ClassDetailsCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.classDetailsCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"banner"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classDetailsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDetailsModel *model = [self.classDetailsArr objectAtIndex:indexPath.row];
    
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
    ClassDetailsModel *model = [self.classDetailsArr objectAtIndex:indexPath.row];
    TongZhiDetailsViewController *tongZhiDetailsVC = [[TongZhiDetailsViewController alloc] init];
    if (model.ID == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        tongZhiDetailsVC.tongZhiId = model.ID;
        [self.navigationController pushViewController:tongZhiDetailsVC animated:YES];
    }
   
//    NoticeViewController *noticeVC = [NoticeViewController new];
//    [self.navigationController pushViewController:noticeVC animated:YES];
    
 }

- (void)rightBtn : (UIButton *)sender {
    
    ClassNoticeViewController *classNoticeVC = [[ClassNoticeViewController alloc] init];
    classNoticeVC.classID = self.ID;
    [self.navigationController pushViewController:classNoticeVC animated:YES];
}

@end
