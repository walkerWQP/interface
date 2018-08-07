//
//  HasBeenViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HasBeenViewController.h"
#import "TotalNumberCell.h"
#import "QianDaoViewController.h"
#import "TotalNumberModel.h"

@interface HasBeenViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *hasBeenArr;
@property (nonatomic, strong) UICollectionView *hasBeenCollectionView;
@property (nonatomic, strong) UIImageView *zanwushuju;

@end

@implementation HasBeenViewController

- (NSMutableArray *)hasBeenArr {
    if(!_hasBeenArr) {
        _hasBeenArr = [NSMutableArray array];
    }
    return _hasBeenArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getClassConditionURLData:@"2"];
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeHasBeenViewControllerUI];
}

- (void)getClassConditionURLData:(NSString *)type {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.hasBeenArr = [TotalNumberModel mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"students"]];
            if (self.hasBeenArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                
                [self.hasBeenCollectionView reloadData];
            }
            [self.hasBeenCollectionView reloadData];
            
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

- (void)makeHasBeenViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.hasBeenCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_HEIGHT * 0.15) collectionViewLayout:layout];
    self.hasBeenCollectionView.backgroundColor = backColor;
    self.hasBeenCollectionView.delegate = self;
    self.hasBeenCollectionView.dataSource = self;
    [self.view addSubview:self.hasBeenCollectionView];
    
    [self.hasBeenCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hasBeenArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    TotalNumberModel *model = [self.hasBeenArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
    cell.nameLabel.text = model.name;
    if (model.is_leave == 0) { //未请假
        cell.nameLabel.textColor = [UIColor redColor];
    } else if (model.is_leave == 1) { //请假
        cell.nameLabel.textColor = THEMECOLOR;
    } else {
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
    qianDaoVC.studentId = self.ID;
    [self.navigationController pushViewController:qianDaoVC animated:YES];
}

@end
