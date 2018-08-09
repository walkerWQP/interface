//
//  ForClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ForClassViewController.h"
#import "PublicClassCell.h"
#import "PublicClassModel.h"
#import "VideoSettingsViewController.h"

@interface ForClassViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView    *noDataImgView;
@property (nonatomic, strong) NSMutableArray  *forClassArr;
@property (nonatomic, strong) UICollectionView *forClassCollectionView;

@end

@implementation ForClassViewController

- (NSMutableArray *)forClassArr {
    if (!_forClassArr) {
        _forClassArr = [NSMutableArray array];
    }
    return _forClassArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromMyPublishListURL];
    [self makeForClassViewControllerUI];
    self.noDataImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 105 / 2, 200, 105, 111)];
    self.noDataImgView.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.noDataImgView.alpha = 0;
    [self.view addSubview:self.noDataImgView];
    
}

- (void)getDataFromMyPublishListURL {
    NSDictionary *dic = @{@"key":[UserManager key],@"is_charge":@"0"};
    [[HttpRequestManager sharedSingleton] POST:myPublishListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.forClassArr = [PublicClassModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.forClassArr.count == 0) {
                self.noDataImgView.alpha = 1;
            } else {
                self.noDataImgView.alpha = 0;
                [self.forClassCollectionView reloadData];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)makeForClassViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.forClassCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.forClassCollectionView.backgroundColor = backColor;
    self.forClassCollectionView.delegate = self;
    self.forClassCollectionView.dataSource = self;
    [self.view addSubview:self.forClassCollectionView];
    
    [self.forClassCollectionView registerClass:[PublicClassCell class] forCellWithReuseIdentifier:PublicClassCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.forClassArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *gridcell = nil;
    PublicClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublicClassCell_CollectionView forIndexPath:indexPath];
    PublicClassModel *model = [self.forClassArr objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    cell.contentLabel.text = model.title;
    [cell.playBtn addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.setUpBtn addTarget:self action:@selector(setUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    gridcell = cell;
    return gridcell;
    
}

- (void)playBtn : (UIButton *)sender {
    NSLog(@"点击播放按钮");
}

- (void)setUpBtn : (UIButton *)sender {
    NSLog(@"点击设置");
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3 + 50);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    PublicClassModel *model = [self.forClassArr objectAtIndex:indexPath.row];
    VideoSettingsViewController *videoSettingsVC = [[VideoSettingsViewController alloc] init];
    videoSettingsVC.ID = model.ID;
    [self.navigationController pushViewController:videoSettingsVC animated:YES];
}

@end
