//
//  TotalNumberViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TotalNumberViewController.h"
#import "TotalNumberCell.h"
#import "TotalNumberModel.h"
#import "QianDaoViewController.h"

@interface TotalNumberViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *totalNumberArr;
@property (nonatomic, strong) UICollectionView *totalNumberCollectionView;
@property (nonatomic, strong) UIImageView *zanwushuju;

@end

@implementation TotalNumberViewController

- (NSMutableArray *)totalNumberArr {
    if (!_totalNumberArr) {
        _totalNumberArr = [NSMutableArray array];
    }
    return _totalNumberArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.ID);
    
    //总数
    [self getClassConditionURLData:@"1"];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeTotalNumberViewControllerUI];
}

- (void)getClassConditionURLData:(NSString *)type {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
           self.totalNumberArr = [TotalNumberModel mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"students"]];
            if (self.totalNumberArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.totalNumberCollectionView reloadData];
            }
            [self.totalNumberCollectionView reloadData];
            
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

- (void)makeTotalNumberViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.totalNumberCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_HEIGHT * 0.15) collectionViewLayout:layout];
    self.totalNumberCollectionView.backgroundColor = backColor;
    self.totalNumberCollectionView.delegate = self;
    self.totalNumberCollectionView.dataSource = self;
    [self.view addSubview:self.totalNumberCollectionView];
    
    [self.totalNumberCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalNumberArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    TotalNumberModel *model = [self.totalNumberArr objectAtIndex:indexPath.row];
    if (model.head_img == nil) {
        cell.headImgView.image = [UIImage imageNamed:@"user"];
    } else {
        [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
    }
    cell.nameLabel.text = model.name;
    if (model.is_leave == 1) { //1请假
        cell.nameLabel.textColor = THEMECOLOR;
    } else if (model.is_leave == 2) { //2逃学
        cell.nameLabel.textColor = [UIColor redColor];
    } else if (model.is_leave == 3) { //3签到
        cell.nameLabel.textColor = titlColor;
    }
    gridcell = cell;
    return gridcell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 20;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;

    itemSize = CGSizeMake((APP_WIDTH - 45) / 3, APP_HEIGHT * 0.15);

    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    QianDaoViewController *qianDaoVC = [[QianDaoViewController alloc] init];
    if (self.ID == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        qianDaoVC.studentId = self.ID;
        [self.navigationController pushViewController:qianDaoVC animated:YES];
    }
    
}

@end
