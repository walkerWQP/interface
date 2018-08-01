//
//  DidNotReturnViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DidNotReturnViewController.h"
#import "DidNotReturnCell.h"
#import "ReplyViewController.h"

@interface DidNotReturnViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *didNotReturnArr;
@property (nonatomic, strong) UICollectionView *didNotReturnCollectionView;

@end

@implementation DidNotReturnViewController

- (NSMutableArray *)didNotReturnArr {
    if (!_didNotReturnArr) {
        _didNotReturnArr = [NSMutableArray array];
    }
    return _didNotReturnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *headImgArr = [NSMutableArray arrayWithObjects:@"user2",@"user2", nil];
    NSMutableArray *probleArr = [NSMutableArray arrayWithObjects:@"八一班李敏提问:",@"九一班李敏提问:", nil];
    NSMutableArray *problemContentArr = [NSMutableArray arrayWithObjects:@"学校本次运动会是什么时间？",@"学校本次运动会是什么时间？", nil];
    for (int i = 0; i < headImgArr.count; i++) {
        NSString *headImg = [headImgArr objectAtIndex:i];
        NSString *proble = [probleArr objectAtIndex:i];
        NSString *problemContent = [problemContentArr objectAtIndex:i];
        NSDictionary *dic = @{@"headImg":headImg, @"proble":proble, @"problemContent":problemContent};
        [self.didNotReturnArr addObject:dic];
    }
    [self makeDidNotReturnViewControllerUI];
}

- (void)makeDidNotReturnViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.didNotReturnCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.didNotReturnCollectionView.backgroundColor = backColor;
    self.didNotReturnCollectionView.delegate = self;
    self.didNotReturnCollectionView.dataSource = self;
    [self.view addSubview:self.didNotReturnCollectionView];
    
    [self.didNotReturnCollectionView registerClass:[DidNotReturnCell class] forCellWithReuseIdentifier:DidNotReturnCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.didNotReturnArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.didNotReturnArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    DidNotReturnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DidNotReturnCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"headImg"]];
    cell.problemLabel.text = [dic objectForKey:@"proble"];
    cell.problemContentLabel.text = [dic objectForKey:@"problemContent"];
//    [cell.answerBtn addTarget:self action:@selector(answerBtn:) forControlEvents:UIControlEventTouchUpInside];
    gridcell = cell;
    return gridcell;
    
}

//- (void)answerBtn : (UIButton *)sender {
//    NSLog(@"点击回答咨询");
//    
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
    ReplyViewController *replyVC = [[ReplyViewController alloc] init];
    [self.navigationController pushViewController:replyVC animated:YES];
    
}


@end
