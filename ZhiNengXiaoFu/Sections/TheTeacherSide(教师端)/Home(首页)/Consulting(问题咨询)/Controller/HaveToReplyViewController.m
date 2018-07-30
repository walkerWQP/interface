//
//  HaveToReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HaveToReplyViewController.h"
#import "HaveToReplyCell.h"

@interface HaveToReplyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *haveToReplyArr;
@property (nonatomic, strong) UICollectionView *haveToReplyCollectionView;

@end

@implementation HaveToReplyViewController

- (NSMutableArray *)haveToReplyArr {
    if (!_haveToReplyArr) {
        _haveToReplyArr = [NSMutableArray array];
    }
    return _haveToReplyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *headImgArr = [NSMutableArray arrayWithObjects:@"user2",@"user2", nil];
    NSMutableArray *probleArr = [NSMutableArray arrayWithObjects:@"八一班李敏提问:",@"九一班李敏提问:", nil];
    NSMutableArray *problemContentArr = [NSMutableArray arrayWithObjects:@"学校本次运动会是什么时间？",@"学校本次运动会是什么时间？", nil];
     NSMutableArray *headImageArr = [NSMutableArray arrayWithObjects:@"user",@"user", nil];
    NSMutableArray *replyArr = [NSMutableArray arrayWithObjects:@"八一班体育老手回复:",@"九一班体育老手回复:", nil];
    NSMutableArray *replyContentArr = [NSMutableArray arrayWithObjects:@"2018.8.21-2018.8.23",@"2018.8.21-2018.8.23", nil];
    
    for (int i = 0; i < headImgArr.count; i++) {
        NSString *headImg = [headImgArr objectAtIndex:i];
        NSString *proble = [probleArr objectAtIndex:i];
        NSString *problemContent = [problemContentArr objectAtIndex:i];
        NSString *headImage = [headImageArr objectAtIndex:i];
        NSString *reply = [replyArr objectAtIndex:i];
        NSString *replyContent = [replyContentArr objectAtIndex:i];
        NSDictionary *dic = @{@"headImg":headImg, @"proble":proble, @"problemContent":problemContent, @"headImage":headImage, @"reply":reply, @"replyContent":replyContent};
        [self.haveToReplyArr addObject:dic];
    }
    [self makeHaveToReplyViewControllerUI];
}

- (void)makeHaveToReplyViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.haveToReplyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.haveToReplyCollectionView.backgroundColor = backColor;
    self.haveToReplyCollectionView.delegate = self;
    self.haveToReplyCollectionView.dataSource = self;
    [self.view addSubview:self.haveToReplyCollectionView];
    
    [self.haveToReplyCollectionView registerClass:[HaveToReplyCell class] forCellWithReuseIdentifier:HaveToReplyCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.haveToReplyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = [self.haveToReplyArr objectAtIndex:indexPath.row];
    UICollectionViewCell *gridcell = nil;
    HaveToReplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HaveToReplyCell_CollectionView forIndexPath:indexPath];
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"headImg"]];
    cell.problemLabel.text = [dic objectForKey:@"proble"];
    cell.problemContentLabel.text = [dic objectForKey:@"problemContent"];
    cell.headImageView.image = [UIImage imageNamed:[dic objectForKey:@"headImage"]];
    cell.replyLabel.text = [dic objectForKey:@"reply"];
    cell.replyContentLabel.text = [dic objectForKey:@"replyContent"];
    gridcell = cell;
    return gridcell;
    
}

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
    
}


@end
