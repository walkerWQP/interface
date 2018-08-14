//
//  AskLeaveViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "AskLeaveViewController.h"
#import "TotalNumberCell.h"
#import "TotalNumberModel.h"
#import "QianDaoViewController.h"
#import "LeaveTheDetailsViewController.h"

@interface AskLeaveViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *askLeaveArr;
@property (nonatomic, strong) UICollectionView *askLeaveCollectionView;
@property (nonatomic, strong) UIImageView *zanwushuju;

@end

@implementation AskLeaveViewController

- (NSMutableArray *)askLeaveArr {
    if (!_askLeaveArr) {
        _askLeaveArr = [NSMutableArray array];
    }
    return _askLeaveArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getClassConditionURLData:@"4"]; //请假
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    [self makeAskLeaveViewControllerUI];
}

- (void)getClassConditionURLData:(NSString *)type {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.askLeaveArr = [TotalNumberModel mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"students"]];
            if (self.askLeaveArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
                [self.askLeaveCollectionView reloadData];
            }
            [self.askLeaveCollectionView reloadData];
            
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

- (void)makeAskLeaveViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.askLeaveCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_HEIGHT * 0.15) collectionViewLayout:layout];
    self.askLeaveCollectionView.backgroundColor = backColor;
    self.askLeaveCollectionView.delegate = self;
    self.askLeaveCollectionView.dataSource = self;
    [self.view addSubview:self.askLeaveCollectionView];
    
    [self.askLeaveCollectionView registerClass:[TotalNumberCell class] forCellWithReuseIdentifier:TotalNumberCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.askLeaveArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    TotalNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TotalNumberCell_CollectionView forIndexPath:indexPath];
    TotalNumberModel *model = [self.askLeaveArr objectAtIndex:indexPath.row];
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
    TotalNumberModel *model = [self.askLeaveArr objectAtIndex:indexPath.row];
    LeaveTheDetailsViewController *LeaveTheDetailsVC = [[LeaveTheDetailsViewController alloc] init];
    switch (model.is_leave) {
        case 1:
        {
            NSLog(@"请假");
            if (model.ID == nil) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                LeaveTheDetailsVC.typeStr = @"1";
                LeaveTheDetailsVC.studentID= model.ID;
                
                [self.navigationController pushViewController:LeaveTheDetailsVC animated:YES];
            }
        }
            break;
        case 2:
        {
            NSLog(@"逃学");
            
        }
            break;
        case 3:
        {
            NSLog(@"签到");
        }
            break;
            
        default:
            break;
    }
    
}

@end
