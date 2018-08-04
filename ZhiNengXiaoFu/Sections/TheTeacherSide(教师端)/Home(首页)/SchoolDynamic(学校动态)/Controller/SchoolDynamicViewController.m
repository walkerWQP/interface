//
//  SchoolDynamicViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDynamicViewController.h"
#import "SchoolDynamicCellCell.h"
#import "SchoolDynamicModel.h"
#import "SchoolInformationViewController.h"

@interface SchoolDynamicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *schoolDynamicCollectionView;
@property (nonatomic, strong) NSMutableArray  *schoolDynamicArr;
@property (nonatomic, strong) UIImageView  *headImgView;
@property (nonatomic, assign) NSInteger     page;
@property (nonatomic, strong) UIImageView *zanwushuju;

@end

@implementation SchoolDynamicViewController

- (NSMutableArray *)schoolDynamicArr {
    if (!_schoolDynamicArr) {
        _schoolDynamicArr = [NSMutableArray array];
    }
    return _schoolDynamicArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校动态";
    self.page = 1;
    [self getDynamicGetListData];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    [self makeSchoolDynamicViewControllerUI];
    
}

- (void)getDynamicGetListData {
    
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key,@"page":[NSString stringWithFormat:@"%ld",self.page]};
    [[HttpRequestManager sharedSingleton] POST:dynamicGetList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.schoolDynamicArr = [SchoolDynamicModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.schoolDynamicArr.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                [self.schoolDynamicCollectionView reloadData];
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

- (void)makeSchoolDynamicViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(190, 0, 0, 0);
    self.schoolDynamicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - 70) collectionViewLayout:layout];
    self.schoolDynamicCollectionView.backgroundColor = backColor;
    self.schoolDynamicCollectionView.delegate = self;
    self.schoolDynamicCollectionView.dataSource = self;
    [self.view addSubview:self.schoolDynamicCollectionView];
    
    [self.schoolDynamicCollectionView registerClass:[SchoolDynamicCellCell class] forCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self.schoolDynamicCollectionView addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:@"homepagelunbo2"];
    
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.schoolDynamicArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    SchoolDynamicCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SchoolDynamicCellCell_CollectionView forIndexPath:indexPath];
    SchoolDynamicModel *model = [self.schoolDynamicArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.titleLabel.text = model.title;
//    cell.subjectsLabel.text = [dic objectForKey:@"content"];
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
    SchoolDynamicModel *model = [self.schoolDynamicArr objectAtIndex:indexPath.row];
    SchoolInformationViewController *schoolInformationVC = [[SchoolInformationViewController alloc] init];
    schoolInformationVC.ID = model.ID;
    [self.navigationController pushViewController:schoolInformationVC animated:YES];
}


@end
