//
//  PublicClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PublicClassViewController.h"
#import "PublicClassCell.h"
#import "PublicClassModel.h"
#import "VideoSettingsViewController.h"

@interface PublicClassViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *publicClassArr;
@property (nonatomic, strong) UICollectionView *publicClassCollectionView;
@property (nonatomic, strong) UIImageView *zanwushuju;

@end

@implementation PublicClassViewController

- (NSMutableArray *)publicClassArr {
    if (!_publicClassArr) {
        _publicClassArr = [NSMutableArray array];
    }
    return _publicClassArr;
}

- (void)viewDidLoad {  //公开课
    [super viewDidLoad];
    [self getDataFromMyPublishListURL];
    
    [self makePublicClassViewControllerUI];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.publicClassCollectionView addSubview:self.zanwushuju];
}

- (void)getDataFromMyPublishListURL {
    NSDictionary *dic = @{@"key":[UserManager key],@"is_charge":@"0"};
    [[HttpRequestManager sharedSingleton] POST:myPublishListURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publicClassArr = [PublicClassModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.publicClassArr.count == 0) {
                self.zanwushuju.alpha = 1;

            } else {
                self.zanwushuju.alpha = 0;
                [self.publicClassCollectionView reloadData];
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

- (void)makePublicClassViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.publicClassCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.publicClassCollectionView.backgroundColor = backColor;
    self.publicClassCollectionView.delegate = self;
    self.publicClassCollectionView.dataSource = self;
    [self.view addSubview:self.publicClassCollectionView];
    
    [self.publicClassCollectionView registerClass:[PublicClassCell class] forCellWithReuseIdentifier:PublicClassCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.publicClassArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *gridcell = nil;
    PublicClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublicClassCell_CollectionView forIndexPath:indexPath];
    PublicClassModel *model = [self.publicClassArr objectAtIndex:indexPath.row];
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
    PublicClassModel *model = [self.publicClassArr objectAtIndex:indexPath.row];
    VideoSettingsViewController *videoSettingsVC = [[VideoSettingsViewController alloc] init];
    videoSettingsVC.ID = model.ID;
    [self.navigationController pushViewController:videoSettingsVC animated:YES];
}

@end
