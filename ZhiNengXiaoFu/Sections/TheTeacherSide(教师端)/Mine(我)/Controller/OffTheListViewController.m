//
//  OffTheListViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OffTheListViewController.h"
#import "OffTheListCell.h"
#import "OffTheListModel.h"
#import "LeaveTheDetailsViewController.h"

@interface OffTheListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray   *offTheListArr;
@property (nonatomic, strong) UICollectionView *offTheListCollectionView;
@property (nonatomic, strong) UIImageView      *headImgView;
@property (nonatomic, strong) UIImageView      *zanwushuju;
@property (nonatomic, assign) NSInteger        page;

@end

@implementation OffTheListViewController

- (NSMutableArray *)offTheListArr {
    if (!_offTheListArr) {
        _offTheListArr = [NSMutableArray array];
    }
    return _offTheListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假列表";
    self.page = 1;
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeOffTheListViewControllerUI];
    //下拉刷新
    self.offTheListCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.offTheListCollectionView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.offTheListCollectionView.mj_header beginRefreshing];
    //上拉刷新
    self.offTheListCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.offTheListArr removeAllObjects];
    [self getOffTheListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getOffTheListData:self.page];
}

- (void)getOffTheListData:(NSInteger)page {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:leaveLeaveList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.offTheListCollectionView.mj_header endRefreshing];
        //结束尾部刷新
        [self.offTheListCollectionView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [OffTheListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (OffTheListModel *model in arr) {
                [self.offTheListArr addObject:model];
            }
            if (self.offTheListArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                
                [self.offTheListCollectionView reloadData];
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

- (void)makeOffTheListViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.offTheListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - 60) collectionViewLayout:layout];
    self.offTheListCollectionView.backgroundColor = backColor;
    self.offTheListCollectionView.delegate = self;
    self.offTheListCollectionView.dataSource = self;
    [self.view addSubview:self.offTheListCollectionView];
    
    [self.offTheListCollectionView registerClass:[OffTheListCell class] forCellWithReuseIdentifier:OffTheListCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.offTheListCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.offTheListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    OffTheListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OffTheListCell_CollectionView forIndexPath:indexPath];
    OffTheListModel *model = [self.offTheListArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
    cell.nameLabel.text = model.name;
    cell.timeLabel.text = [NSString stringWithFormat:@"%@:  %@%@%@",@"请假时间",model.start,@"至",model.end];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@:  %@",@"请假事由",model.reason];
    if (model.status == 0) {
        cell.typeLabel.text = @"审核中";
        cell.typeLabel.textColor = [UIColor redColor];
    } else if (model.status == 1) {
        cell.typeLabel.text = @"已批准";
        cell.typeLabel.textColor = contentColor;
    }
    
    gridcell = cell;
    return gridcell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, 160);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OffTheListModel *model = [self.offTheListArr objectAtIndex:indexPath.row];
    LeaveTheDetailsViewController *leaveTheDetailsVC = [LeaveTheDetailsViewController new];
    leaveTheDetailsVC.ID = model.ID;
    leaveTheDetailsVC.name = model.name;
    leaveTheDetailsVC.headImg = model.head_img;
    
    
    [self.navigationController pushViewController:leaveTheDetailsVC animated:YES];
    
}

@end
